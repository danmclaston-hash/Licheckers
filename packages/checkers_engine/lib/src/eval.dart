import 'package:checkers_core/checkers_core.dart';

/// A win is worth this much (minus the number of moves it takes).
const int mateScore = 30000;

/// How good is this position for the side to move? 100 = one man ahead.
///
/// What it looks at, and why:
///  - material: more pieces usually wins
///  - kings: worth more, far more when they can fly
///  - advancement: men close to crowning are dangerous
///  - back row: men at home stop the opponent from crowning
///  - centre: pieces in the middle control more squares
///  - trade when ahead: being 1 up with 3 pieces beats 1 up with 12
int evaluate(Position p) {
  final r = p.rules, n = r.size, b = p.board;
  final kingValue = !r.flyingKings ? 165 : (r.allSquares ? 500 : 320);
  final mid2 = n - 1; // twice the centre column
  var w = 0, bl = 0, wMat = 0, bMat = 0, pieces = 0;
  for (var sq = 0; sq < b.length; sq++) {
    final pc = b[sq];
    if (pc == 0) continue;
    pieces++;
    final row = sq ~/ n, col = sq % n;
    final centre = (n - (2 * col - mid2).abs()) ~/ 2; // 0 at edge .. n/2
    switch (pc) {
      case wMan:
        final adv = n - 1 - row;
        wMat += 100;
        w += adv * 3 + centre + (row == n - 1 && !r.allSquares ? 8 : 0);
        if (adv >= n - 3) w += 12; // about to crown
      case bMan:
        final adv = row;
        bMat += 100;
        bl += adv * 3 + centre + (row == 0 && !r.allSquares ? 8 : 0);
        if (adv >= n - 3) bl += 12;
      case wKing:
        wMat += kingValue;
        w += centre * 2;
      case bKing:
        bMat += kingValue;
        bl += centre * 2;
    }
  }
  var score = (wMat - bMat) + (w - bl);
  score += ((wMat - bMat) * 6) ~/ (pieces + 2); // trade when ahead
  score = p.turn == white ? score : -score;
  return score + 4; // small bonus for having the move
}
