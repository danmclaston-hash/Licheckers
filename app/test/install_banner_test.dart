import 'package:flutter_test/flutter_test.dart';
import 'package:licheckers/src/install/install_banner.dart';

void main() {
  final now = DateTime(2026, 11, 14, 9);
  bool ask({
    bool installed = false,
    bool offers = true,
    int visits = 2,
    Duration since = Duration.zero,
    int snooze = 0,
  }) =>
      shouldOfferInstall(
          installed: installed,
          browserOffers: offers,
          visits: visits,
          sinceOpened: since,
          now: now,
          snoozeUntilMs: snooze);

  test('never asks someone who already installed it', () {
    expect(ask(installed: true), isFalse);
  });
  test('never asks when the browser cannot install', () {
    expect(ask(offers: false), isFalse);
  });
  test('first visit: waits 45 seconds before asking', () {
    expect(ask(visits: 1, since: const Duration(seconds: 10)), isFalse);
    expect(ask(visits: 1, since: const Duration(seconds: 45)), isTrue);
  });
  test('second visit: may ask straight away', () {
    expect(ask(visits: 2), isTrue);
  });
  test('"Not now" means 14 days of silence', () {
    final until = now.add(const Duration(days: snoozeDays)).millisecondsSinceEpoch;
    expect(ask(snooze: until), isFalse);
    expect(
        shouldOfferInstall(
            installed: false,
            browserOffers: true,
            visits: 5,
            sinceOpened: Duration.zero,
            now: now.add(const Duration(days: 15)),
            snoozeUntilMs: until),
        isTrue);
  });
}
