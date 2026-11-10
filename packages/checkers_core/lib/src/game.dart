import 'move.dart';
import 'movegen.dart';
import 'position.dart';
import 'rules.dart';

enum GameResult { ongoing, whiteWins, blackWins, draw }

/// A whole game: the position, the moves played, and the result.
/// The app and the server both use this class, so they always agree.
class Game {
  final VariantRules rules;
  Position position;
  final List<Move> moves = [];
  final List<Position> history = [];
  final Map<int, int> _seen = {};
  GameResult result = GameResult.ongoing;
  String? reason;
  late List<Move> _legal;

  Game(this.rules, {Position? start})
      : position = start ?? Position.initial(rules) {
    _seen[position.key] = 1;
    _legal = legalMoves(position);
    _checkEnd();
  }

  List<Move> get legal => result == GameResult.ongoing ? _legal : const [];

  /// Legal moves that start on [square] (for highlighting in the app).
  List<Move> movesFrom(int square) =>
      [for (final m in legal) if (m.from == square) m];

  /// Play a move. Returns false (and changes nothing) if it is not legal.
  /// The server calls this for every move a player sends.
  bool play(Move move) {
    if (result != GameResult.ongoing) return false;
    Move? real;
    for (final m in _legal) {
      if (m.sameAs(move)) {
        real = m;
        break;
      }
    }
    if (real == null) return false;
    history.add(position);
    moves.add(real);
    position = position.apply(real);
    _seen[position.key] = (_seen[position.key] ?? 0) + 1;
    _legal = legalMoves(position);
    _checkEnd();
    return true;
  }

  /// Keys of all positions so far (the engine uses this to avoid repeating).
  Iterable<int> get seenKeys => _seen.keys;

  void _checkEnd() {
    if (_legal.isEmpty) {
      result = position.turn == white
          ? GameResult.blackWins
          : GameResult.whiteWins;
      reason = 'no legal moves';
    } else if ((_seen[position.key] ?? 0) >= 3) {
      result = GameResult.draw;
      reason = 'same position three times';
    } else if (position.noProgress >= rules.drawPlies) {
      result = GameResult.draw;
      reason = '${rules.drawPlies ~/ 2} moves each without progress';
    }
  }
}
