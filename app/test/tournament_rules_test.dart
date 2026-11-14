import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:licheckers/src/theme.dart';
import 'package:licheckers/src/tournament/tournament_rules.dart';

void main() {
  test('money: 30 players x 5,000 with a 100,000 pool', () {
    final m = moneySummary(players: 30, fee: 5000, pool: 100000);
    expect(m.collected, 150000);
    expect(m.hostProfit, 50000);
    expect(m.platformCut, 7500); // 15% of profit only
    expect(m.hostResult, 42500);
    expect(m.breakEvenPlayers, 20);
  });

  test('money: no profit means no platform cut', () {
    final m = moneySummary(players: 10, fee: 5000, pool: 100000);
    expect(m.hostProfit, 0);
    expect(m.platformCut, 0);
    expect(m.hostResult, -50000);
  });

  test('prize split adds up exactly', () {
    for (final e in splitPresets.entries) {
      expect(e.value.fold<int>(0, (a, b) => a + b), 100, reason: e.key);
      final a = prizeAmounts(100001, e.value);
      expect(a.fold<int>(0, (x, y) => x + y), 100001, reason: e.key);
    }
    expect(prizeAmounts(100000, [50, 30, 20]), [50000, 30000, 20000]);
  });

  test('sponsor prices: 15,000 theme + 3,000 per sponsor for pieces', () {
    expect(sponsorFeeUgx(SponsorMode.none), 0);
    expect(sponsorFeeUgx(SponsorMode.single), 15000);
    expect(sponsorFeeUgx(SponsorMode.single, piecesA: true), 18000);
    expect(sponsorFeeUgx(SponsorMode.half), 30000);
    expect(sponsorFeeUgx(SponsorMode.half, piecesA: true, piecesB: true), 36000);
  });

  test('ugx formatting', () {
    expect(ugx(15000), 'UGX 15,000');
    expect(ugx(999), 'UGX 999');
    expect(ugx(1234567), 'UGX 1,234,567');
    expect(ugx(-50000), '-UGX 50,000');
  });

  test('clocks and rounds', () {
    expect(clockLabel(3, 2), '3+2');
    // 3+2: a long game is about 8.7 minutes, so a 2 hour Swiss fits 10 rounds.
    expect(swissRoundsFit(120, 3, 2), 10);
    expect(swissRoundsFit(30, 30, 30), 0);
    expect(arenaFits(240, 20, 10), isTrue); // long game ~53 min, 3 fit in 4 h
    expect(arenaFits(240, 30, 30), isFalse); // long game 100 min: too slow
    expect(arenaFits(60, 15, 10), isFalse);
  });

  test('contrast ratio basics', () {
    expect(contrastRatio(const Color(0xFFFFFFFF), const Color(0xFF000000)),
        closeTo(21, .01));
    expect(contrastRatio(const Color(0xFF777777), const Color(0xFF777777)), 1);
  });

  test('the board guard refuses a pair that is hard to see', () {
    // Black pieces on the Midnight board's dark squares are nearly invisible.
    final bad = boardChecks(boardThemeById('midnight'), pieceStyleById('classic'));
    expect(bad.every((c) => c.ok), isFalse);
    // The Clear boards are built to be clear with Flat and Classic pieces.
    for (final id in ['clear-green', 'clear-brown', 'clear-blue', 'clear-red']) {
      for (final piece in ['flat', 'classic']) {
        expect(boardApproved(boardThemeById(id), pieceStyleById(piece)), isTrue,
            reason: '$id/$piece');
      }
    }
  });

  test('the older boards are NOT approved for tournaments', () {
    for (final id in ['walnut', 'forest', 'ocean', 'midnight', 'sunset']) {
      for (final p in pieceStyles) {
        expect(boardApproved(boardThemeById(id), p), isFalse, reason: '$id/${p.id}');
      }
    }
  });

  test('labels: short, readable, never too long', () {
    final p = pieceStyleById('flat');
    expect(labelProblem('MTN', p.whiteA, p.whiteB), isNull);
    expect(labelProblem('TOOLONGNAME', p.whiteA, p.whiteB), LabelIssue.tooLong);
    expect(labelProblem('  ', p.whiteA, p.whiteB), LabelIssue.empty);
  });

  group('draft validation', () {
    final now = DateTime(2026, 11, 12, 12);
    TournamentDraft good() => TournamentDraft(now: now)..name = 'Friday Blitz';

    test('a normal draft is fine', () {
      expect(good().problems(now: now), isEmpty);
    });
    test('needs a name', () {
      expect((good()..name = '').problems(now: now), isNotEmpty);
    });
    test('cannot start in 10 minutes', () {
      final d = good()..start = now.add(const Duration(minutes: 10));
      expect(d.problems(now: now).any((p) => p.code == ProblemCode.startSoon), isTrue);
    });
    test('sponsored tournaments need 6 hours lead time', () {
      final d = good()
        ..sponsor = SponsorMode.single
        ..sponsorA = 'Acme'
        ..start = now.add(const Duration(hours: 2));
      expect(d.problems(now: now).any((p) => p.code == ProblemCode.sponsoredStartSoon), isTrue);
      d.start = now.add(const Duration(hours: 7));
      expect(d.problems(now: now), isEmpty);
    });
    test('never longer than 4 hours', () {
      final d = good()..durationMin = 300;
      expect(d.problems(now: now).any((p) => p.code == ProblemCode.lengthRange), isTrue);
    });
    test('clock must stay inside its type range', () {
      final d = good()
        ..clock = ClockType.bullet
        ..baseMin = 5;
      expect(d.problems(now: now).any((p) => p.code == ProblemCode.clockRange), isTrue);
    });
    test('swiss rounds must fit', () {
      final d = good()
        ..format = TFormat.swiss
        ..rounds = 20;
      expect(d.problems(now: now).any((p) => p.code == ProblemCode.swissTooMany), isTrue);
      d.rounds = 5;
      expect(d.problems(now: now), isEmpty);
    });
    test('total to pay: creation fee + prize pool + sponsor; developer is free',
        () {
      final d = good()
        ..poolUgx = 100000
        ..sponsor = SponsorMode.single
        ..piecesA = true;
      expect(d.totalToPay(), creationFeeUgx + 100000 + 18000);
      expect(d.totalToPay(isDeveloper: true), 100000 + 18000);
    });
  });
}
