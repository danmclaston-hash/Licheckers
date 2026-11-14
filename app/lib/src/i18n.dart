import 'package:checkers_core/checkers_core.dart';
import 'package:flutter/cupertino.dart' show CupertinoLocalizations;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';

export '../l10n/app_localizations.dart' show L;

/// The languages the app speaks, with their names written in that language.
const appLanguages = <(String, String)>[
  ('en', 'English'),
  ('fr', 'Français'),
  ('sw', 'Kiswahili'),
  ('lg', 'Luganda'),
  ('ar', 'العربية'),
  ('pt', 'Português'),
  ('es', 'Español'),
];

extension L10nX on BuildContext {
  /// All texts in the user's language: `context.l.navPlay`.
  L get l => L.of(this);
}

/// Flutter's own texts (date picker, "OK", "Paste"...) do not exist in
/// Luganda. For Luganda we use the English versions of those few system
/// texts, so the app never crashes; all of OUR texts are still Luganda.
class FallbackMaterialDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialDelegate();
  @override
  bool isSupported(Locale l) => !GlobalMaterialLocalizations.delegate.isSupported(l);
  @override
  Future<MaterialLocalizations> load(Locale l) =>
      GlobalMaterialLocalizations.delegate.load(const Locale('en'));
  @override
  bool shouldReload(covariant LocalizationsDelegate<MaterialLocalizations> old) => false;
}

class FallbackCupertinoDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoDelegate();
  @override
  bool isSupported(Locale l) => !GlobalCupertinoLocalizations.delegate.isSupported(l);
  @override
  Future<CupertinoLocalizations> load(Locale l) =>
      GlobalCupertinoLocalizations.delegate.load(const Locale('en'));
  @override
  bool shouldReload(covariant LocalizationsDelegate<CupertinoLocalizations> old) => false;
}

const appLocalizationsDelegates = <LocalizationsDelegate<dynamic>>[
  L.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  FallbackMaterialDelegate(),
  FallbackCupertinoDelegate(),
];

// ---------------------------------------------------------------------------
// Names
// ---------------------------------------------------------------------------

String variantName(L l, String id) => switch (id) {
      'english' => l.variant_english,
      'international' => l.variant_international,
      'brazilian' => l.variant_brazilian,
      'russian' => l.variant_russian,
      'italian' => l.variant_italian,
      'spanish' => l.variant_spanish,
      'turkish' => l.variant_turkish,
      'frisian' => l.variant_frisian,
      'canadian' => l.variant_canadian,
      _ => id,
    };

String boardName(L l, String id) => switch (id) {
      'walnut' => l.board_walnut,
      'forest' => l.board_forest,
      'ocean' => l.board_ocean,
      'midnight' => l.board_midnight,
      'sunset' => l.board_sunset,
      'clear-green' => l.board_clear_green,
      'clear-brown' => l.board_clear_brown,
      'clear-blue' => l.board_clear_blue,
      'clear-red' => l.board_clear_red,
      'contrast' => l.board_contrast,
      _ => id,
    };

String pieceName(L l, String id) => switch (id) {
      'classic' => l.piece_classic,
      'wood' => l.piece_wood,
      'glass' => l.piece_glass,
      'ruby' => l.piece_ruby,
      'flat' => l.piece_flat,
      _ => id,
    };

String botDescription(L l, int level) => [
      l.bot1, l.bot2, l.bot3, l.bot4, l.bot5, l.bot6, l.bot7, l.bot8, l.bot9,
      l.bot10, l.bot11, l.bot12, l.bot13, l.bot14, l.bot15, l.bot16, l.bot17,
      l.bot18,
    ][(level - 1).clamp(0, 17)];

/// The game engine reports results in English; this translates them.
String reasonText(L l, String? reason) {
  if (reason == null) return '';
  if (reason == 'resignation') return l.reasonResign;
  if (reason == 'no legal moves') return l.reasonNoMoves;
  if (reason == 'same position three times') return l.reasonRepetition;
  final n = RegExp(r'^(\d+) moves each').firstMatch(reason);
  if (n != null) return l.reasonNoProgress(int.parse(n.group(1)!));
  return reason;
}

