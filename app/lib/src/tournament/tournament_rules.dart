import 'dart:math';
import 'dart:typed_data';

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
const minPoolUgx = 10000;
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

enum CheckKind { whiteOnDark, blackOnDark, sidesApart, squaresApart }

class Check {
  final CheckKind kind;
  final double value, need;
  const Check(this.kind, this.value, this.need);
  bool get ok => value >= need;
}

/// The tests a board + piece pair must pass before a tournament may use it.
List<Check> boardChecks(BoardTheme b, PieceStyle p) {
  final white = _mean(p.whiteA, p.whiteB), black = _mean(p.blackA, p.blackB);
  double onDark(Color piece) => min(
      contrastRatio(piece, b.darkA), contrastRatio(piece, b.darkB));
  return [
    Check(CheckKind.whiteOnDark, onDark(white), minPieceOnSquare),
    Check(CheckKind.blackOnDark, onDark(black), minPieceOnSquare),
    Check(CheckKind.sidesApart, contrastRatio(white, black), minSideApart),
    Check(
        CheckKind.squaresApart,
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

enum LabelIssue { empty, tooLong, unreadable }

/// null = fine, otherwise why a sponsor name cannot go on the pieces.
LabelIssue? labelProblem(String text, Color pieceA, Color pieceB) {
  final t = text.trim();
  if (t.isEmpty) return LabelIssue.empty;
  if (t.length > maxLabelLength) return LabelIssue.tooLong;
  if (labelColourFor(pieceA, pieceB).$2 < minLabelOnPiece) {
    return LabelIssue.unreadable;
  }
  return null;
}

/// Why a draft cannot be created yet. A code (not English text), so every
/// screen can show it in the user's language.
enum ProblemCode {
  nameShort, clockRange, lengthRange, startSoon, sponsoredStartSoon,
  swissFew, swissTooMany, arenaTooSlow, minPlayers, maxBelowMin,
  poolTooSmall, prizesNeedPlayers, boardUnclear, sponsorName, sponsor2Name,
  whiteLabel, blackLabel,
}

class Problem {
  final ProblemCode code;
  final int n; // a number the message needs (rounds, prizes, amount)
  final LabelIssue? label;
  const Problem(this.code, {this.n = 0, this.label});
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
  String colourA = 'Blue', colourB = 'Red'; // a name in sponsorColours, or 'Logo'
  /// Sponsor logos (pictures) and the main colour found in each.
  Uint8List? logoA, logoB;
  Color? logoColourA, logoColourB;

  /// Until a person approves the logo, only the host can see it.
  bool get logosWaitingForCheck => logoA != null || logoB != null;

  Color get sponsorColourA => colourA == 'Logo' && logoColourA != null
      ? logoColourA!
      : sponsorColours[colourA] ?? sponsorColours['Blue']!;
  Color get sponsorColourB => colourB == 'Logo' && logoColourB != null
      ? logoColourB!
      : sponsorColours[colourB] ?? sponsorColours['Red']!;
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
  List<Problem> problems({DateTime? now}) {
    final t = now ?? DateTime.now();
    final p = <Problem>[];
    void add(ProblemCode c, {int n = 0, LabelIssue? label}) =>
        p.add(Problem(c, n: n, label: label));
    if (name.trim().length < 3) add(ProblemCode.nameShort);
    final r = clockRanges[clock]!;
    if (baseMin < r.minBase || baseMin > r.maxBase ||
        incSec < r.minInc || incSec > r.maxInc) {
      add(ProblemCode.clockRange);
    }
    if (durationMin < minDurationMin || durationMin > maxDurationMin) {
      add(ProblemCode.lengthRange);
    }
    final lead = sponsor == SponsorMode.none ? minStartLeadMin : sponsoredLeadMin;
    if (start.isBefore(t.add(Duration(minutes: lead)))) {
      add(sponsor == SponsorMode.none
          ? ProblemCode.startSoon
          : ProblemCode.sponsoredStartSoon);
    }
    if (format == TFormat.swiss) {
      if (maxRounds < 3) {
        add(ProblemCode.swissFew, n: maxRounds);
      } else if (rounds > maxRounds) {
        add(ProblemCode.swissTooMany, n: maxRounds);
      }
    } else if (!arenaFits(durationMin, baseMin, incSec)) {
      add(ProblemCode.arenaTooSlow);
    }
    if (minPlayers < 2) add(ProblemCode.minPlayers);
    if (maxPlayers < minPlayers) add(ProblemCode.maxBelowMin);
    if (poolUgx < minPoolUgx) add(ProblemCode.poolTooSmall, n: minPoolUgx);
    if (percents.length > minPlayers) {
      add(ProblemCode.prizesNeedPlayers, n: percents.length);
    }
    final board = boardThemeById(boardId), piece = pieceStyleById(pieceId);
    if (!boardApproved(board, piece)) add(ProblemCode.boardUnclear);
    if (sponsor != SponsorMode.none) {
      if (sponsorA.trim().isEmpty) add(ProblemCode.sponsorName);
      if (piecesA) {
        final e = labelProblem(sponsorA, piece.whiteA, piece.whiteB);
        if (e != null) add(ProblemCode.whiteLabel, label: e);
      }
      if (sponsor == SponsorMode.half) {
        if (sponsorB.trim().isEmpty) add(ProblemCode.sponsor2Name);
        if (piecesB) {
          final e = labelProblem(sponsorB, piece.blackA, piece.blackB);
          if (e != null) add(ProblemCode.blackLabel, label: e);
        }
      }
    }
    return p;
  }
}
