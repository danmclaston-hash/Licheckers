import 'dart:math';
import 'dart:typed_data';

import 'move.dart';
import 'rules.dart';

/// Piece codes stored on the board.
const int empty = 0, wMan = 1, wKing = 2, bMan = 3, bKing = 4;

/// Added to a piece during move generation: "already captured, still on board".
const int capturedFlag = 8;

const int white = 0, black = 1;

int sideOf(int piece) => (piece - 1) >> 1;
bool isKing(int piece) => piece == wKing || piece == bKing;

/// Random numbers used to give every position a short fingerprint (Zobrist).
class _Zobrist {
  final List<Uint32List> lo, hi;
  final int sideLo, sideHi;
  _Zobrist(this.lo, this.hi, this.sideLo, this.sideHi);

  static final Map<int, _Zobrist> _cache = {};

  static _Zobrist forSize(int n) => _cache.putIfAbsent(n, () {
        final rng = Random(n * 7919 + 13);
        // Written as a plain number: on the web "1 << 32" overflows.
        int r() => rng.nextInt(4294967296);
        Uint32List row() =>
            Uint32List.fromList(List.generate(n * n, (_) => r()));
        return _Zobrist(
          List.generate(5, (_) => row()),
          List.generate(5, (_) => row()),
          r(),
          r(),
        );
      });
}

/// A board + whose turn it is. Never changed in place: [apply] returns a new one.
class Position {
  final VariantRules rules;
  final Uint8List board;
  final int turn;

  /// Plies since the last capture or man move (for the draw rule).
  final int noProgress;

  /// Frisian: square of the king that made the last plain king move(s), per
  /// side, and how many in a row.
  final int runSqW, runSqB, runCountW, runCountB;

  /// Fingerprint halves (each fits in 32 bits, so it also works on the web).
  final int hashLo, hashHi;

  Position._(this.rules, this.board, this.turn, this.noProgress, this.runSqW,
      this.runSqB, this.runCountW, this.runCountB, this.hashLo, this.hashHi);

  int get size => rules.size;

  /// One number that identifies this position (safe on web: below 2^53).
  int get key => (hashHi & 0xFFFFF) * 4294967296 + hashLo;

  factory Position._build(VariantRules rules, Uint8List board, int turn) {
    final z = _Zobrist.forSize(rules.size);
    var lo = turn == black ? z.sideLo : 0, hi = turn == black ? z.sideHi : 0;
    for (var i = 0; i < board.length; i++) {
      final p = board[i];
      if (p != 0) {
        lo ^= z.lo[p][i];
        hi ^= z.hi[p][i];
      }
    }
    return Position._(rules, board, turn, 0, -1, -1, 0, 0, lo, hi);
  }

  /// The starting position of a variant.
  factory Position.initial(VariantRules rules) {
    final n = rules.size;
    final b = Uint8List(n * n);
    for (var i = 0; i < rules.menRows; i++) {
      final rb = rules.firstMenRow + i;
      final rw = n - 1 - rules.firstMenRow - i;
      for (var c = 0; c < n; c++) {
        if (rules.playable(rb, c)) b[rb * n + c] = bMan;
        if (rules.playable(rw, c)) b[rw * n + c] = wMan;
      }
    }
    return Position._build(rules, b, rules.firstMover);
  }

  /// Build a position from text rows, top row first.
  /// '.' empty, 'w' white man, 'W' white king, 'b' black man, 'B' black king.
  factory Position.fromRows(VariantRules rules, List<String> rows, int turn) {
    final n = rules.size;
    if (rows.length != n) throw ArgumentError('need $n rows');
    final b = Uint8List(n * n);
    for (var r = 0; r < n; r++) {
      if (rows[r].length != n) throw ArgumentError('row $r needs $n squares');
      for (var c = 0; c < n; c++) {
        final p = const {'w': wMan, 'W': wKing, 'b': bMan, 'B': bKing}[rows[r][c]];
        if (p == null) continue;
        if (!rules.playable(r, c)) {
          throw ArgumentError('square row $r col $c is not used in ${rules.name}');
        }
        b[r * n + c] = p;
      }
    }
    return Position._build(rules, b, turn);
  }

  int count(int piece) {
    var k = 0;
    for (final p in board) {
      if (p == piece) k++;
    }
    return k;
  }

  /// Play a move and get the new position. The move must come from
  /// [legalMoves]; this method does not check it again.
  Position apply(Move m) {
    final z = _Zobrist.forSize(rules.size);
    final b = Uint8List.fromList(board);
    var lo = hashLo ^ z.sideLo, hi = hashHi ^ z.sideHi;
    final piece = b[m.from];
    b[m.from] = 0;
    lo ^= z.lo[piece][m.from];
    hi ^= z.hi[piece][m.from];
    for (final c in m.captured) {
      final cp = b[c];
      lo ^= z.lo[cp][c];
      hi ^= z.hi[cp][c];
      b[c] = 0;
    }
    final placed = m.promote ? (turn == white ? wKing : bKing) : piece;
    b[m.to] = placed;
    lo ^= z.lo[placed][m.to];
    hi ^= z.hi[placed][m.to];

    final manMoved = !isKing(piece);
    final np = (m.isCapture || manMoved) ? 0 : noProgress + 1;

    var rsW = runSqW, rsB = runSqB, rcW = runCountW, rcB = runCountB;
    if (rules.kingPlainMoveLimit != null) {
      final plainKing = !manMoved && !m.isCapture;
      if (turn == white) {
        rcW = plainKing ? (rsW == m.from ? rcW + 1 : 1) : 0;
        rsW = plainKing ? m.to : -1;
        if (m.captured.contains(rsB)) {
          rsB = -1;
          rcB = 0;
        }
      } else {
        rcB = plainKing ? (rsB == m.from ? rcB + 1 : 1) : 0;
        rsB = plainKing ? m.to : -1;
        if (m.captured.contains(rsW)) {
          rsW = -1;
          rcW = 0;
        }
      }
    }
    return Position._(rules, b, 1 - turn, np, rsW, rsB, rcW, rcB, lo, hi);
  }

  @override
  String toString() {
    final n = rules.size;
    final sb = StringBuffer();
    for (var r = 0; r < n; r++) {
      for (var c = 0; c < n; c++) {
        sb.write('.wWbB'[board[r * n + c]]);
      }
      sb.writeln();
    }
    sb.write(turn == white ? 'white to move' : 'black to move');
    return sb.toString();
  }
}
