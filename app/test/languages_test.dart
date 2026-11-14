import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:licheckers/l10n/app_localizations.dart';
import 'package:licheckers/main.dart';
import 'package:licheckers/src/i18n.dart';
import 'package:licheckers/src/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Opens every main screen in every language on a phone-sized screen.
/// Any text that does not fit (overflow) or any crash makes the test fail,
/// so long French or Swahili words are caught before users see them.
Future<Widget> appIn(String code) async {
  SharedPreferences.setMockInitialValues({
    'settings.v1': jsonEncode({'locale': code}),
  });
  final prefs = await SharedPreferences.getInstance();
  return ProviderScope(
    overrides: [prefsProvider.overrideWithValue(prefs)],
    child: const LicheckersApp(),
  );
}

void main() {
  for (final code in supportedCodes) {
    testWidgets('every screen opens cleanly in "$code"', (tester) async {
      tester.view.physicalSize = const Size(412, 915);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(await appIn(code));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: 'Play screen');
      final l = lookupL(Locale(code));
      expect(find.text(l.navPlay), findsWidgets);
      expect(find.text(l.opponent), findsOneWidget);

      // Arabic must read right-to-left.
      final dir = Directionality.of(tester.element(find.text(l.opponent)));
      expect(dir, code == 'ar' ? TextDirection.rtl : TextDirection.ltr);

      for (var tab = 1; tab < 4; tab++) {
        await tester.tap(find.byType(NavigationDestination).at(tab));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: 'tab $tab');
        if (tab == 3) expect(find.text(l.language), findsOneWidget);
        for (var i = 0; i < 8; i++) {
          await tester.drag(find.byType(Scrollable).first, const Offset(0, -400));
          await tester.pump(const Duration(milliseconds: 50));
          expect(tester.takeException(), isNull, reason: 'tab $tab, scrolling');
        }
        // Back to the top, so the next step finds its buttons.
        await tester.drag(find.byType(Scrollable).first, const Offset(0, 6000));
        await tester.pumpAndSettle();
      }

      // Tournaments, then the create form, scrolled all the way down.
      await tester.tap(find.byType(NavigationDestination).at(1));
      await tester.pumpAndSettle();
      await tester.tap(find.text(l.createTournament));
      await tester.pumpAndSettle();
      expect(find.text(l.createTitle), findsOneWidget);
      for (var i = 0; i < 12; i++) {
        await tester.drag(find.byType(Scrollable).first, const Offset(0, -500));
        await tester.pump(const Duration(milliseconds: 50));
        expect(tester.takeException(), isNull, reason: 'create form, scrolling');
      }
      await tester.pumpAndSettle();
    });
  }
}
