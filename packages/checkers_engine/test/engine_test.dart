import 'package:checkers_core/checkers_core.dart';
import 'package:checkers_engine/checkers_engine.dart';
import 'package:test/test.dart';

void main() {
  jobRoundTrip();
  clockCap();
  test('takes two pieces instead of one when it has the choice (English)', () {
    final p = Position.fromRows(Variants.english, [
      '.b......', '........', '.....b..', '........',
      '.b.b....', '..w.....', '........', '......w.',
    ], white);
    final res = Searcher().search(p, maxDepth: 6);
    expect(res.best.captured, hasLength(2));
  });

  test('sees a forced win', () {
    // Black has one man that is blocked next move.
    final p = Position.fromRows(Variants.english, [
      '........', '........', '........', '........',
      '........', 'b.......', '...w....', 'w.w.....',
    ], white);
    final res = Searcher().search(p, maxDepth: 12);
    expect(res.score, greaterThan(mateScore - 200));
  });

  test('every bot returns a legal move in every variant', () {
    for (final r in Variants.all) {
      final pos = Position.initial(r);
      final legal = legalMoves(pos);
      for (final bot in [bots[0], bots[4], bots[9]]) {
        final m = pickBotMove(pos, bot, seed: 1);
        expect(legal.any((l) => l.sameAs(m)), isTrue, reason: '${r.id} ${bot.name}');
      }
    }
  });

  test('bot games finish in every variant', () {
    for (final r in Variants.all) {
      final g = Game(r);
      final s = Searcher();
      while (g.result == GameResult.ongoing && g.moves.length < 300) {
        expect(
            g.play(pickBotMove(g.position, bots[3],
                history: g.seenKeys, seed: g.moves.length, searcher: s)),
            isTrue);
      }
    }
  });

  test('there are 18 bots, weakest to strongest', () {
    expect(bots, hasLength(18));
    for (var i = 1; i < bots.length; i++) {
      expect(bots[i].depth, greaterThanOrEqualTo(bots[i - 1].depth));
      expect(bots[i].mistakeRate, lessThanOrEqualTo(bots[i - 1].mistakeRate));
    }
  });
}

void jobRoundTrip() {
  test('worker job: replay + answer matches a direct call', () {
    for (final v in Variants.all) {
      final g = Game(v);
      for (var i = 0; i < 6 && g.legal.isNotEmpty; i++) {
        g.play(g.legal[i % g.legal.length]);
      }
      final text = runBotJob(encodeBotJob(g, v.id, 4, 7));
      final m = decodeBotMove(g, text);
      final direct =
          pickBotMove(g.position, bots[3], history: g.seenKeys.toList(), seed: 7);
      expect(m.sameAs(direct), isTrue, reason: v.id);
    }
  });
}

void clockCap() {
  test('a bot on a clock thinks no longer than its time cap', () {
    final g = Game(Variants.international);
    final sw = Stopwatch()..start();
    final text = runBotJob(encodeBotJob(g, 'international', 18, 3, capMs: 200));
    sw.stop();
    expect(g.legal.any((m) => m.sameAs(decodeBotMove(g, text))), isTrue);
    // 200 ms cap plus some slack for a slow test machine.
    expect(sw.elapsedMilliseconds, lessThan(1500));
  });
}
