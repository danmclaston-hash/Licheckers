import 'move.dart';
import 'rules.dart';

/// Name of a square as players write it.
/// Diagonal games: used squares are numbered 1, 2, 3... from the top-left.
/// Turkish: letters and numbers like chess (a1 is white's bottom-left).
String squareName(VariantRules rules, int sq) {
  final n = rules.size, row = sq ~/ n, col = sq % n;
  if (rules.allSquares) {
    return '${String.fromCharCode(97 + col)}${n - row}';
  }
  var k = 0;
  for (var i = 0; i <= sq; i++) {
    if (rules.playable(i ~/ n, i % n)) k++;
  }
  return '$k';
}

/// "32-28" for a plain move, "32x23x14" for a capture chain.
String moveText(VariantRules rules, Move m) => m.isCapture
    ? [m.from, ...m.path].map((s) => squareName(rules, s)).join('x')
    : '${squareName(rules, m.from)}-${squareName(rules, m.to)}';
