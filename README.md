# licheckers

Checkers platform for 9 variants. This first part is the brain: the rules
and the AI. It is pure Dart, so the same code will run inside the Flutter app
(offline play) and on the game server (checking every move).

## What is here

| Folder | What it does |
| --- | --- |
| `packages/checkers_core` | Rules for all 9 variants: start position, legal moves, capture chains, crowning, wins and draws |
| `packages/checkers_engine` | The AI: look-ahead search, position scoring, and the 18 bots |
| `app` | The Flutter app: animated board, play vs the 18 bots or two players, Learn pages, Settings |
| `.github/workflows/test.yml` | Runs every test automatically on each push to GitHub |

## Run it

1. Install the Dart SDK (it comes with Flutter): https://dart.dev/get-dart
2. Test the rules:
   `cd packages/checkers_core && dart pub get && dart test`
3. Test the AI:
   `cd packages/checkers_engine && dart pub get && dart test`

Success looks like: `All tests passed!`
If `dart` is "not found": Dart is not installed or not on your PATH; reopen
the terminal after installing.

## Run the app

1. Install Flutter: https://docs.flutter.dev/get-started/install
2. `cd app && flutter pub get`
3. `flutter run -d chrome` (browser), or plug in an Android phone and run `flutter run`

Success looks like: the Play page opens; press **Start game** and a board appears.
If it fails with "No devices found": run `flutter doctor` and fix what it lists.

## Useful tools

- Count positions (proves the rules are right):
  `cd packages/checkers_core && dart run bin/perft.dart international 7`
- Let two bots play each other (level 6 vs level 4, 30 games):
  `cd packages/checkers_engine && dart run bin/match.dart english 6 4 30`

## How to use it in code

```dart
import 'package:checkers_core/checkers_core.dart';
import 'package:checkers_engine/checkers_engine.dart';

final game = Game(Variants.russian);
game.play(game.legal.first);                       // a player's move
final reply = pickBotMove(game.position, bots[7],  // bot level 8
    history: game.seenKeys);
game.play(reply);
```

In the app, call `pickBotMoveAsync` (from `package:checkers_engine/isolate.dart`)
so the board does not freeze while the bot thinks.

## Add or change a variant

Edit one object in `packages/checkers_core/lib/src/variants.dart`.
No other code changes. Then run the tests.

## Known gaps (do these before money tournaments)

- Turkish has one rule that sources do not state clearly (a man reaching
  the last row in mid-capture). The choice made is written at the top of
  `variants.dart`.
- Thai and Jamaican were removed until their rules can be confirmed.
- Special endgame draw counts (for example Frisian 2 kings v 1 king) are not
  modelled yet; only "N moves without progress" and threefold repetition are.
- 5 variants have no outside reference counts yet; their counts are frozen
  from this code. Compare them with pydraughts or a federation referee.
- The bots' ratings are not measured yet beyond a few test matches.
