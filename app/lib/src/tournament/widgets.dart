import 'dart:async';
import 'dart:typed_data';

import 'package:checkers_core/checkers_core.dart';
import 'package:flutter/material.dart';

import '../board_view.dart';
import '../i18n.dart';
import '../theme.dart';
import 'sponsor_logo.dart';
import 'tournament_rules.dart';

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
    final l = context.l;
    final now = DateTime.now();
    final String text;
    if (now.isBefore(widget.start)) {
      text = l.startsIn(timeLeft(l, widget.start.difference(now)));
    } else if (now.isBefore(widget.end)) {
      text = l.liveEndsIn(timeLeft(l, widget.end.difference(now)));
    } else {
      text = l.finished;
    }
    return Text(text,
        style: (widget.style ?? const TextStyle())
            .copyWith(fontFeatures: const [FontFeature.tabularFigures()]));
  }
}

String clockName(L l, ClockType c) => switch (c) {
      ClockType.bullet => l.clock_bullet,
      ClockType.blitz => l.clock_blitz,
      ClockType.rapid => l.clock_rapid,
      ClockType.classic => l.clock_classic,
    };

/// "3+2 Blitz"
String clockText(L l, TournamentDraft d) =>
    '${clockLabel(d.baseMin, d.incSec)} ${clockName(l, d.clock)}';

String formatName(L l, TFormat f) => f == TFormat.arena ? l.arena : l.swiss;

String labelIssueText(L l, LabelIssue i) => switch (i) {
      LabelIssue.empty => l.lbl_empty(maxLabelLength),
      LabelIssue.tooLong => l.lbl_tooLong(maxLabelLength),
      LabelIssue.unreadable => l.lbl_unreadable,
    };

String problemText(L l, Problem p, TournamentDraft d) => switch (p.code) {
      ProblemCode.nameShort => l.p_nameShort,
      ProblemCode.clockRange => l.p_clockRange(clockName(l, d.clock)),
      ProblemCode.lengthRange => l.p_lengthRange,
      ProblemCode.startSoon => l.p_startSoon,
      ProblemCode.sponsoredStartSoon => l.p_sponsoredStartSoon,
      ProblemCode.swissFew => l.p_swissFew(p.n),
      ProblemCode.swissTooMany => l.p_swissTooMany(p.n),
      ProblemCode.arenaTooSlow => l.p_arenaTooSlow,
      ProblemCode.minPlayers => l.p_minPlayers,
      ProblemCode.maxBelowMin => l.p_maxBelowMin,
      ProblemCode.poolTooSmall => l.p_poolTooSmall(ugx(p.n)),
      ProblemCode.prizesNeedPlayers => l.p_prizesNeedPlayers(p.n),
      ProblemCode.boardUnclear => l.p_boardUnclear,
      ProblemCode.sponsorName => l.p_sponsorName,
      ProblemCode.sponsor2Name => l.p_sponsor2Name,
      ProblemCode.whiteLabel => l.p_whiteLabel(labelIssueText(l, p.label!)),
      ProblemCode.blackLabel => l.p_blackLabel(labelIssueText(l, p.label!)),
    };

String logoErrorText(L l, LogoError e) => switch (e.issue) {
      LogoIssue.svg => l.e_svg,
      LogoIssue.type => l.e_type,
      LogoIssue.big => l.e_big,
      LogoIssue.empty => l.e_empty,
      LogoIssue.https => l.e_https,
      LogoIssue.link => l.e_link,
      LogoIssue.http => l.e_http('${e.httpCode}'),
      LogoIssue.webpage => l.e_webpage,
      LogoIssue.notPicture => l.e_notPicture,
    };

String checkText(L l, CheckKind k) => switch (k) {
      CheckKind.whiteOnDark => l.check_whiteOnDark,
      CheckKind.blackOnDark => l.check_blackOnDark,
      CheckKind.sidesApart => l.check_sidesApart,
      CheckKind.squaresApart => l.check_squaresApart,
    };

String splitName(L l, String key) => switch (key) {
      'Winner takes all' => l.split_winner,
      'Top 3' => l.split_top3,
      'Top 5' => l.split_top5,
      _ => key,
    };

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
        Flexible(
          child: Text(text,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: c)),
        ),
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
                    context.l.checkLine(checkText(context.l, c.kind),
                        c.value.toStringAsFixed(1), c.need.toStringAsFixed(1)),
                    style: t.textTheme.bodySmall)),
          ]),
        ),
    ]);
  }
}


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
  final Uint8List? logo;
  const SponsorStrip(this.text, this.colour, {super.key, this.logo});

  @override
  Widget build(BuildContext context) {
    final ink = colour.computeLuminance() > .45 ? Colors.black : Colors.white;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
          color: colour, borderRadius: BorderRadius.circular(8)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (logo != null) ...[
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(4)),
            child: Image.memory(logo!, height: 26, fit: BoxFit.contain),
          ),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Text(text,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: ink, fontWeight: FontWeight.w700, fontSize: 13)),
        ),
      ]),
    );
  }
}
