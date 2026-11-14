import 'dart:async';
import 'dart:math';

import 'package:checkers_core/checkers_core.dart';
import 'package:checkers_engine/checkers_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bot_runner.dart';

/// A chess-style clock: minutes for each player, plus seconds added after
/// every move. "3+2" = 3 minutes each, +2 seconds per move.
class TimeControl {
  final int baseMin, incSec;
  const TimeControl(this.baseMin, this.incSec);
  String get label => '$baseMin+$incSec';
  int get baseMs => baseMin * 60000;
  @override
  bool operator ==(Object other) =>
      other is TimeControl && other.baseMin == baseMin && other.incSec == incSec;
  @override
  int get hashCode => Object.hash(baseMin, incSec);
}

/// What the player chose before the game.
class GameSetup {
  final VariantRules rules;

  /// null = two people share this device.
  final BotProfile? bot;

  /// Which side the human plays against the bot (white or black).
  final int humanSide;

  /// null = no clock (casual game).
  final TimeControl? clock;
  const GameSetup(this.rules, this.bot, this.humanSide, {this.clock});
}

/// Things worth a sound (or a buzz).
enum GameSound { move, capture, king, lowTime, end }

/// Holds one game on this device: taps, moves, the bot, clocks, undo, resign.
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

  /// Set by the game screen; called when something deserves a sound.
  void Function(GameSound)? onSound;

  /// Looking back at an earlier position (null = the live game).
  /// 0 = the start, n = after the n-th move.
  int? viewIndex;

  int? _resignedSide;
  int? _flaggedSide; // whose clock ran out
  int _token = 0; // changes when a game restarts, so old bot answers are dropped
  final _rng = Random();

  // ---- Clocks ----
  final _left = [0, 0]; // ms left for white (0) and black (1), at turn start
  DateTime? _turnStart; // when the side to move started thinking
  Timer? _flagTimer;
  bool _lowWarned = false;

  bool get active => game != null;
  bool get hasClock => setup?.clock != null;

  GameResult get result {
    if (_resignedSide != null) {
      return _resignedSide == white ? GameResult.blackWins : GameResult.whiteWins;
    }
    if (_flaggedSide != null) {
      return _flaggedSide == white ? GameResult.blackWins : GameResult.whiteWins;
    }
    return game?.result ?? GameResult.ongoing;
  }

  bool get over => result != GameResult.ongoing;

  String? get resultReason => _resignedSide != null
      ? 'resignation'
      : _flaggedSide != null
          ? 'time ran out'
          : game?.reason;

  /// The clock runs from the second move on (the first move is free, like
  /// on lichess), and stops when the game ends.
  bool get clockRunning =>
      hasClock && !over && (game?.moves.isNotEmpty ?? false) && _turnStart != null;

  /// Milliseconds left for [side], counting down live for the side to move.
  int timeLeft(int side) {
    if (!hasClock) return 0;
    var ms = _left[side];
    if (clockRunning && game!.position.turn == side) {
      ms -= DateTime.now().difference(_turnStart!).inMilliseconds;
    }
    return max(0, ms);
  }

  bool get humanToMove {
    final g = game, s = setup;
    if (g == null || s == null || over || viewIndex != null) return false;
    return s.bot == null || g.position.turn == s.humanSide;
  }

  /// The position the board shows: live, or an earlier one while browsing.
  Position? get shownPosition {
    final g = game, v = viewIndex;
    if (g == null) return null;
    if (v == null || v >= g.moves.length) return g.position;
    return g.history[v];
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
    cancelBot();
    _flagTimer?.cancel();
    setup = s;
    game = Game(s.rules);
    selected = null;
    thinking = false;
    prevPosition = null;
    lastMove = null;
    viewIndex = null;
    _resignedSide = null;
    _flaggedSide = null;
    _lowWarned = false;
    _turnStart = null;
    final base = s.clock?.baseMs ?? 0;
    _left[0] = base;
    _left[1] = base;
    notifyListeners();
    _maybeBot();
  }

  void close() {
    _token++;
    cancelBot();
    _flagTimer?.cancel();
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
    final mover = before.turn;
    if (!g.play(m)) return;

    // Clock: charge the mover for this move, add the increment, start the
    // other side's turn.
    final clock = setup?.clock;
    if (clock != null) {
      if (_turnStart != null) {
        _left[mover] -= DateTime.now().difference(_turnStart!).inMilliseconds;
        _left[mover] += clock.incSec * 1000;
      }
      _turnStart = DateTime.now();
      _armFlag();
    }

    prevPosition = before;
    lastMove = g.moves.last;
    moveSerial++;
    selected = null;
    viewIndex = null;
    if (over) {
      _flagTimer?.cancel();
      onSound?.call(GameSound.end);
    } else {
      onSound?.call(m.isCapture
          ? GameSound.capture
          : m.promote
              ? GameSound.king
              : GameSound.move);
    }
    notifyListeners();
    _maybeBot();
  }

  /// Wake up when the side to move would run out of time, and every second
  /// near the end (for the low-time warning).
  void _armFlag() {
    _flagTimer?.cancel();
    if (!clockRunning) return;
    final side = game!.position.turn;
    final left = timeLeft(side);
    final wait = left > 10000 ? left - 10000 : min(left, 1000);
    _flagTimer = Timer(Duration(milliseconds: max(1, wait)), _onFlagTimer);
  }

  void _onFlagTimer() {
    final g = game;
    if (g == null || !clockRunning) return;
    final side = g.position.turn;
    final left = timeLeft(side);
    if (left <= 0) {
      _left[side] = 0;
      _flaggedSide = side;
      _token++; // drop any bot answer still on its way
      cancelBot();
      thinking = false;
      onSound?.call(GameSound.end);
      notifyListeners();
      return;
    }
    // Warn the human once, at 10 seconds.
    final humanSide = setup?.bot == null ? side : setup!.humanSide;
    if (!_lowWarned && side == humanSide && left <= 10000) {
      _lowWarned = true;
      onSound?.call(GameSound.lowTime);
    }
    _armFlag();
  }

  Future<void> _maybeBot() async {
    final g = game, s = setup;
    if (g == null || s == null || s.bot == null) return;
    if (over || g.position.turn == s.humanSide) return;
    final token = _token;
    thinking = true;
    notifyListeners();
    final steps = lastMove?.path.length ?? 0;
    final wait = max(350, steps * animMs + 120);
    final started = DateTime.now();
    // On a clock the bot spends about 1/25 of its time, like a sensible
    // human, so it never loses on time in a bullet game.
    int? cap;
    if (s.clock != null) {
      final left = g.moves.isEmpty ? s.clock!.baseMs : timeLeft(g.position.turn);
      cap = (left ~/ 25 + s.clock!.incSec * 800).clamp(100, s.bot!.timeMs);
    }
    final Move move;
    try {
      move = await askBot(g, s.rules.id, s.bot!.level, _rng.nextInt(1 << 30),
          capMs: cap);
    } catch (_) {
      return; // cancelled or failed: the game was restarted meanwhile
    }
    final spent = DateTime.now().difference(started).inMilliseconds;
    if (spent < wait) {
      await Future<void>.delayed(Duration(milliseconds: wait - spent));
    }
    if (token != _token || over) return; // restarted or ended meanwhile
    thinking = false;
    _play(move);
  }

  /// Undo only in casual games: with a clock it would be unfair.
  bool get canUndo =>
      game != null &&
      game!.moves.isNotEmpty &&
      !thinking &&
      !over &&
      !hasClock;

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
    cancelBot();
    final fresh = Game(s.rules);
    for (final m in replay) {
      fresh.play(m);
    }
    game = fresh;
    selected = null;
    prevPosition = null;
    viewIndex = null;
    lastMove = replay.isEmpty ? null : replay.last;
    notifyListeners();
    _maybeBot();
  }

  void resign() {
    final g = game, s = setup;
    if (g == null || s == null || over) return;
    _token++;
    cancelBot();
    _flagTimer?.cancel();
    if (clockRunning) {
      final side = g.position.turn;
      _left[side] = timeLeft(side); // freeze the clock where it was
    }
    thinking = false;
    _resignedSide = s.bot != null ? s.humanSide : g.position.turn;
    onSound?.call(GameSound.end);
    notifyListeners();
  }

  void rematch() {
    final s = setup;
    if (s == null) return;
    // Against the bot, swap colours for the rematch, like a fair player.
    start(s.bot == null
        ? s
        : GameSetup(s.rules, s.bot, 1 - s.humanSide, clock: s.clock));
  }

  // ---- Browsing earlier positions ----

  void viewMove(int index) {
    final g = game;
    if (g == null) return;
    viewIndex = index >= g.moves.length ? null : max(0, index);
    selected = null;
    notifyListeners();
  }

  void stepBack() {
    final g = game;
    if (g == null || g.moves.isEmpty) return;
    viewMove((viewIndex ?? g.moves.length) - 1);
  }

  void stepForward() {
    final v = viewIndex;
    if (v != null) viewMove(v + 1);
  }

  void backToLive() => viewMove(1 << 30);

  @override
  void dispose() {
    _flagTimer?.cancel();
    super.dispose();
  }
}

final gameProvider =
    ChangeNotifierProvider<GameController>((_) => GameController());
