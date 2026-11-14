import 'package:checkers_core/checkers_core.dart';
import 'package:checkers_engine/checkers_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:licheckers/main.dart';
import 'package:licheckers/src/game_controller.dart';
import 'package:licheckers/src/info_tip.dart';
import 'package:licheckers/l10n/app_localizations.dart';
import 'package:licheckers/src/i18n.dart' as i18n;
import 'package:licheckers/src/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderScope> app() async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  return ProviderScope(
    overrides: [prefsProvider.overrideWithValue(prefs)],
    child: const LicheckersApp(),
  );
}

void main() {
  testWidgets('home grid: one tap on "Two players" opens a board', (tester) async {
    tester.view.physicalSize = const Size(500, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(await app());
    expect(find.text('Easy'), findsOneWidget);
    expect(find.text('3+2'), findsOneWidget);
    await tester.tap(find.text('Two players').first);
    await tester.pumpAndSettle();
    expect(find.text('Resign'), findsOneWidget);
    expect(find.textContaining('to move'), findsOneWidget);
    expect(find.text('No moves yet'), findsOneWidget); // the move strip
  });

  testWidgets('Custom opens the full setup with a clock choice', (tester) async {
    tester.view.physicalSize = const Size(500, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(await app());
    await tester.tap(find.text('Custom'));
    await tester.pumpAndSettle();
    expect(find.text('Custom game'), findsOneWidget);
    expect(find.text('No clock'), findsOneWidget);
    expect(find.text('Start game'), findsOneWidget);
  });

  testWidgets('info buttons disappear when switched off', (tester) async {
    await tester.pumpWidget(await app());
    await tester.tap(find.byType(NavigationDestination).at(1)); // Tournaments
    await tester.pumpAndSettle();
    expect(find.byType(InfoTip), findsWidgets);
    expect(find.byIcon(Icons.info_outline), findsWidgets);
    final container = ProviderScope.containerOf(
        tester.element(find.byType(LicheckersApp)));
    container
        .read(settingsProvider.notifier)
        .change((s) => s.copyWith(showInfo: false));
    await tester.pump();
    expect(find.byIcon(Icons.info_outline), findsNothing);
  });

  test('controller: tap to select, tap to move, undo', () {
    final c = GameController()
      ..start(const GameSetup(Variants.international, null, white));
    final first = c.game!.legal.first;
    c.tap(first.from);
    expect(c.selected, first.from);
    expect(c.targets, contains(first.to));
    c.tap(first.to);
    expect(c.game!.moves, hasLength(1));
    expect(c.moveSerial, 1);
    c.undo();
    expect(c.game!.moves, isEmpty);
  });

  test('controller: resign ends the game', () {
    final c = GameController()
      ..start(GameSetup(Variants.english, bots[0], black));
    c.resign();
    expect(c.result, GameResult.whiteWins);
  });

  test('rules text exists for every variant in every language', () {
    for (final code in i18n.supportedCodes) {
      final l = lookupL(Locale(code));
      for (final v in Variants.all) {
        final lines = i18n.describeRules(l, v);
        expect(lines.length, greaterThan(8), reason: '$code ${v.id}');
        expect(lines.every((s) => s.trim().isNotEmpty), isTrue);
        expect(i18n.tagline(l, v), isNotEmpty);
        expect(i18n.variantName(l, v.id), isNot(v.id), reason: '$code ${v.id}');
      }
    }
  });

  group('clocks', () {
    test('the first move is free, then the clock runs and increments', () async {
      final c = GameController()
        ..start(const GameSetup(Variants.english, null, white,
            clock: TimeControl(1, 2)));
      // In English (American) checkers Black moves first.
      final first = c.game!.position.turn, second = 1 - first;
      expect(c.timeLeft(first), 60000);
      expect(c.clockRunning, isFalse); // nobody has moved yet
      var m = c.game!.legal.first;
      c.tap(m.from);
      c.tap(m.to);
      expect(c.clockRunning, isTrue);
      expect(c.timeLeft(first), 60000); // first move: no charge, no increment
      await Future<void>.delayed(const Duration(milliseconds: 120));
      expect(c.timeLeft(second), lessThan(60000));
      m = c.game!.legal.first;
      c.tap(m.from);
      c.tap(m.to);
      // The second player paid ~120 ms and earned 2 s back.
      expect(c.timeLeft(second), greaterThan(61500));
      expect(c.canUndo, isFalse); // no undo in timed games
      c.close();
    });

    test('running out of time loses the game', () async {
      final c = GameController()
        ..start(const GameSetup(Variants.english, null, white,
            clock: TimeControl(0, 0)));
      final first = c.game!.position.turn;
      final m = c.game!.legal.first;
      c.tap(m.from);
      c.tap(m.to); // the other side's clock (0 ms) starts now
      await Future<void>.delayed(const Duration(milliseconds: 50));
      // The side that moved first wins: the other one ran out of time.
      expect(c.result, first == white ? GameResult.whiteWins : GameResult.blackWins);
      expect(c.resultReason, 'time ran out');
      c.close();
    });

    test('browsing old moves shows old positions and blocks moves', () {
      final c = GameController()
        ..start(const GameSetup(Variants.english, null, white));
      final m = c.game!.legal.first;
      c.tap(m.from);
      c.tap(m.to);
      c.stepBack();
      expect(c.viewIndex, 0);
      expect(c.shownPosition!.key, Position.initial(Variants.english).key);
      expect(c.humanToMove, isFalse);
      c.backToLive();
      expect(c.viewIndex, isNull);
      expect(c.humanToMove, isTrue);
    });

    test('sounds: a move and a capture are reported', () {
      final heard = <GameSound>[];
      final c = GameController()
        ..onSound = heard.add
        ..start(const GameSetup(Variants.english, null, white));
      final m = c.game!.legal.first;
      c.tap(m.from);
      c.tap(m.to);
      expect(heard, [GameSound.move]);
    });
  });
}
