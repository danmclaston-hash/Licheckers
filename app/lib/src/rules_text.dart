import 'package:checkers_core/checkers_core.dart';

/// Turns a variant's rule settings into plain sentences for the Learn page.
/// Because the text is built from the same settings the engine uses, the
/// lesson can never disagree with how the game actually plays.
List<String> describeRules(VariantRules r) {
  final perSide = Position.initial(r).count(wMan);
  final diag = !r.allSquares;
  final menBack = r.manCaptureDirs.any((d) => d.dr > 0);
  final straightCaps = diag && r.manCaptureDirs.any((d) => d.dr == 0);
  return [
    'Board: ${r.size}x${r.size}. Each player starts with $perSide men'
        '${diag ? ' on the dark squares' : ', using every square'}.',
    '${r.firstMover == white ? 'White' : 'Black'} moves first.',
    diag
        ? 'Men move one square diagonally forward.'
        : 'Men move one square straight forward or sideways.',
    if (straightCaps)
      'Men capture in all 8 directions: diagonally and in straight lines.'
    else if (!diag)
      'Men capture by jumping straight forward or sideways.'
    else if (menBack)
      'Men capture forward and backward.'
    else
      'Men capture forward only.',
    if (!r.menCanCaptureKings) 'A man is not allowed to capture a king.',
    r.flyingKings
        ? 'Kings fly: they slide any number of empty squares '
            '${diag ? 'diagonally' : 'in a straight line'}, and can capture from far away.'
        : 'Kings move one square in any diagonal direction.',
    'If you can capture, you must. A capture chain must be finished.',
    switch (r.priority) {
      Priority.none => 'If several captures are possible, you choose which one.',
      Priority.maxCount => 'You must choose the capture that takes the most pieces.',
      Priority.spanish =>
        'You must take the most pieces. If equal, the capture with the most kings.',
      Priority.italian =>
        'You must take the most pieces. If equal: capture with a king, then take the most kings, then the chain that meets a king first.',
      Priority.frisian =>
        'You must take the highest value (a king counts a little less than two men). If equal, a king must do the capturing.',
    },
    r.removeAsJumped
        ? 'A captured piece leaves the board the moment it is jumped.'
        : 'Captured pieces are lifted off together after the move. Until then they block the way and cannot be jumped twice.',
    if (r.noTurnBack) 'Inside one capture you may not turn back 180 degrees.',
    switch (r.midPromo) {
      MidPromo.stop => 'A man that reaches the last row becomes a king and the move ends.',
      MidPromo.asMan =>
        'A man becomes a king only if its move ENDS on the last row. If it passes through during a capture, it stays a man.',
      MidPromo.asKing =>
        'A man that reaches the last row during a capture becomes a king at once and keeps capturing as a king.',
    },
    if (r.kingPlainMoveLimit != null)
      'The same king may make only ${r.kingPlainMoveLimit} quiet moves in a row while you still have men.',
    'You lose if you have no pieces or no legal move.',
    'Draw: the same position three times, or ${r.drawPlies ~/ 2} moves each with no capture and no man move.',
  ];
}

/// One short line for lists.
String tagline(VariantRules r) {
  final kings = r.flyingKings ? 'flying kings' : 'short kings';
  final extra = switch (r.id) {
    'turkish' => 'straight moves',
    'frisian' => 'captures in 8 directions',
    'italian' => 'men cannot take kings',
    'russian' => 'free choice of capture',
    'english' => 'men capture forward only',
    'spanish' => 'men capture forward only',
    _ => 'must take the most pieces',
  };
  return '${r.size}x${r.size} · $kings · $extra';
}
