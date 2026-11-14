import 'dart:math';

import 'package:checkers_core/checkers_core.dart';
import 'package:flutter/material.dart';

import 'theme.dart';

/// Draws the board and pieces and animates the last move.
///
/// Everything is painted on one canvas, so it stays smooth on cheap phones.
/// The widget only shows what it is given; all rules live in checkers_core.
class BoardView extends StatefulWidget {
  final Position position;

  /// The position before [lastMove]; needed to animate it.
  final Position? previous;
  final Move? lastMove;

  /// Goes up by one each time a new move is played. That starts the animation.
  final int moveSerial;

  /// true = black at the bottom.
  final bool flipped;
  final BoardTheme theme;
  final PieceStyle style;

  /// Time for one sliding step. 0 = no animation.
  final int animMs;
  final bool showCoords;
  final int? selected;
  final Set<int> targets;
  final Set<int> mustMove;
  final void Function(int square)? onTap;

  /// Sponsor names written on the pieces (tournaments only). null = none.
  final String? whiteLabel, blackLabel;

  const BoardView({
    super.key,
    required this.position,
    required this.theme,
    required this.style,
    this.previous,
    this.lastMove,
    this.moveSerial = 0,
    this.flipped = false,
    this.animMs = 220,
    this.showCoords = true,
    this.selected,
    this.targets = const {},
    this.mustMove = const {},
    this.onTap,
    this.whiteLabel,
    this.blackLabel,
  });

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, value: 1);

  @override
  void didUpdateWidget(BoardView old) {
    super.didUpdateWidget(old);
    final m = widget.lastMove;
    final reduce = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (widget.moveSerial == old.moveSerial + 1 &&
        m != null &&
        widget.previous != null &&
        widget.animMs > 0 &&
        !reduce) {
      _c.duration = Duration(milliseconds: widget.animMs * m.path.length);
      _c.forward(from: 0);
    } else if (widget.moveSerial != old.moveSerial) {
      _c.value = 1;
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final n = widget.position.size;
    final scheme = Theme.of(context).colorScheme;
    // The board never mirrors, even in right-to-left languages like Arabic.
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(builder: (context, box) {
        final side = box.biggest.shortestSide;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapUp: widget.onTap == null
              ? null
              : (d) {
                  final cell = side / n;
                  var col = (d.localPosition.dx / cell).floor();
                  var row = (d.localPosition.dy / cell).floor();
                  if (row < 0 || col < 0 || row >= n || col >= n) return;
                  if (widget.flipped) {
                    row = n - 1 - row;
                    col = n - 1 - col;
                  }
                  widget.onTap!(row * n + col);
                },
          child: Semantics(
            label: '${widget.position.rules.name} board',
            child: RepaintBoundary(
              child: CustomPaint(
                size: Size.square(side),
                painter: _BoardPainter(widget, _c, scheme.primary,
                    scheme.secondary, Directionality.of(context)),
              ),
            ),
          ),
        );
      }),
      ),
    );
  }
}

class _BoardPainter extends CustomPainter {
  final BoardView w;
  final Animation<double> anim;
  final Color accent, warn;
  final TextDirection dir;
  _BoardPainter(this.w, this.anim, this.accent, this.warn, this.dir)
      : super(repaint: anim);

  @override
  void paint(Canvas canvas, Size size) {
    final rules = w.position.rules, n = rules.size;
    final cell = size.width / n;
    final full = Offset.zero & size;
    final t = w.theme;

    Offset centre(int sq) {
      var row = sq ~/ n, col = sq % n;
      if (w.flipped) {
        row = n - 1 - row;
        col = n - 1 - col;
      }
      return Offset((col + .5) * cell, (row + .5) * cell);
    }

    Rect square(int sq) =>
        Rect.fromCenter(center: centre(sq), width: cell, height: cell);

    // --- Squares: one gradient for light squares, one for dark squares.
    Shader grad(Color a, Color b) => LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [a, b],
        ).createShader(full);
    canvas.clipRRect(RRect.fromRectAndRadius(full, Radius.circular(cell * .12)));
    canvas.drawRect(full, Paint()..shader = grad(t.lightA, t.lightB));
    final darkPaint = Paint()..shader = grad(t.darkA, t.darkB);
    final linePaint = Paint()
      ..color = t.frame.withValues(alpha: .35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var sq = 0; sq < n * n; sq++) {
      final row = sq ~/ n, col = sq % n;
      if (rules.allSquares) {
        // Turkish uses every square: draw one colour with thin lines.
        canvas.drawRect(square(sq), linePaint);
      } else if (rules.playable(row, col)) {
        canvas.drawRect(square(sq), darkPaint);
      }
    }

