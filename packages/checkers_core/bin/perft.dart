import 'package:checkers_core/checkers_core.dart';

/// Usage: dart run bin/perft.dart <variant> <depth>
void main(List<String> args) {
  final rules = Variants.byId(args.isEmpty ? 'english' : args[0]);
  final depth = args.length > 1 ? int.parse(args[1]) : 6;
  final pos = Position.initial(rules);
  final sw = Stopwatch()..start();
  for (var d = 1; d <= depth; d++) {
    print('${rules.id} perft($d) = ${perft(pos, d)}  [${sw.elapsedMilliseconds} ms]');
  }
}
