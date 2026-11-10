import 'dart:math';

import 'package:checkers_core/checkers_core.dart';
import 'package:checkers_engine/checkers_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// What the player chose on the Play screen.
class GameSetup {
  final VariantRules rules;

  /// null = two people share this device.
  final BotProfile? bot;

  /// Which side the human plays against the bot (white or black).
  final int humanSide;
  const GameSetup(this.rules, this.bot, this.humanSide);
}

class _BotJob {
  final Position position;
  final int level;
  final List<int> history;
  final int seed;
  const _BotJob(this.position, this.level, this.history, this.seed);
}

/// Runs in the background (on phones and desktop) so the board stays smooth.
Move _botJob(_BotJob j) => pickBotMove(j.position, bots[j.level - 1],
    history: j.history, seed: j.seed);

/// Holds one game on this device: taps, moves, the bot, undo, resign.
class GameController extends ChangeNotifier {
  GameSetup? setup;
  Game? game;
  int? selected;
  bool thinking = false;

  /// Used by the board to animate the last move.
  Position? prevPosition;
  Move? lastMove;
  int moveSerial = 0;

  /// How long one sliding step takes; the bot waits for the animation.
  int animMs = 220;

  int? _resignedSide;
  int _token = 0; // changes when a game restarts, so old bot answers are dropped
  final _rng = Random();

  bool get active => game != null;

  GameResult get result {
    if (_resignedSide != null) {
      return _resignedSide == white ? GameResult.blackWins : GameResult.whiteWins;
    }
    return game?.result ?? GameResult.ongoing;
  }

  String? get resultReason =>
      _resignedSide != null ? 'resignation' : game?.reason;

  bool get humanToMove {
    final g = game, s = setup;
    if (g == null || s == null || result != GameResult.ongoing) return false;
    return s.bot == null || g.position.turn == s.humanSide;
  }

  /// Squares the selected piece can go to.
  Set<int> get targets {
    final g = game, sel = selected;
    if (g == null || sel == null) return const {};
    return {for (final m in g.movesFrom(sel)) m.to};
  }

  /// When a capture is forced: the pieces that are allowed to move.
  Set<int> get mustMove {
    final g = game;
    if (g == null || !humanToMove) return const {};
    final l = g.legal;
    if (l.isEmpty || !l.first.isCapture) return const {};
    return {for (final m in l) m.from};
  }

  void start(GameSetup s) {
    _token++;
    setup = s;
    game = Game(s.rules);
    selected = null;
    thinking = false;
    prevPosition = null;
    lastMove = null;
    _resignedSide = null;
    notifyListeners();
    _maybeBot();
  }

  void close() {
    _token++;
    game = null;
    setup = null;
    thinking = false;
    notifyListeners();
  }

  void tap(int sq) {
    final g = game;
    if (g == null || !humanToMove || thinking) return;
    final sel = selected;
    if (sel != null) {
      final options = [for (final m in g.movesFrom(sel)) if (m.to == sq) m];
      if (options.isNotEmpty) {
        // Rare: two chains end on the same square. Take the bigger one.
        options.sort((a, b) => b.captured.length - a.captured.length);
        _play(options.first);
        return;
      }
    }
    selected = g.movesFrom(sq).isNotEmpty && sq != sel ? sq : null;
    notifyListeners();
  }

  void _play(Move m) {
    final g = game!;
    final before = g.position;
    if (!g.play(m)) return;
    prevPosition = before;
    lastMove = g.moves.last;
    moveSerial++;
    selected = null;
    notifyListeners();
    _maybeBot();
  }

  Future<void> _maybeBot() async {
    final g = game, s = setup;
    if (g == null || s == null || s.bot == null) return;
    if (result != GameResult.ongoing || g.position.turn == s.humanSide) return;
    final token = _token;
    thinking = true;
    notifyListeners();
    final steps = lastMove?.path.length ?? 0;
    final wait = max(350, steps * animMs + 120);
    final started = DateTime.now();
    final move = await compute(
        _botJob,
        _BotJob(g.position, s.bot!.level, g.seenKeys.toList(),
            _rng.nextInt(1 << 30)));
    final spent = DateTime.now().difference(started).inMilliseconds;
    if (spent < wait) {
      await Future<void>.delayed(Duration(milliseconds: wait - spent));
    }
    if (token != _token) return; // the game was restarted meanwhile
    thinking = false;
    _play(move);
  }

  bool get canUndo =>
      game != null && game!.moves.isNotEmpty && !thinking && _resignedSide == null;

  /// Take back the last move (against a bot: your move and its answer).
  void undo() {
    final g = game, s = setup;
    if (g == null || s == null || !canUndo) return;
    var keep = g.moves.length - 1;
    if (s.bot != null) {
      // Go back to the human's turn.
      while (keep > 0 &&
          (keep.isEven ? s.rules.firstMover : 1 - s.rules.firstMover) !=
              s.humanSide) {
        keep--;
      }
    }
    final replay = g.moves.take(keep).toList();
    _token++;
    final fresh = Game(s.rules);
    for (final m in replay) {
      fresh.play(m);
    }
    game = fresh;
    selected = null;
    prevPosition = null;
    lastMove = replay.isEmpty ? null : replay.last;
    notifyListeners();
    _maybeBot();
  }

  void resign() {
    final g = game, s = setup;
    if (g == null || s == null || result != GameResult.ongoing) return;
    _token++;
    thinking = false;
    _resignedSide = s.bot != null ? s.humanSide : g.position.turn;
    notifyListeners();
  }

  void rematch() {
    final s = setup;
    if (s != null) start(s);
  }
}

final gameProvider =
    ChangeNotifierProvider<GameController>((_) => GameController());
