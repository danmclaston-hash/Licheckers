import 'dart:math';

import 'package:checkers_core/checkers_core.dart';

import 'search.dart';

/// One AI opponent. Strength comes from three dials:
///  - [depth]: how many moves ahead it looks
///  - [timeMs]: the longest it may think
///  - [mistakeRate]: how often it plays a weaker move on purpose, and
///    [mistakeSize]: how bad that move may be (100 = throws away one man)
class BotProfile {
  final int level;
  final String name;
  final String description;
  final int depth;
  final int timeMs;
  final double mistakeRate;
  final int mistakeSize;
  const BotProfile(this.level, this.name, this.description, this.depth,
      this.timeMs, this.mistakeRate, this.mistakeSize);
}

const List<BotProfile> bots = [
  BotProfile(1, 'Toddler Tom', 'Moves mostly at random and loves giving pieces away.', 1, 500, 0.60, 100000),
  BotProfile(2, 'Casual Clara', 'Just here for a good time. Often walks into your jumps.', 1, 500, 0.40, 100000),
  BotProfile(3, 'Student Sam', 'Learning the basics. Understands that jumping is good.', 2, 500, 0.30, 400),
  BotProfile(4, 'Averaging Alex', 'Your average park player. Solid but predictable.', 3, 800, 0.22, 300),
  BotProfile(5, 'Tactical Tina', 'Starts looking for double jumps and center control.', 4, 800, 0.16, 250),
  BotProfile(6, 'Defensive Dan', 'Very cautious. Prefers keeping pieces in the back row.', 5, 1000, 0.12, 200),
  BotProfile(7, 'Aggressive Amy', 'Aggressively attacking. Likes to force exchanges.', 6, 1000, 0.09, 150),
  BotProfile(8, 'Club Player Chris', 'A regular at the local checkers club.', 7, 1000, 0.07, 120),
  BotProfile(9, 'Scholar Sarah', 'Studies the theory. Very efficient in the endgame.', 8, 1200, 0.05, 100),
  BotProfile(10, 'Master Mike', 'A regional champion. Very few mistakes.', 9, 1500, 0.04, 80),
  BotProfile(11, 'Expert Elena', 'Deep tactical vision. Will trap your king easily.', 10, 2000, 0.03, 60),
  BotProfile(12, 'Strategist Stan', 'Looks far ahead. Controls the board rhythm.', 11, 2000, 0.02, 50),
  BotProfile(13, 'Grandmaster Gwen', 'National level strength. Incredibly hard to beat.', 12, 2500, 0.01, 40),
  BotProfile(14, 'Champion Chen', 'World-class positioning. Every move has a purpose.', 14, 3000, 0.005, 30),
  BotProfile(15, 'Neural Nancy', 'Pattern recognition like a machine. Unyielding.', 16, 3000, 0, 0),
  BotProfile(16, 'Titan Tyrell', 'A beast of a player. Punishes the slightest inaccuracy.', 18, 4000, 0, 0),
  BotProfile(17, 'Deep Draughts', 'Supercomputer-level calculation.', 22, 6000, 0, 0),
  BotProfile(18, 'The Oracle', 'The strongest bot here: thinks as deep as time allows.', 64, 10000, 0, 0),
];

/// Choose the bot's move. [history] = keys of earlier positions in this game
/// (from `Game.seenKeys`), so the bot avoids repeating when it is winning.
/// Give a [seed] to make its choices repeatable in tests.
Move pickBotMove(
  Position position,
  BotProfile bot, {
  Iterable<int> history = const [],
  int? seed,
  Searcher? searcher,
}) {
  final rng = Random(seed);
  final wantsMistakes = bot.mistakeRate > 0;
  final res = (searcher ?? Searcher()).search(
    position,
    maxDepth: bot.depth,
    timeMs: bot.timeMs,
    history: history,
    scoreAllMoves: wantsMistakes,
  );
  if (!wantsMistakes || res.root.length < 2) return res.best;
  if (rng.nextDouble() >= bot.mistakeRate) return res.best;
  // A planned mistake: any other move that is not worse than mistakeSize.
  final worse = [
    for (final rm in res.root.skip(1))
      if (res.score - rm.score <= bot.mistakeSize) rm.move
  ];
  return worse.isEmpty ? res.best : worse[rng.nextInt(worse.length)];
}
