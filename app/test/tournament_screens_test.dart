import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:licheckers/main.dart';
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
  void tallPhone(WidgetTester tester) {
    tester.view.physicalSize = const Size(500, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
  }

  testWidgets('Tournaments tab lists the demo tournaments', (tester) async {
    tallPhone(tester);
    await tester.pumpWidget(await app());
    await tester.tap(find.text('Tournaments'));
    await tester.pumpAndSettle();
    expect(find.text('Create a tournament'), findsOneWidget);
    expect(find.text('Friday Night Blitz'), findsOneWidget);
    expect(find.textContaining('Presented by'), findsWidgets);
    expect(find.textContaining('Starts in'), findsWidgets);
  });

  testWidgets('create: needs a name, then shows what you pay and can be created',
      (tester) async {
    tallPhone(tester);
    await tester.pumpWidget(await app());
    await tester.tap(find.text('Tournaments'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Create a tournament'));
    await tester.pumpAndSettle();

    // No name yet: the button is disabled and says why.
    expect(find.textContaining('Give the tournament a name'), findsOneWidget);
    var button = tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, 'Lock prize pool and create'));
    expect(button.onPressed, isNull);
    // Creation fee 3,700 + prize pool 100,000.
    expect(find.text('UGX 103,700'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextField, 'Tournament name'), 'Test Cup');
    await tester.pump();
    button = tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, 'Lock prize pool and create'));
    expect(button.onPressed, isNotNull);

    await tester.tap(find.widgetWithText(FilledButton, 'Lock prize pool and create'));
    await tester.pumpAndSettle();
    expect(find.text('Lock the prize pool and create?'), findsOneWidget);
    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();
    expect(find.text('Test Cup'), findsWidgets);
    expect(find.textContaining('Tournament created'), findsOneWidget);
    expect(find.textContaining('licheckers.app/t/'), findsOneWidget);
  });

  testWidgets('choosing a sponsor adds its fee and a 6 hour rule', (tester) async {
    tallPhone(tester);
    await tester.pumpWidget(await app());
    await tester.tap(find.text('Tournaments'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Create a tournament'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, 'Tournament name'), 'Sponsor Cup');
    await tester.scrollUntilVisible(find.text('One sponsor'), 400,
        scrollable: find.byType(Scrollable).first);
    await tester.tap(find.text('One sponsor'));
    await tester.pump();
    // 3,700 + 100,000 + 15,000
    expect(find.text('UGX 118,700'), findsOneWidget);
    expect(find.textContaining('6 hours'), findsWidgets);
  });
}
