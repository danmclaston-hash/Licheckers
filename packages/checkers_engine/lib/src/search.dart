import 'dart:typed_data';

import 'package:checkers_core/checkers_core.dart';

import 'eval.dart';

class RootMove {
  final Move move;
  int score;
  RootMove(this.move, this.score);
}

class SearchResult {
  final Move best;
  final int score; // for the side to move; 100 = one man
  final int depth; // deepest fully finished search
  final int nodes;

  /// Every legal move with its score, best first. Scores are exact only when
  /// [Searcher.search] was called with `scoreAllMoves: true`.
  final List<RootMove> root;
  SearchResult(this.best, this.score, this.depth, this.nodes, this.root);
}

class _Entry {
  int depth, score, flag; // flag: 0 exact, 1 lower bound, 2 upper bound
  Move? move;
  _Entry(this.depth, this.score, this.flag, this.move);
}

class _OutOfTime implements Exception {}

/// Looks ahead move by move (alpha-beta search) and picks the best line.
///
/// Speed-ups, in plain words:
///  - iterative deepening: search 1 move deep, then 2, then 3... so there is
///    always an answer ready when time runs out
///  - memory (transposition table): a position reached by two move orders is
///    only searched once
///  - move ordering: try the likely-best move first, so bad lines are cut early
///  - never stop in the middle of a forced capture (quiescence)
class Searcher {
  final Map<int, _Entry> _tt = {};
  Int32List _history = Int32List(0);
  final Set<int> _path = {};
  Set<int> _game = const {};
  int _nodes = 0;
  int _deadline = 0;
  final Stopwatch _clock = Stopwatch();

  SearchResult search(
    Position pos, {
    int maxDepth = 64,
    int? timeMs,
    Iterable<int> history = const [],
    bool scoreAllMoves = false,
  }) {
    final moves = legalMoves(pos);
    if (moves.isEmpty) throw StateError('no legal moves: the game is over');
    final root = [for (final m in moves) RootMove(m, 0)];
    if (moves.length == 1) return SearchResult(moves[0], 0, 0, 0, root);

    final n2 = pos.board.length;
    if (_history.length != n2 * n2) _history = Int32List(n2 * n2);
    if (_tt.length > 1500000) _tt.clear();
    _game = history.toSet()..remove(pos.key);
    _path.clear();
    _nodes = 0;
    _clock
      ..reset()
      ..start();
    _deadline = timeMs ?? (1 << 40);

    var done = 0;
    var best = root[0];
    var bestScore = 0;
    for (var depth = 1; depth <= maxDepth; depth++) {
      final scores = List<int>.filled(root.length, 0);
      try {
        var alpha = -mateScore, i = 0;
        _path.add(pos.key);
        for (final rm in root) {
          final child = pos.apply(rm.move);
          int s;
          if (scoreAllMoves || i == 0) {
            s = -_search(child, depth - 1, -mateScore, mateScore, 1);
          } else {
            s = -_search(child, depth - 1, -alpha - 1, -alpha, 1);
            if (s > alpha) {
              s = -_search(child, depth - 1, -mateScore, -alpha, 1);
            }
          }
          scores[i++] = s;
          if (s > alpha) alpha = s;
        }
        _path.remove(pos.key);
      } on _OutOfTime {
        _path.clear();
        break;
      }
      for (var i = 0; i < root.length; i++) {
        root[i].score = scores[i];
      }
      // Stable sort: best first, earlier order kept on ties.
      final sorted = List.of(root);
      final index = {for (var i = 0; i < root.length; i++) root[i]: i};
      sorted.sort((a, b) =>
          b.score != a.score ? b.score - a.score : index[a]! - index[b]!);
      root.setAll(0, sorted);
      best = root[0];
      bestScore = best.score;
      done = depth;
      if (bestScore.abs() > mateScore - 200) break; // forced win or loss found
      if (timeMs != null && _clock.elapsedMilliseconds > timeMs ~/ 2) break;
    }
    return SearchResult(best.move, bestScore, done, _nodes, root);
  }

  int _search(Position p, int depth, int alpha, int beta, int ply) {
    if ((++_nodes & 2047) == 0 && _clock.elapsedMilliseconds > _deadline) {
      throw _OutOfTime();
    }
    final key = p.key;
    if (_path.contains(key) || _game.contains(key)) return 0; // repetition
    if (p.noProgress >= p.rules.drawPlies) return 0;

    final moves = legalMoves(p);
    if (moves.isEmpty) return -mateScore + ply;

    if (depth <= 0) {
      // Captures are forced, so a position with a capture is "noisy":
      // look one step further instead of judging it now.
      if (!moves[0].isCapture || ply > 90) return evaluate(p);
      depth = 1;
    } else if (moves.length == 1 && ply < 60) {
      depth++; // only one move: looking further costs almost nothing
    }

    final entry = _tt[key];
    Move? first;
    if (entry != null) {
      first = entry.move;
      if (entry.depth >= depth) {
        if (entry.flag == 0) return entry.score;
        if (entry.flag == 1 && entry.score >= beta) return entry.score;
        if (entry.flag == 2 && entry.score <= alpha) return entry.score;
      }
    }

    final n2 = p.board.length;
    if (moves.length > 1) {
      int rank(Move m) {
        if (first != null && m.from == first.from && m.to == first.to) {
          return 1 << 30;
        }
        return m.captured.length * 100000 +
            (m.promote ? 50000 : 0) +
            _history[m.from * n2 + m.to];
      }

      final ranks = {for (final m in moves) m: rank(m)};
      moves.sort((a, b) => ranks[b]! - ranks[a]!);
    }

    final alpha0 = alpha;
    var best = -mateScore * 2;
    Move? bestMove;
    _path.add(key);
    try {
      var i = 0;
      for (final m in moves) {
        final child = p.apply(m);
        int s;
        if (i == 0) {
          s = -_search(child, depth - 1, -beta, -alpha, ply + 1);
        } else {
          s = -_search(child, depth - 1, -alpha - 1, -alpha, ply + 1);
          if (s > alpha && s < beta) {
            s = -_search(child, depth - 1, -beta, -alpha, ply + 1);
          }
        }
        i++;
        if (s > best) {
          best = s;
          bestMove = m;
        }
        if (s > alpha) alpha = s;
        if (alpha >= beta) {
          if (!m.isCapture) _history[m.from * n2 + m.to] += depth * depth;
          break;
        }
      }
    } finally {
      _path.remove(key);
    }

    // Win/loss scores depend on distance from the root, and draw-by-repetition
    // scores depend on the path, so neither is safe to remember.
    if (best.abs() < mateScore - 200 && best != 0) {
      final flag = best <= alpha0 ? 2 : (best >= beta ? 1 : 0);
      if (entry == null) {
        _tt[key] = _Entry(depth, best, flag, bestMove);
      } else if (depth >= entry.depth) {
        entry
          ..depth = depth
          ..score = best
          ..flag = flag
          ..move = bestMove;
      }
    }
    return best;
  }
}