    // --- Highlights.
    final m = w.lastMove;
    if (m != null) {
      final hl = Paint()..color = warn.withValues(alpha: .32);
      canvas.drawRect(square(m.from), hl);
      canvas.drawRect(square(m.to), hl);
    }
    if (w.selected != null) {
      canvas.drawRect(
          square(w.selected!), Paint()..color = accent.withValues(alpha: .55));
    }

    // --- Square names.
    // Too small to read on tiny boards (under 30 px squares): skip them.
    if (w.showCoords && cell >= 30) {
      final onDark = _contrast(rules.allSquares ? t.lightA : t.darkA);
      for (var sq = 0; sq < n * n; sq++) {
        if (!rules.playable(sq ~/ n, sq % n)) continue;
        final tp = TextPainter(
          text: TextSpan(
            text: squareName(rules, sq),
            style: TextStyle(
                fontSize: max(10, cell * .2),
                fontWeight: FontWeight.w700,
                color: onDark.withValues(alpha: .85)),
          ),
          textDirection: dir,
        )..layout();
        tp.paint(canvas, square(sq).topLeft + Offset(cell * .06, cell * .04));
      }
    }

    // --- Pieces.
    final r = cell * .39;
    final animating = anim.value < 1 && m != null && w.previous != null;
    if (!animating) {
      final b = w.position.board;
      for (var sq = 0; sq < b.length; sq++) {
        if (b[sq] != 0) _piece(canvas, centre(sq), r, b[sq]);
      }
    } else {
      final b = w.previous!.board;
      final stops = [m.from, ...m.path];
      final segs = m.path.length;
      final x = anim.value * segs;
      final seg = min(x.floor(), segs - 1);
      final local = Curves.easeInOut.transform((x - seg).clamp(0.0, 1.0));
      for (var sq = 0; sq < b.length; sq++) {
        if (b[sq] == 0 || sq == m.from) continue;
        final ci = m.captured.indexOf(sq);
        // Some variants lift captured pieces only when the move is over.
        // There a jumped piece turns into a faint "ghost" until the end.
        final ghost = rules.removeAsJumped ? 0.0 : .35;
        if (ci < 0 || ci > seg) {
          _piece(canvas, centre(sq), r, b[sq]);
        } else if (ci == seg) {
          // Being jumped right now: fade and shrink.
          _piece(canvas, centre(sq), r * (1 - .3 * local), b[sq],
              opacity: 1 - (1 - ghost) * local);
        } else if (ghost > 0) {
          _piece(canvas, centre(sq), r * .7, b[sq], opacity: ghost);
        }
      }
      // The moving piece hops from stop to stop.
      final a = centre(stops[seg]), z = centre(stops[seg + 1]);
      final hop = sin(pi * local);
      var piece = b[m.from];
      if (m.promote && seg == segs - 1 && local > .6) {
        piece = sideOf(piece) == white ? wKing : bKing;
      }
      _piece(canvas, Offset.lerp(a, z, local)!, r * (1 + .14 * hop), piece,
          lift: hop * cell * .12);
    }

