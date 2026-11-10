import 'dart:typed_data';

import 'move.dart';
import 'position.dart';
import 'rules.dart';

/// Every legal move for the side to move. An empty list means that side has
/// lost (no pieces, or blocked).
List<Move> legalMoves(Position pos) => _Gen(pos).run();

class _Gen {
  final Position pos;
  final VariantRules r;
  final int n;
  final Uint8List b;
  final int side;
  final int sign; // +1 white (moves up), -1 black
  final int promoRow;

  final List<Move> caps = [];
  final List<int> path = [];
  final List<int> captured = [];
  final List<int> kinds = [];
  int from = 0;
  bool fromIsKing = false;

  _Gen(this.pos)
      : r = pos.rules,
        n = pos.rules.size,
        b = Uint8List.fromList(pos.board),
        side = pos.turn,
        sign = pos.turn == white ? 1 : -1,
        promoRow = pos.turn == white ? 0 : pos.rules.size - 1;

  bool inside(int row, int col) => row >= 0 && row < n && col >= 0 && col < n;

  List<Move> run() {
    // 1) Captures. They are compulsory in all variants.
    for (var sq = 0; sq < b.length; sq++) {
      final p = b[sq];
      if (p == 0 || sideOf(p) != side) continue;
      from = sq;
      fromIsKing = isKing(p);
      b[sq] = 0; // the piece is "in the hand" while it jumps
      _dfs(sq, fromIsKing, 0, 0, false);
      b[sq] = p;
    }
    if (caps.isNotEmpty) return _dedupe(_applyPriority(caps));

    // 2) Plain moves.
    final out = <Move>[];
    var hasMen = false;
    if (r.kingPlainMoveLimit != null) {
      hasMen = pos.count(side == white ? wMan : bMan) > 0;
    }
    final runSq = side == white ? pos.runSqW : pos.runSqB;
    final runCount = side == white ? pos.runCountW : pos.runCountB;
    for (var sq = 0; sq < b.length; sq++) {
      final p = b[sq];
      if (p == 0 || sideOf(p) != side) continue;
      final row = sq ~/ n, col = sq % n;
      if (!isKing(p)) {
        for (final d in r.manMoveDirs) {
          final tr = row + d.dr * sign, tc = col + d.dc;
          if (!inside(tr, tc) || b[tr * n + tc] != 0) continue;
          out.add(Move(sq, tr * n + tc,
              path: [tr * n + tc], promote: tr == promoRow));
        }
      } else {
        if (hasMen && runSq == sq && runCount >= r.kingPlainMoveLimit!) {
          continue; // Frisian: this king must rest
        }
        for (final d in r.kingMoveDirs) {
          var tr = row + d.dr, tc = col + d.dc;
          while (inside(tr, tc) && b[tr * n + tc] == 0) {
            out.add(Move(sq, tr * n + tc, path: [tr * n + tc], moverIsKing: true));
            if (!r.flyingKings) break;
            tr += d.dr;
            tc += d.dc;
          }
        }
      }
    }
    return out;
  }

  void _take(int mid, int piece) {
    b[mid] = r.removeAsJumped ? 0 : piece | capturedFlag;
    captured.add(mid);
    kinds.add(piece);
  }

  void _untake(int mid, int piece) {
    b[mid] = piece;
    captured.removeLast();
    kinds.removeLast();
  }

  void _emit(bool promotedMid) {
    final to = path.last;
    var kings = 0, first = 999;
    for (var i = 0; i < kinds.length; i++) {
      if (isKing(kinds[i])) {
        kings++;
        if (first == 999) first = i;
      }
    }
    caps.add(Move(
      from,
      to,
      path: List.of(path),
      captured: List.of(captured),
      promote: promotedMid || (!fromIsKing && to ~/ n == promoRow),
      moverIsKing: fromIsKing,
      kingsCaptured: kings,
      firstKingAt: first,
    ));
  }

