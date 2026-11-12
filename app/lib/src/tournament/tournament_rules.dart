import 'dart:math';

import 'package:flutter/painting.dart';

import '../theme.dart';

// ---------------------------------------------------------------------------
// Prices and limits. Kept in one place so they can become server settings.
// ---------------------------------------------------------------------------

const platformCutPercent = 15; // of the HOST'S PROFIT (entries minus prize pool)
const themeFeeUgx = 15000; // sponsor look for one tournament (one sponsor)
const piecesAddOnUgx = 3000; // sponsor name on that sponsor's pieces
const creationFeeUgx = 3700; // about USD 1; the developer pays nothing
const minDurationMin = 30;
const maxDurationMin = 240; // tournaments never run longer than 4 hours
const minStartLeadMin = 30; // a normal tournament must start 30 min from now
const sponsoredLeadMin = 360; // sponsor art needs 6 hours for the safety check

enum TFormat { arena, swiss }

enum ClockType { bullet, blitz, rapid, classic }

enum SponsorMode { none, single, half }

class ClockRange {
  final String name;
  final int minBase, maxBase; // minutes per player
  final int minInc, maxInc; // seconds added after each move
  const ClockRange(this.name, this.minBase, this.maxBase, this.minInc, this.maxInc);
}

const clockRanges = <ClockType, ClockRange>{
  ClockType.bullet: ClockRange('Bullet', 1, 2, 0, 2),
  ClockType.blitz: ClockRange('Blitz', 3, 5, 0, 5),
  ClockType.rapid: ClockRange('Rapid', 10, 15, 0, 15),
  ClockType.classic: ClockRange('Classic', 20, 30, 5, 30),
};

/// "3+2" style label.
String clockLabel(int baseMin, int incSec) => '$baseMin+$incSec';

/// A long game: about 40 moves each, so the increment is paid 80 times.
double gameMinutes(int baseMin, int incSec) =>
    2 * baseMin + incSec * 80 / 60;

/// How many Swiss rounds fit in the time window (3 minutes between rounds).
int swissRoundsFit(int durationMin, int baseMin, int incSec) =>
    max(0, (durationMin / (gameMinutes(baseMin, incSec) + 3)).floor());

/// An Arena needs room for about three long games.
bool arenaFits(int durationMin, int baseMin, int incSec) =>
    durationMin >= 3 * gameMinutes(baseMin, incSec);

// ---------------------------------------------------------------------------
// Money
// ---------------------------------------------------------------------------

class MoneySummary {
  final int collected; // entry fees from all players
  final int hostProfit; // entries minus prize pool, never below 0
  final int platformCut; // 15% of the profit only
  final int hostResult; // what the host ends with (can be negative)
  final int? breakEvenPlayers; // players needed to cover the prize pool
  const MoneySummary(this.collected, this.hostProfit, this.platformCut,
      this.hostResult, this.breakEvenPlayers);
}

MoneySummary moneySummary(
    {required int players, required int fee, required int pool}) {
  final collected = players * fee;
  final profit = max(0, collected - pool);
  final cut = (profit * platformCutPercent / 100).round();
  return MoneySummary(collected, profit, cut, collected - pool - cut,
      fee > 0 ? (pool / fee).ceil() : null);
}

const splitPresets = <String, List<int>>{
  'Winner takes all': [100],
  'Top 3': [50, 30, 20],
  'Top 5': [40, 25, 15, 10, 10],
};

/// Prize for each place. Rounded down; the rest goes to first place.
List<int> prizeAmounts(int pool, List<int> percents) {
  final a = [for (final p in percents) pool * p ~/ 100];
  a[0] += pool - a.fold<int>(0, (s, x) => s + x);
  return a;
}

int sponsorFeeUgx(SponsorMode m, {bool piecesA = false, bool piecesB = false}) =>
    switch (m) {
      SponsorMode.none => 0,
      SponsorMode.single => themeFeeUgx + (piecesA ? piecesAddOnUgx : 0),
      SponsorMode.half => 2 * themeFeeUgx +
          (piecesA ? piecesAddOnUgx : 0) +
          (piecesB ? piecesAddOnUgx : 0),
    };

