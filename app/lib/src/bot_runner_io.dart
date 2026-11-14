import 'package:checkers_core/checkers_core.dart';
import 'package:checkers_engine/checkers_engine.dart';
import 'package:flutter/foundation.dart';

String _job(String job) => runBotJob(job);

/// Finds the bot's move in a background isolate.
Future<Move> askBot(Game game, String variantId, int level, int seed,
    {int? capMs}) async {
  final text = await compute(
      _job, encodeBotJob(game, variantId, level, seed, capMs: capMs));
  return decodeBotMove(game, text);
}

/// Nothing to cancel: the answer is simply ignored if the game changed.
void cancelBot() {}
