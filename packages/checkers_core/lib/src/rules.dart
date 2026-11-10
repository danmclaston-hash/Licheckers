/// A direction on the board, written for WHITE (white moves "up": row - 1).
/// For black the row part is flipped.
class Dir {
  final int dr, dc;
  const Dir(this.dr, this.dc);
}

const diagForward = [Dir(-1, -1), Dir(-1, 1)];
const diagAll = [Dir(-1, -1), Dir(-1, 1), Dir(1, -1), Dir(1, 1)];

/// Turkish men: straight forward or sideways.
const orthForwardSide = [Dir(-1, 0), Dir(0, -1), Dir(0, 1)];
const orthAll = [Dir(-1, 0), Dir(1, 0), Dir(0, -1), Dir(0, 1)];

/// Frisian straight captures. On a dark-square board the next dark square in
/// a straight line is 2 away, so the step is 2.
const frisianAll = [
  Dir(-1, -1), Dir(-1, 1), Dir(1, -1), Dir(1, 1),
  Dir(-2, 0), Dir(2, 0), Dir(0, -2), Dir(0, 2),
];

/// Which capture must be chosen when there are several.
enum Priority {
  /// Any capture chain is fine (English, Russian, Thai, Jamaican).
  none,

  /// Must take the most pieces (International, Brazilian, Canadian, Turkish).
  maxCount,

  /// Most pieces, then most kings (Spanish).
  spanish,

  /// Most pieces, then capture with a king, then most kings,
  /// then the chain that meets a king first (Italian).
  italian,

  /// Highest value: man = 100, king = 199. On a tie a king must capture.
  frisian,
}

/// What happens when a man lands on the last row in the middle of a capture.
enum MidPromo {
  /// The move ends there and the man is crowned.
  stop,

  /// It keeps capturing as a man; crowned only if the move ENDS on the last row.
  asMan,

  /// It is crowned at once and keeps capturing as a king (Russian).
  asKing,
}

/// All the rules of one variant. The engine reads this; nothing is hard-coded.
class VariantRules {
  final String id;
  final String name;
  final int size;

  /// Rows of men per side at the start.
  final int menRows;

  /// First row (counted from the player's own back edge) that holds men.
  /// 0 for most games; 1 for Turkish (the back row starts empty).
  final int firstMenRow;

  /// true = every square is used and moves are straight (Turkish).
  final bool allSquares;

  /// true = the dark corner is on the player's right (Italian, Spanish,
  /// Jamaican). Only changes which squares are used.
  final bool mirrored;

  /// 0 = white moves first, 1 = black moves first.
  final int firstMover;

  final List<Dir> manMoveDirs;
  final List<Dir> manCaptureDirs;
  final List<Dir> kingMoveDirs;
  final List<Dir> kingCaptureDirs;

  /// Kings slide any distance.
  final bool flyingKings;

  /// A flying king must land on the square right behind the piece it took (Thai).
  final bool kingLandsRightBehind;

  /// false = a man may not capture a king (Italian).
  final bool menCanCaptureKings;

  final Priority priority;

  /// true = a captured piece leaves the board the moment it is jumped
  /// (English, Italian, Turkish, Thai). false = all captured pieces are lifted
  /// together after the move; until then they block the way and cannot be
  /// jumped twice (International, Russian, ...).
  final bool removeAsJumped;

  /// Turkish: inside one capture chain you may not turn back 180 degrees.
  final bool noTurnBack;

  final MidPromo midPromo;

  /// Frisian: the same king may make only this many plain moves in a row
  /// while its owner still has men. null = no limit.
  final int? kingPlainMoveLimit;

  /// Draw after this many plies (half-moves) with no capture and no man move.
  final int drawPlies;

  const VariantRules({
    required this.id,
    required this.name,
    required this.size,
    required this.menRows,
    this.firstMenRow = 0,
    this.allSquares = false,
    this.mirrored = false,
    this.firstMover = 0,
    this.manMoveDirs = diagForward,
    this.manCaptureDirs = diagForward,
    this.kingMoveDirs = diagAll,
    this.kingCaptureDirs = diagAll,
    this.flyingKings = false,
    this.kingLandsRightBehind = false,
    this.menCanCaptureKings = true,
    this.priority = Priority.none,
    this.removeAsJumped = false,
    this.noTurnBack = false,
    this.midPromo = MidPromo.stop,
    this.kingPlainMoveLimit,
    this.drawPlies = 80,
  });

  /// Is this square used in the game?
  bool playable(int row, int col) =>
      allSquares || ((row + col).isOdd != mirrored);
}