  /// Try every jump from [sq]. If there is none, the chain so far is a move.
  void _dfs(int sq, bool king, int lastDr, int lastDc, bool promotedMid) {
    final row = sq ~/ n, col = sq % n;
    var any = false;
    final dirs = king ? r.kingCaptureDirs : r.manCaptureDirs;
    for (final d in dirs) {
      final dr = d.dr * sign, dc = d.dc;
      if (r.noTurnBack && path.isNotEmpty && dr == -lastDr && dc == -lastDc) {
        continue;
      }
      if (king && r.flyingKings) {
        var rr = row + dr, cc = col + dc;
        while (inside(rr, cc) && b[rr * n + cc] == 0) {
          rr += dr;
          cc += dc;
        }
        if (!inside(rr, cc)) continue;
        final mid = rr * n + cc, mp = b[mid];
        if (mp >= capturedFlag || sideOf(mp) == side) continue;
        final lands = <int>[];
        var lr = rr + dr, lc = cc + dc;
        while (inside(lr, lc) && b[lr * n + lc] == 0) {
          lands.add(lr * n + lc);
          if (r.kingLandsRightBehind) break;
          lr += dr;
          lc += dc;
        }
        if (lands.isEmpty) continue;
        any = true;
        _take(mid, mp);
        // If some landing squares let the king keep capturing, it must use one.
        final cont = [
          for (final l in lands)
            if (_canJump(l, true, dr, dc)) l
        ];
        if (cont.isEmpty) {
          for (final l in lands) {
            path.add(l);
            _emit(promotedMid);
            path.removeLast();
          }
        } else {
          for (final l in cont) {
            path.add(l);
            _dfs(l, true, dr, dc, promotedMid);
            path.removeLast();
          }
        }
        _untake(mid, mp);
      } else {
        final mr = row + dr, mc = col + dc, lr = row + 2 * dr, lc = col + 2 * dc;
        if (!inside(lr, lc)) continue;
        final mid = mr * n + mc, land = lr * n + lc, mp = b[mid];
        if (mp == 0 || mp >= capturedFlag || sideOf(mp) == side) continue;
        if (!king && !r.menCanCaptureKings && isKing(mp)) continue;
        if (b[land] != 0) continue;
        any = true;
        _take(mid, mp);
        path.add(land);
        final reached = !king && lr == promoRow;
        if (reached && r.midPromo == MidPromo.stop) {
          _emit(true);
        } else if (reached && r.midPromo == MidPromo.asKing) {
          _dfs(land, true, dr, dc, true);
        } else {
          _dfs(land, king, dr, dc, promotedMid);
        }
        path.removeLast();
        _untake(mid, mp);
      }
    }
    if (!any && captured.isNotEmpty) _emit(promotedMid);
  }

  /// Quick yes/no: can a piece standing on [sq] jump something right now?
  bool _canJump(int sq, bool king, int lastDr, int lastDc) {
    final row = sq ~/ n, col = sq % n;
    final dirs = king ? r.kingCaptureDirs : r.manCaptureDirs;
    for (final d in dirs) {
      final dr = d.dr * sign, dc = d.dc;
      if (r.noTurnBack && dr == -lastDr && dc == -lastDc) continue;
      if (king && r.flyingKings) {
        var rr = row + dr, cc = col + dc;
        while (inside(rr, cc) && b[rr * n + cc] == 0) {
          rr += dr;
          cc += dc;
        }
        if (!inside(rr, cc)) continue;
        final mp = b[rr * n + cc];
        if (mp >= capturedFlag || sideOf(mp) == side) continue;
        final lr = rr + dr, lc = cc + dc;
        if (inside(lr, lc) && b[lr * n + lc] == 0) return true;
      } else {
        final lr = row + 2 * dr, lc = col + 2 * dc;
        if (!inside(lr, lc)) continue;
        final mp = b[(row + dr) * n + col + dc];
        if (mp == 0 || mp >= capturedFlag || sideOf(mp) == side) continue;
        if (!king && !r.menCanCaptureKings && isKing(mp)) continue;
        if (b[lr * n + lc] == 0) return true;
      }
    }
    return false;
  }

  List<Move> _applyPriority(List<Move> all) {
    int best(int Function(Move) f, List<Move> l) =>
        l.fold(-1000000000, (a, m) => f(m) > a ? f(m) : a);
    List<Move> keep(int Function(Move) f, List<Move> l) {
      final top = best(f, l);
      return [for (final m in l) if (f(m) == top) m];
    }

    switch (r.priority) {
      case Priority.none:
        return all;
      case Priority.maxCount:
        return keep((m) => m.captured.length, all);
      case Priority.spanish:
        return keep((m) => m.kingsCaptured, keep((m) => m.captured.length, all));
      case Priority.italian:
        var l = keep((m) => m.captured.length, all);
        l = keep((m) => m.moverIsKing ? 1 : 0, l);
        l = keep((m) => m.kingsCaptured, l);
        return keep((m) => -m.firstKingAt, l);
      case Priority.frisian:
        final l = keep(
            (m) => m.kingsCaptured * 199 + (m.captured.length - m.kingsCaptured) * 100,
            all);
        return keep((m) => m.moverIsKing ? 1 : 0, l);
    }
  }

  /// Two chains that start and end on the same squares and take the same
  /// pieces are one move for the players.
  List<Move> _dedupe(List<Move> l) {
    if (l.length < 2) return l;
    final out = <Move>[];
    outer:
    for (final m in l) {
      for (final o in out) {
        if (o.sameAs(m)) continue outer;
      }
      out.add(m);
    }
    return out;
  }
}

/// perft = count every line of play to a given depth. Used to prove the
/// move generator is right by comparing with trusted numbers.
int perft(Position pos, int depth) {
  final moves = legalMoves(pos);
  if (depth == 1) return moves.length;
  var total = 0;
  for (final m in moves) {
    total += perft(pos.apply(m), depth - 1);
  }
  return total;
}
