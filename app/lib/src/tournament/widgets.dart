import 'dart:async';

import 'package:checkers_core/checkers_core.dart';
import 'package:flutter/material.dart';

import '../board_view.dart';
import '../theme.dart';
import 'tournament_rules.dart';

/// "1h 12m 05s" style text.
String formatLeft(Duration d) {
  if (d.isNegative) return '0s';
  final h = d.inHours, m = d.inMinutes % 60, s = d.inSeconds % 60;
  if (h > 0) return '${h}h ${m.toString().padLeft(2, '0')}m';
  return '${m}m ${s.toString().padLeft(2, '0')}s';
}

/// Live countdown: to the start, then to the end.
/// (Uses this device's clock for now; the server's clock once online.)
class Countdown extends StatefulWidget {
  final DateTime start, end;
  final TextStyle? style;
  const Countdown({super.key, required this.start, required this.end, this.style});

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  Timer? _t;

  @override
  void initState() {
    super.initState();
    _t = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final String text;
    if (now.isBefore(widget.start)) {
      text = 'Starts in ${formatLeft(widget.start.difference(now))}';
    } else if (now.isBefore(widget.end)) {
      text = 'Live: ends in ${formatLeft(widget.end.difference(now))}';
    } else {
      text = 'Finished';
    }
    return Text(text, style: widget.style);
  }
}

String clockText(TournamentDraft d) =>
    '${clockLabel(d.baseMin, d.incSec)} ${clockRanges[d.clock]!.name}';

String ordinal(int n) =>
    n == 1 ? '1st' : n == 2 ? '2nd' : n == 3 ? '3rd' : '${n}th';

String twoDigits(int n) => n.toString().padLeft(2, '0');

String dayTime(DateTime t) {
  const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return '${days[t.weekday - 1]} ${t.day} ${months[t.month - 1]}, ${twoDigits(t.hour)}:${twoDigits(t.minute)}';
}

String hoursText(int minutes) {
  final h = minutes ~/ 60, m = minutes % 60;
  if (h == 0) return '$m min';
  return m == 0 ? '$h h' : '$h h $m min';
}

/// A small rounded tag.
class Tag extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? colour;
  const Tag(this.text, {super.key, this.icon, this.colour});

  @override
  Widget build(BuildContext context) {
    final s = Theme.of(context).colorScheme;
    final c = colour ?? s.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: c.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (icon != null) ...[Icon(icon, size: 13, color: c), const SizedBox(width: 4)],
        Text(text,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: c)),
      ]),
    );
  }
}

/// The real board, with the tournament's board, pieces and sponsor names.
/// Nothing sponsor-related ever touches the board squares.
class BoardPreview extends StatelessWidget {
  final TournamentDraft d;
  final double size;
  const BoardPreview(this.d, {super.key, this.size = 260});

  @override
  Widget build(BuildContext context) {
    final rules = Variants.byId(d.variantId);
    final showA = d.sponsor != SponsorMode.none && d.piecesA;
    final showB = d.sponsor == SponsorMode.half && d.piecesB;
    return SizedBox(
      width: size,
      height: size,
      child: BoardView(
        position: Position.initial(rules),
        theme: boardThemeById(d.boardId),
        style: pieceStyleById(d.pieceId),
        animMs: 0,
        showCoords: false,
        whiteLabel: showA ? d.sponsorA : null,
        blackLabel: showB ? d.sponsorB : null,
      ),
    );
  }
}

/// Ticks and crosses for the readability tests.
class ChecksList extends StatelessWidget {
  final List<Check> checks;
  const ChecksList(this.checks, {super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Column(children: [
      for (final c in checks)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(c.ok ? Icons.check_circle : Icons.cancel,
                size: 18, color: c.ok ? Colors.green : t.colorScheme.error),
            const SizedBox(width: 8),
            Expanded(
                child: Text(
                    '${c.label} (${c.value.toStringAsFixed(1)} : 1, needs ${c.need.toStringAsFixed(1)})',
                    style: t.textTheme.bodySmall)),
          ]),
        ),
    ]);
  }
}

Color? colourOf(String name) => sponsorColours[name];

/// A sponsor-coloured version of the app look, only for the tournament's own
/// screens. The board is drawn from its own theme, so it is never affected.
ThemeData skinTheme(ThemeData base, Color seed) {
  final dark = base.brightness == Brightness.dark;
  final scheme = ColorScheme.fromSeed(seedColor: seed, brightness: dark ? Brightness.dark : Brightness.light)
      .copyWith(
    primary: seed,
    surface: Color.lerp(base.colorScheme.surface, seed, dark ? .10 : .07),
    surfaceContainer: Color.lerp(base.colorScheme.surfaceContainer, seed, dark ? .16 : .05),
    surfaceContainerHigh: Color.lerp(base.colorScheme.surfaceContainerHigh, seed, .2),
  );
  return base.copyWith(
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,
    appBarTheme: base.appBarTheme.copyWith(backgroundColor: scheme.surface),
    cardTheme: base.cardTheme.copyWith(color: scheme.surfaceContainer),
  );
}

/// "Presented by ..." strip. Static, outside the board, never over it.
class SponsorStrip extends StatelessWidget {
  final String text;
  final Color colour;
  const SponsorStrip(this.text, this.colour, {super.key});

  @override
  Widget build(BuildContext context) {
    final ink = colour.computeLuminance() > .45 ? Colors.black : Colors.white;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
          color: colour, borderRadius: BorderRadius.circular(8)),
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(color: ink, fontWeight: FontWeight.w700, fontSize: 13)),
    );
  }
}
