import 'rules.dart';

/// The 9 variants. To add a variant, add one object here.
///
/// Thai and Jamaican were removed until their rules can be confirmed.
///
/// Open questions (confirm with a national federation before money games):
///  - Turkish: a man that reaches the last row mid-capture. Here: becomes a
///    king at once and continues.
///  - Special endgame draw counts (e.g. Frisian 2 kings v 1 king = 7 moves)
///    are not modelled yet; only the general no-progress rule is.
abstract final class Variants {
  static const english = VariantRules(
    id: 'english', name: 'English (American)', size: 8, menRows: 3,
    firstMover: 1,
    removeAsJumped: true,
    drawPlies: 80,
  );

  static const international = VariantRules(
    id: 'international', name: 'International', size: 10, menRows: 4,
    manCaptureDirs: diagAll,
    flyingKings: true,
    priority: Priority.maxCount,
    midPromo: MidPromo.asMan,
    drawPlies: 50,
  );

  static const brazilian = VariantRules(
    id: 'brazilian', name: 'Brazilian', size: 8, menRows: 3,
    manCaptureDirs: diagAll,
    flyingKings: true,
    priority: Priority.maxCount,
    midPromo: MidPromo.asMan,
    drawPlies: 40,
  );

  static const russian = VariantRules(
    id: 'russian', name: 'Russian', size: 8, menRows: 3,
    manCaptureDirs: diagAll,
    flyingKings: true,
    midPromo: MidPromo.asKing,
    drawPlies: 30,
  );

  static const italian = VariantRules(
    id: 'italian', name: 'Italian', size: 8, menRows: 3,
    mirrored: true,
    menCanCaptureKings: false,
    priority: Priority.italian,
    removeAsJumped: true,
    drawPlies: 80,
  );

  static const spanish = VariantRules(
    id: 'spanish', name: 'Spanish', size: 8, menRows: 3,
    mirrored: true,
    flyingKings: true,
    priority: Priority.spanish,
    drawPlies: 50,
  );

  static const turkish = VariantRules(
    id: 'turkish', name: 'Turkish (Dama)', size: 8, menRows: 2, firstMenRow: 1,
    allSquares: true,
    manMoveDirs: orthForwardSide,
    manCaptureDirs: orthForwardSide,
    kingMoveDirs: orthAll,
    kingCaptureDirs: orthAll,
    flyingKings: true,
    priority: Priority.maxCount,
    removeAsJumped: true,
    noTurnBack: true,
    midPromo: MidPromo.asKing,
    drawPlies: 80,
  );

  static const frisian = VariantRules(
    id: 'frisian', name: 'Frisian', size: 10, menRows: 4,
    manCaptureDirs: frisianAll,
    kingCaptureDirs: frisianAll,
    flyingKings: true,
    priority: Priority.frisian,
    midPromo: MidPromo.asMan,
    kingPlainMoveLimit: 3,
    drawPlies: 50,
  );

  static const canadian = VariantRules(
    id: 'canadian', name: 'Canadian', size: 12, menRows: 5,
    manCaptureDirs: diagAll,
    flyingKings: true,
    priority: Priority.maxCount,
    midPromo: MidPromo.asMan,
    drawPlies: 50,
  );

  static const all = [
    english, international, brazilian, russian, italian, spanish,
    turkish, frisian, canadian,
  ];

  static VariantRules byId(String id) => all.firstWhere((v) => v.id == id);
}
