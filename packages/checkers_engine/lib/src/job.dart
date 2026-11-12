import 'dart:convert';

import 'package:checkers_core/checkers_core.dart';

import 'bots.dart';

/// A bot job as plain text, so it can travel to a background worker.
/// The worker replays the game from the start, so it knows every detail
/// (draw counters, repeated positions) exactly like the app does.
String encodeBotJob(Game game, String variantId, int level, int seed) =>
    jsonEncode({
      'v': variantId,
      'l': level,
      's': seed,
      'm': [for (final m in game.moves) [m.from, m.to, m.captured]],
    });

/// Runs a job made by [encodeBotJob]; returns the chosen move as text.
String runBotJob(String job) {
  final j = jsonDecode(job) as Map<String, dynamic>;
  final game = Game(Variants.byId(j['v'] as String));
  for (final raw in j['m'] as List) {
    final m = raw as List;
    final want = Move(m[0] as int, m[1] as int,
        captured: [for (final c in m[2] as List) c as int]);
    final ok = game.play(want);
    if (!ok) throw StateError('replay failed at $want');
  }
  final bot = bots[(j['l'] as int) - 1];
  final best = pickBotMove(game.position, bot,
      history: game.seenKeys.toList(), seed: j['s'] as int);
  return jsonEncode([best.from, best.to, best.captured]);
}

/// Turns the text from [runBotJob] back into a move of [game].
Move decodeBotMove(Game game, String text) {
  final m = jsonDecode(text) as List;
  final from = m[0] as int, to = m[1] as int;
  final cap = [for (final c in m[2] as List) c as int];
  final probe = Move(from, to, captured: cap);
  return game.legal.firstWhere((l) => l.sameAs(probe));
}