// ---------------------------------------------------------------------------
// Rules: built from the same settings the engine uses, so a lesson can never
// disagree with how the game really plays, in any language.
// ---------------------------------------------------------------------------

List<String> describeRules(L l, VariantRules r) {
  final perSide = Position.initial(r).count(wMan);
  final diag = !r.allSquares;
  final menBack = r.manCaptureDirs.any((d) => d.dr > 0);
  final straightCaps = diag && r.manCaptureDirs.any((d) => d.dr == 0);
  return [
    diag ? l.ruleBoardDiag(r.size, perSide) : l.ruleBoardAll(r.size, perSide),
    r.firstMover == white ? l.ruleWhiteFirst : l.ruleBlackFirst,
    diag ? l.ruleMenMoveDiag : l.ruleMenMoveStraight,
    if (straightCaps)
      l.ruleMenCapture8
    else if (!diag)
      l.ruleMenCaptureStraight
    else if (menBack)
      l.ruleMenCaptureBoth
    else
      l.ruleMenCaptureForward,
    if (!r.menCanCaptureKings) l.ruleMenNoKings,
    r.flyingKings
        ? (diag ? l.ruleKingsFlyDiag : l.ruleKingsFlyStraight)
        : l.ruleKingsShort,
    l.ruleMustCapture,
    switch (r.priority) {
      Priority.none => l.rulePriorityNone,
      Priority.maxCount => l.rulePriorityMax,
      Priority.spanish => l.rulePrioritySpanish,
      Priority.italian => l.rulePriorityItalian,
      Priority.frisian => l.rulePriorityFrisian,
    },
    r.removeAsJumped ? l.ruleRemoveAsJumped : l.ruleRemoveAfter,
    if (r.noTurnBack) l.ruleNoTurnBack,
    switch (r.midPromo) {
      MidPromo.stop => l.rulePromoStop,
      MidPromo.asMan => l.rulePromoAsMan,
      MidPromo.asKing => l.rulePromoAsKing,
    },
    if (r.kingPlainMoveLimit != null) l.ruleKingLimit(r.kingPlainMoveLimit!),
    l.ruleLose,
    l.ruleDraw(r.drawPlies ~/ 2),
  ];
}

/// One short line for lists.
String tagline(L l, VariantRules r) {
  final kings = r.flyingKings ? l.tagFlyingKings : l.tagShortKings;
  final extra = switch (r.id) {
    'turkish' => l.tagStraightMoves,
    'frisian' => l.tagCaptures8,
    'italian' => l.tagMenNoKings,
    'russian' => l.tagFreeChoice,
    'english' || 'spanish' => l.tagMenForward,
    _ => l.tagMustTakeMost,
  };
  return '${r.size}x${r.size} · $kings · $extra';
}

// ---------------------------------------------------------------------------
// Time
// ---------------------------------------------------------------------------

/// Time left on a countdown: "1h 05m" / "4m 09s" in the user's language.
String timeLeft(L l, Duration d) {
  if (d.isNegative) d = Duration.zero;
  final h = d.inHours, m = d.inMinutes % 60, s = d.inSeconds % 60;
  return h > 0 ? l.leftHM(h, m) : l.leftMS(m, s);
}

/// A length like "2 h 30 min".
String duration(L l, int minutes) {
  final h = minutes ~/ 60, m = minutes % 60;
  if (h == 0) return l.durM(m);
  return m == 0 ? l.durH(h) : l.durHM(h, m);
}

/// "Thu 12 Nov, 20:00" written the way the user's language writes dates.
/// Languages without date data (Luganda) fall back to English month names.
String dayTime(BuildContext context, DateTime t) {
  final code = Localizations.localeOf(context).languageCode;
  final loc = DateFormat.localeExists(code) ? code : 'en';
  try {
    return DateFormat('EEE d MMM, HH:mm', loc).format(t);
  } catch (_) {
    return DateFormat('EEE d MMM, HH:mm', 'en').format(t);
  }
}

/// "1st", "2nd"... in the user's language.
String placeLabel(L l, int n) => l.place('$n');

@visibleForTesting
const supportedCodes = ['en', 'fr', 'sw', 'lg', 'ar', 'pt', 'es'];
