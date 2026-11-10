import 'package:checkers_core/checkers_core.dart';
import 'package:test/test.dart';

/// perft = count every line of play from the start to a given depth.
/// If our counts equal the published counts, the move rules are right.
void main() {
  // Published reference counts (same numbers as Scan / pydraughts / dctl).
  const reference = {
    'english': [7, 49, 302, 1469, 7361, 36768, 179740, 845931],
    'international': [9, 81, 658, 4265, 27117, 167140, 1049442],
    'frisian': [9, 81, 658, 3874, 21265, 102431, 540126],
    'russian': [7, 49, 302, 1469, 7482, 37986, 190146],
  };
  // Our own counts, frozen so a later change that alters the rules by
  // accident is caught. Not yet compared with an outside program.
  const frozen = {
    'brazilian': [7, 49, 302, 1469, 7473, 37628, 187302],
    'italian': [7, 49, 302, 1469, 7361, 36473, 177532],
    'spanish': [7, 49, 302, 1469, 7361],
    'turkish': [8, 64, 708, 7538, 85090],
    'canadian': [11, 121, 1222, 10053, 79049],
  };

  void check(String label, Map<String, List<int>> table) {
    group(label, () {
      table.forEach((id, counts) {
        test(id, () {
          final pos = Position.initial(Variants.byId(id));
          for (var d = 1; d <= counts.length; d++) {
            expect(perft(pos, d), counts[d - 1], reason: '$id depth $d');
          }
        });
      });
    });
  }

  check('matches published perft', reference);
  check('frozen perft', frozen);
}
