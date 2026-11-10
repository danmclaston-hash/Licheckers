import 'package:checkers_core/checkers_core.dart';
import 'package:test/test.dart';

int sq(VariantRules r, int row, int col) => row * r.size + col;

void main() {
  test('English: a man cannot capture backward', () {
    final p = Position.fromRows(Variants.english, [
      '........', '........', '........', '........',
      '........', '..w.....', '...b....', '........',
    ], white);
    expect(legalMoves(p).any((m) => m.isCapture), isFalse);
  });

  test('English: being crowned ends the move', () {
    final p = Position.fromRows(Variants.english, [
      '........', '..b.b...', '.w......', '........',
      '........', '........', '........', '........',
    ], white);
    final moves = legalMoves(p);
    expect(moves, hasLength(1));
    expect(moves.single.captured, hasLength(1));
    expect(moves.single.promote, isTrue);
  });

  test('International: you must take the most pieces', () {
    final r = Variants.international;
    final p = Position.fromRows(r, [
      '..........', '..........', '..........', '......b...', '..........',
      '..b.b.....', '...w......', '..........', '..........', '..........',
    ], white);
    final moves = legalMoves(p);
    expect(moves, hasLength(1));
    expect(moves.single.captured, hasLength(2));
    expect(moves.single.to, sq(r, 2, 7));
  });

  test('Russian: crowned in mid-capture, keeps capturing as a king', () {
    const rows = [
      '........', '..b.....', '.w...b..', '........',
      '........', '........', '........', '........',
    ];
    final ru = legalMoves(Position.fromRows(Variants.russian, rows, white));
    expect(ru.every((m) => m.captured.length == 2 && m.promote), isTrue);
    // Brazilian: the man stops on the last row and is crowned, 1 capture.
    final br = legalMoves(Position.fromRows(Variants.brazilian, rows, white));
    expect(br.single.captured, hasLength(1));
    expect(br.single.promote, isTrue);
  });

  test('Italian: a man cannot capture a king', () {
    final p = Position.fromRows(Variants.italian, [
      '........', '........', '........', '...B....',
      '..w.....', '........', '........', '........',
    ], white);
    expect(legalMoves(p).any((m) => m.isCapture), isFalse);
  });

  test('Turkish: men capture sideways', () {
    final p = Position.fromRows(Variants.turkish, [
      '........', '........', '........', '........',
      '...wb...', '........', '........', '........',
    ], white);
    expect(legalMoves(p).single.captured, hasLength(1));
  });

  test('Turkish: no 180-degree turn inside a capture', () {
    final p = Position.fromRows(Variants.turkish, [
      '........', '........', '........', '........',
      '.b.W.b..', '........', '........', '........',
    ], white);
    final moves = legalMoves(p);
    expect(moves, isNotEmpty);
    expect(moves.every((m) => m.captured.length == 1), isTrue);
  });

  test('Thai: a king lands right behind the piece it takes', () {
    final r = Variants.thai;
    final p = Position.fromRows(r, [
      '........', '........', '........', '........',
      '........', '..b.....', '........', 'W.......',
    ], white);
    final moves = legalMoves(p);
    expect(moves.single.to, sq(r, 4, 3));
  });

  test('Frisian: men capture straight sideways', () {
    final r = Variants.frisian;
    final p = Position.fromRows(r, [
      '..........', '..........', '..........', '..........', '..........',
      '..w.b.....', '..........', '..........', '..........', '..........',
    ], white);
    final moves = legalMoves(p);
    expect(moves.single.to, sq(r, 5, 6));
  });

  test('Frisian: the same king may only make 3 plain moves in a row', () {
    final r = Variants.frisian;
    final g = Game(r,
        start: Position.fromRows(r, [
          '.b.b......', '..b.......', '..........', '..........', '..........',
          '..........', '..........', '..........', '..........', 'W.......w.',
        ], white));
    var king = sq(r, 9, 0);
    for (var i = 0; i < 3; i++) {
      final target = i.isEven ? sq(r, 8, 1) : sq(r, 9, 0);
      expect(g.play(Move(king, target)), isTrue);
      king = target;
      // Black plays a quiet move that stays far from the white king.
      final quiet = g.legal.reduce((a, b) => a.to % 10 <= b.to % 10 ? a : b);
      expect(quiet.isCapture, isFalse);
      expect(g.play(quiet), isTrue);
    }
    expect(g.movesFrom(king), isEmpty, reason: 'king must rest');
    expect(g.legal, isNotEmpty, reason: 'the man can still move');
  });

  test('Game refuses an illegal move', () {
    final g = Game(Variants.english);
    expect(g.play(const Move(0, 63)), isFalse);
    expect(g.moves, isEmpty);
    expect(g.play(g.legal.first), isTrue);
  });

  test('Every variant: random games finish without errors', () {
    for (final r in Variants.all) {
      var seed = 7;
      for (var gameNo = 0; gameNo < 20; gameNo++) {
        final g = Game(r);
        var plies = 0;
        while (g.result == GameResult.ongoing && plies < 600) {
          seed = (seed * 1103515245 + 12345) & 0x7fffffff;
          g.play(g.legal[seed % g.legal.length]);
          plies++;
        }
        expect(g.result != GameResult.ongoing || plies == 600, isTrue);
      }
    }
  });
}
