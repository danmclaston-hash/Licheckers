/// Run a bot in the background so the board never freezes.
/// (Phones and desktop. On the web, call it through Flutter's `compute`.)
library;

import 'dart:isolate';

import 'package:checkers_core/checkers_core.dart';

import 'checkers_engine.dart';

Future<Move> pickBotMoveAsync(
  Position position,
  BotProfile bot, {
  List<int> history = const [],
  int? seed,
}) =>
    Isolate.run(
        () => pickBotMove(position, bot, history: history, seed: seed));