    // --- Hints drawn above the pieces.
    if (!animating) {
      for (final sq in w.mustMove) {
        if (sq == w.selected) continue;
        canvas.drawCircle(
            centre(sq),
            r * 1.08,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = cell * .05
              ..color = warn);
      }
      for (final sq in w.targets) {
        canvas.drawCircle(centre(sq), cell * .15,
            Paint()..color = accent.withValues(alpha: .85));
        canvas.drawCircle(
            centre(sq),
            cell * .15,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.5
              ..color = Colors.white.withValues(alpha: .7));
      }
    }
  }

  static Color _contrast(Color c) =>
      c.computeLuminance() > .5 ? Colors.black : Colors.white;

  void _piece(Canvas canvas, Offset c, double r, int piece,
      {double opacity = 1, double lift = 0}) {
    final s = w.style;
    final isWhite = sideOf(piece) == white;
    final a = isWhite ? s.whiteA : s.blackA, b = isWhite ? s.whiteB : s.blackB;
    final bounds = Rect.fromCircle(center: c, radius: r * 1.4);
    if (opacity < 1) {
      canvas.saveLayer(
          bounds, Paint()..color = Colors.white.withValues(alpha: opacity));
    }
    if (!s.flat) {
      // Soft shadow on the board, then the coin's edge.
      canvas.drawCircle(
          c + Offset(0, r * .16 + lift),
          r,
          Paint()
            ..color = Colors.black.withValues(alpha: .35)
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * .18));
      canvas.drawCircle(c + Offset(0, r * .10),
          r, Paint()..color = Color.lerp(b, Colors.black, .35)!);
    }
    final top = Rect.fromCircle(center: c, radius: r);
    canvas.drawCircle(
        c,
        r,
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(-.35, -.45),
            radius: 1.1,
            colors: [a, b],
          ).createShader(top));
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * .07
      ..color = (isWhite ? Colors.black : Colors.white)
          .withValues(alpha: s.flat ? .25 : .16);
    canvas.drawCircle(c, r * .96, ring);
    canvas.drawCircle(c, r * .68, ring);
    if (s.glossy) {
      canvas.drawOval(
          Rect.fromCenter(
              center: c + Offset(0, -r * .45), width: r * 1.1, height: r * .5),
          Paint()..color = Colors.white.withValues(alpha: .35));
    }
    final label = isWhite ? w.whiteLabel : w.blackLabel;
    if (label != null && label.trim().isNotEmpty) {
      _label(canvas, c, r, label.trim().toUpperCase(), a, b, isKing(piece));
    }
    if (isKing(piece)) _crown(canvas, c, r * .52, s.crown);
    if (opacity < 1) canvas.restore();
  }

  /// A short sponsor name on the coin. On a king it sits low, under the crown.
  void _label(Canvas canvas, Offset c, double r, String text, Color a, Color b,
      bool king) {
    final fill = Color.lerp(a, b, .5)!;
    final ink = fill.computeLuminance() > .4 ? Colors.black : Colors.white;
    var tp = TextPainter(
      text: TextSpan(
          text: text,
          style: TextStyle(
              fontSize: r * .62, fontWeight: FontWeight.w800, color: ink)),
      textDirection: dir,
    )..layout();
    final maxW = r * 1.45;
    if (tp.width > maxW) {
      tp = TextPainter(
        text: TextSpan(
            text: text,
            style: TextStyle(
                fontSize: r * .62 * maxW / tp.width,
                fontWeight: FontWeight.w800,
                color: ink)),
        textDirection: dir,
      )..layout();
    }
    final at = c + Offset(0, king ? r * .5 : 0);
    tp.paint(canvas, at - Offset(tp.width / 2, tp.height / 2));
  }

  void _crown(Canvas canvas, Offset c, double h, Color color) {
    final p = Path()
      ..moveTo(c.dx - h, c.dy + h * .6)
      ..lineTo(c.dx - h, c.dy - h * .45)
      ..lineTo(c.dx - h * .45, c.dy + h * .05)
      ..lineTo(c.dx, c.dy - h * .75)
      ..lineTo(c.dx + h * .45, c.dy + h * .05)
      ..lineTo(c.dx + h, c.dy - h * .45)
      ..lineTo(c.dx + h, c.dy + h * .6)
      ..close();
    canvas.drawPath(
        p.shift(Offset(0, h * .08)), Paint()..color = Colors.black38);
    canvas.drawPath(p, Paint()..color = color);
    canvas.drawPath(
        p,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = h * .12
          ..strokeJoin = StrokeJoin.round
          ..color = Color.lerp(color, Colors.black, .45)!);
  }

  @override
  bool shouldRepaint(_BoardPainter old) => true;
}
