import 'dart:math';

import 'package:checkers_core/checkers_core.dart';
import 'package:checkers_engine/checkers_engine.dart';

/// Let two bots play each other to measure their strength.
/// Usage: dart run bin/match.dart <variant> <levelA> <levelB> <games>
void main(List<String> args) {
  final rules = Variants.byId(args[0]);
  final a = bots[int.parse(args[1]) - 1], b = bots[int.parse(args[2]) - 1];
  final games = int.parse(args[3]);
  final rng = Random(42);
  var aWins = 0, bWins = 0, draws = 0;
  for (var g = 0; g < games; g++) {
    final game = Game(rules);
    // 4 random opening moves so the games are not all the same.
    for (var i = 0; i < 4 && game.result == GameResult.ongoing; i++) {
      game.play(game.legal[rng.nextInt(game.legal.length)]);
    }
    final aIsWhite = g.isEven;
    final sa = Searcher(), sb = Searcher();
    while (game.result == GameResult.ongoing && game.moves.length < 400) {
      final aToMove = (game.position.turn == white) == aIsWhite;
      game.play(pickBotMove(game.position, aToMove ? a : b,
          history: game.seenKeys,
          seed: rng.nextInt(1 << 30),
          searcher: aToMove ? sa : sb));
    }
    final whiteWon = game.result == GameResult.whiteWins;
    final blackWon = game.result == GameResult.blackWins;
    if ((whiteWon && aIsWhite) || (blackWon && !aIsWhite)) {
      aWins++;
    } else if (whiteWon || blackWon) {
      bWins++;
    } else {
      draws++;
    }
  }
  final pct = (100 * (aWins + draws / 2) / games).toStringAsFixed(0);
  print('${rules.id}: ${a.name} (L${a.level}) vs ${b.name} (L${b.level}): '
      '+$aWins -$bWins =$draws  -> ${a.name} scores $pct%');
}
