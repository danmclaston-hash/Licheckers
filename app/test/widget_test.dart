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
  testWidgets('home shows Play, and Start opens a board', (tester) async {
    // A tall phone-shaped screen so the whole Play page is on screen.
    tester.view.physicalSize = const Size(500, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(await app());
    expect(find.text('Start game'), findsOneWidget);
    await tester.tap(find.text('Two players'));
    await tester.pump();
    await tester.ensureVisible(find.text('Start game'));
    await tester.tap(find.text('Start game'));
    await tester.pumpAndSettle();
    expect(find.text('Resign'), findsOneWidget);
    expect(find.textContaining('to move'), findsOneWidget);
  });

  testWidgets('info buttons disappear when switched off', (tester) async {
    await tester.pumpWidget(await app());
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
}