/// 15000 -> "UGX 15,000"
String ugx(int v) {
  final s = v.abs().toString();
  final b = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) b.write(',');
    b.write(s[i]);
  }
  return '${v < 0 ? '-' : ''}UGX $b';
}

// ---------------------------------------------------------------------------
// Board readability guard
// ---------------------------------------------------------------------------

double contrastRatio(Color a, Color b) {
  final la = a.computeLuminance(), lb = b.computeLuminance();
  return (max(la, lb) + .05) / (min(la, lb) + .05);
}

Color _mean(Color a, Color b) => Color.lerp(a, b, .5)!;

// Starting limits. Tune them on real phone screens.
const minPieceOnSquare = 3.0;
const minSideApart = 4.5;
const minSquaresApart = 2.0;
const minLabelOnPiece = 4.5;
const maxLabelLength = 6;

class Check {
  final String label;
  final double value, need;
  const Check(this.label, this.value, this.need);
  bool get ok => value >= need;
}

/// The tests a board + piece pair must pass before a tournament may use it.
List<Check> boardChecks(BoardTheme b, PieceStyle p) {
  final white = _mean(p.whiteA, p.whiteB), black = _mean(p.blackA, p.blackB);
  double onDark(Color piece) => min(
      contrastRatio(piece, b.darkA), contrastRatio(piece, b.darkB));
  return [
    Check('White pieces stand out from the dark squares', onDark(white),
        minPieceOnSquare),
    Check('Black pieces stand out from the dark squares', onDark(black),
        minPieceOnSquare),
    Check('White and black pieces are easy to tell apart',
        contrastRatio(white, black), minSideApart),
    Check(
        'Light and dark squares are easy to tell apart',
        contrastRatio(_mean(b.lightA, b.lightB), _mean(b.darkA, b.darkB)),
        minSquaresApart),
  ];
}

bool boardApproved(BoardTheme b, PieceStyle p) =>
    boardChecks(b, p).every((c) => c.ok);

/// Best text colour (black or white) for a label on this piece, and how
/// readable it is.
(Color, double) labelColourFor(Color pieceA, Color pieceB) {
  final fill = _mean(pieceA, pieceB);
  final w = contrastRatio(const Color(0xFFFFFFFF), fill);
  final k = contrastRatio(const Color(0xFF000000), fill);
  return w >= k ? (const Color(0xFFFFFFFF), w) : (const Color(0xFF000000), k);
}

/// null = fine, otherwise the reason it is refused.
String? labelProblem(String text, Color pieceA, Color pieceB) {
  final t = text.trim();
  if (t.isEmpty) return 'Type a short name (up to $maxLabelLength letters).';
  if (t.length > maxLabelLength) {
    return 'Too long: at most $maxLabelLength letters so the king crown stays visible.';
  }
  if (labelColourFor(pieceA, pieceB).$2 < minLabelOnPiece) {
    return 'This name would be hard to read on these pieces. Pick other pieces.';
  }
  return null;
}

// ---------------------------------------------------------------------------
// The draft the host fills in
// ---------------------------------------------------------------------------

const sponsorColours = <String, Color>{
  'Amber': Color(0xFFE0A800),
  'Red': Color(0xFFD32F2F),
  'Blue': Color(0xFF1976D2),
  'Green': Color(0xFF2E7D32),
  'Purple': Color(0xFF7B1FA2),
  'Teal': Color(0xFF00796B),
};

