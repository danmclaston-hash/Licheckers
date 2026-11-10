/// One full move: a plain step, or a whole capture chain.
class Move {
  final int from;
  final int to;

  /// Every square the piece lands on, in order (last one == [to]).
  final List<int> path;

  /// Squares of the captured pieces, in the order they were jumped.
  final List<int> captured;

  /// The piece ends the move as a new king.
  final bool promote;

  // Facts used by the "which capture must I take" rules.
  final bool moverIsKing;
  final int kingsCaptured;
  final int firstKingAt; // index of the first captured king, or 999

  const Move(
    this.from,
    this.to, {
    this.path = const [],
    this.captured = const [],
    this.promote = false,
    this.moverIsKing = false,
    this.kingsCaptured = 0,
    this.firstKingAt = 999,
  });

  bool get isCapture => captured.isNotEmpty;

  /// Same move for the players: same start, same end, same pieces taken.
  bool sameAs(Move o) {
    if (from != o.from || to != o.to) return false;
    if (captured.length != o.captured.length) return false;
    for (final c in captured) {
      if (!o.captured.contains(c)) return false;
    }
    return true;
  }

  @override
  String toString() =>
      isCapture ? '$from x${path.join("x")}' : '$from-$to';
}