class TournamentDraft {
  String name = '';
  String variantId = 'english';
  TFormat format = TFormat.arena;
  ClockType clock = ClockType.blitz;
  int baseMin = 3;
  int incSec = 2;
  late DateTime start;
  int durationMin = 120;
  int rounds = 5;
  int minPlayers = 8;
  int maxPlayers = 200;
  int feeUgx = 5000;
  int poolUgx = 100000;
  String split = 'Top 3';
  String boardId = 'clear-green';
  String pieceId = 'flat';
  SponsorMode sponsor = SponsorMode.none;
  String sponsorA = '', sponsorB = '';
  String colourA = 'Blue', colourB = 'Red';
  bool piecesA = false, piecesB = false;
  bool voiceAllowed = true;
  int spectatorDelaySec = 20;

  TournamentDraft({DateTime? now}) {
    start = (now ?? DateTime.now()).add(const Duration(hours: 2));
  }

  DateTime get end => start.add(Duration(minutes: durationMin));
  int get maxRounds => swissRoundsFit(durationMin, baseMin, incSec);
  List<int> get percents => splitPresets[split]!;
  int get sponsorFee =>
      sponsorFeeUgx(sponsor, piecesA: piecesA, piecesB: piecesB);

  /// What the host pays now: creation fee + the whole prize pool (locked)
  /// + the sponsor fee. [isDeveloper] skips the creation fee.
  int totalToPay({bool isDeveloper = false}) =>
      (isDeveloper ? 0 : creationFeeUgx) + poolUgx + sponsorFee;

  /// Why this draft cannot be created yet. Empty = good to go.
  List<String> problems({DateTime? now}) {
    final t = now ?? DateTime.now();
    final p = <String>[];
    if (name.trim().length < 3) p.add('Give the tournament a name (3+ letters).');
    final r = clockRanges[clock]!;
    if (baseMin < r.minBase || baseMin > r.maxBase ||
        incSec < r.minInc || incSec > r.maxInc) {
      p.add('The clock is outside the ${r.name} range.');
    }
    if (durationMin < minDurationMin || durationMin > maxDurationMin) {
      p.add('Length must be between 30 minutes and 4 hours.');
    }
    final lead = sponsor == SponsorMode.none ? minStartLeadMin : sponsoredLeadMin;
    if (start.isBefore(t.add(Duration(minutes: lead)))) {
      p.add(sponsor == SponsorMode.none
          ? 'Start at least 30 minutes from now.'
          : 'Sponsored tournaments must start at least 6 hours from now, so the artwork can be checked.');
    }
    if (format == TFormat.swiss) {
      if (maxRounds < 3) {
        p.add('Only $maxRounds Swiss rounds fit. Make it longer or the clock faster.');
      } else if (rounds > maxRounds) {
        p.add('At most $maxRounds rounds fit in this time.');
      }
    } else if (!arenaFits(durationMin, baseMin, incSec)) {
      p.add('This clock is too slow for this time window. Make the tournament longer or the clock faster.');
    }
    if (minPlayers < 2) p.add('At least 2 players are needed.');
    if (maxPlayers < minPlayers) p.add('Maximum players must be at least the minimum.');
    if (poolUgx < 10000) p.add('The prize pool must be at least ${ugx(10000)}.');
    if (feeUgx < 0) p.add('The entry fee cannot be negative.');
    if (percents.length > minPlayers) {
      p.add('${percents.length} prizes need at least ${percents.length} players.');
    }
    final board = boardThemeById(boardId), piece = pieceStyleById(pieceId);
    if (!boardApproved(board, piece)) {
      p.add('This board and piece pair is not clear enough. Pick another pair.');
    }
    if (sponsor != SponsorMode.none) {
      if (sponsorA.trim().isEmpty) p.add('Enter the sponsor name.');
      if (piecesA) {
        final e = labelProblem(sponsorA, piece.whiteA, piece.whiteB);
        if (e != null) p.add('White pieces: $e');
      }
      if (sponsor == SponsorMode.half) {
        if (sponsorB.trim().isEmpty) p.add('Enter the second sponsor name.');
        if (piecesB) {
          final e = labelProblem(sponsorB, piece.blackA, piece.blackB);
          if (e != null) p.add('Black pieces: $e');
        }
      }
    }
    return p;
  }
}
