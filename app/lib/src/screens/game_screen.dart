import 'dart:math';

import 'package:checkers_core/checkers_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../board_view.dart';
import '../game_controller.dart';
import '../i18n.dart';
import '../layout.dart';
import '../settings.dart';
import '../theme.dart';

/// The game. Focus mode: the two players, the board, one status line and
/// one row of buttons, all kept together right around the board. The move
/// list sits in a side panel on wide screens and opens on request on phones.
class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ref.watch(gameProvider);
    final s = ref.watch(settingsProvider);
    final l = context.l;
    final game = c.game, setup = c.setup;
    if (game == null || setup == null) {
      return Scaffold(body: Center(child: Text(l.noGame)));
    }
    c.animMs = s.animMs;
    final vsBot = setup.bot != null;
    // Against the computer your side is at the bottom. With two players on
    // one device the board stays still.
    final bottom = vsBot ? setup.humanSide : white;
    final over = c.result != GameResult.ongoing;

    String name(int side) => vsBot
        ? (side == setup.humanSide ? l.you : setup.bot!.name)
        : (side == white ? l.white : l.black);

    Widget bar(int side) => _PlayerBar(
          name: name(side),
          side: side,
          style: pieceStyleById(s.pieceStyle),
          active: !over && game.position.turn == side,
          thinking: c.thinking && game.position.turn == side,
          taken: _startCount(setup.rules) -
              game.position.count(side == white ? bMan : wMan) -
              game.position.count(side == white ? bKing : wKing),
        );

    Widget board(double side) => SizedBox.square(
          dimension: side,
          child: BoardView(
            position: game.position,
            previous: c.prevPosition,
            lastMove: c.lastMove,
            moveSerial: c.moveSerial,
            flipped: bottom == black,
            theme: boardThemeById(s.boardTheme),
            style: pieceStyleById(s.pieceStyle),
            animMs: s.animMs,
            showCoords: s.showCoords,
            selected: c.selected,
            targets: s.showLegalMoves ? c.targets : const {},
            mustMove: s.showLegalMoves ? c.mustMove : const {},
            onTap: over ? null : c.tap,
          ),
        );

    return LayoutBuilder(builder: (context, box) {
      final wide = box.maxWidth >= kWideBreakpoint;
      return Scaffold(
        appBar: AppBar(
          title: Text(variantName(l, setup.rules.id)),
          actions: [
            if (!wide)
              IconButton(
                tooltip: l.moves,
                icon: const Icon(Icons.format_list_numbered),
                onPressed: () => showModalBottomSheet<void>(
                  context: context,
                  showDragHandle: true,
                  isScrollControlled: true,
                  builder: (_) => SizedBox(
                      height: MediaQuery.sizeOf(context).height * .35,
                      child: _MoveList(game: game)),
                ),
              ),
          ],
        ),
        body: SafeArea(
          child: LayoutBuilder(builder: (context, inner) {
            // Everything that sits around the board, in pixels.
            const bars = 2 * 56.0, status = 40.0, actionRow = 64.0, gaps = 24.0;
            if (!wide) {
              final side = max(
                  200.0,
                  min(inner.maxWidth - 16,
                      inner.maxHeight - bars - status - actionRow - gaps));
              // Sit a little above the middle, close under the title bar.
              return Align(
                alignment: const Alignment(0, -0.6),
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: side,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      bar(1 - bottom),
                      const SizedBox(height: 6),
                      board(side),
                      const SizedBox(height: 6),
                      bar(bottom),
                      _StatusLine(controller: c, name: name),
                      _Actions(controller: c),
                    ]),
                  ),
                ),
              );
            }
            const panel = 320.0;
            final side = max(
                240.0,
                min(inner.maxWidth - panel - 64,
                    inner.maxHeight - bars - status - gaps - 16));
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                    width: side,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      bar(1 - bottom),
                      const SizedBox(height: 6),
                      board(side),
                      const SizedBox(height: 6),
                      bar(bottom),
                      _StatusLine(controller: c, name: name),
                    ]),
                  ),
                  const SizedBox(width: 24),
                  SizedBox(
                    width: panel,
                    height: side + bars,
                    child: Card(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 4),
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(l.moves,
                                style: Theme.of(context).textTheme.titleSmall),
                          ),
                        ),
                        Expanded(child: _MoveList(game: game)),
                        const Divider(height: 1),
                        _Actions(controller: c),
                      ]),
                    ),
                  ),
                ]),
              ),
            );
          }),
        ),
      );
    });
  }

  static int _startCount(VariantRules r) => Position.initial(r).count(wMan);
}

class _PlayerBar extends StatelessWidget {
  final String name;
  final int side, taken;
  final bool active, thinking;
  final PieceStyle style;
  const _PlayerBar({
    required this.name,
    required this.side,
    required this.taken,
    required this.active,
    required this.thinking,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final s = t.colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: active ? s.primaryContainer.withValues(alpha: .35) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        // A clear 2 px frame shows whose turn it is (not only a faint fill).
        border: Border.all(
            width: 2, color: active ? s.primary : Colors.transparent),
      ),
      child: Row(children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: side == white ? style.whiteA : style.blackB,
            // A light ring keeps the black dot visible on dark backgrounds.
            border: Border.all(
                width: 2,
                color: side == white ? s.outline : const Color(0xFF8A8F98)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(name,
              overflow: TextOverflow.ellipsis,
              style: t.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w600)),
        ),
        if (thinking)
          const Padding(
            padding: EdgeInsetsDirectional.only(end: 10),
            child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2)),
          ),
        if (taken > 0)
          Text('+$taken',
              style: t.textTheme.labelLarge?.copyWith(
                  color: s.onSurfaceVariant,
                  fontFeatures: const [FontFeature.tabularFigures()])),
      ]),
    );
  }
}

class _StatusLine extends StatelessWidget {
  final GameController controller;
  final String Function(int side) name;
  const _StatusLine({required this.controller, required this.name});

  @override
  Widget build(BuildContext context) {
    final c = controller, g = c.game!;
    final t = Theme.of(context);
    final l = context.l;
    final reason = reasonText(l, c.resultReason);
    final String text;
    switch (c.result) {
      case GameResult.ongoing:
        text = c.mustMove.isNotEmpty
            ? l.mustCapture
            : (c.thinking
                ? l.isThinking(name(g.position.turn))
                : l.toMove(name(g.position.turn)));
      case GameResult.draw:
        text = l.drawBecause(reason);
      case GameResult.whiteWins:
        text = l.wonBecause(name(white), reason);
      case GameResult.blackWins:
        text = l.wonBecause(name(black), reason);
    }
    final over = c.result != GameResult.ongoing;
    return SizedBox(
      height: 40,
      child: Center(
        child: Text(text,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: (over ? t.textTheme.titleMedium : t.textTheme.bodyMedium)
                ?.copyWith(
                    fontWeight: over ? FontWeight.w700 : FontWeight.w500,
                    color: over ? t.colorScheme.primary : t.colorScheme.onSurfaceVariant)),
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  final GameController controller;
  const _Actions({required this.controller});

  @override
  Widget build(BuildContext context) {
    final c = controller;
    final l = context.l;
    final over = c.result != GameResult.ongoing;
    // Big, easy buttons (56 px tall) right under the board.
    const size = Size(0, 48);
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 8),
      child: Row(children: [
        Expanded(
          child: FilledButton.tonalIcon(
            style: FilledButton.styleFrom(minimumSize: size),
            onPressed: c.canUndo && !over ? c.undo : null,
            icon: const Icon(Icons.undo),
            label: Text(l.undo, overflow: TextOverflow.ellipsis),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: over
              ? FilledButton.icon(
                  style: FilledButton.styleFrom(minimumSize: size),
                  onPressed: c.rematch,
                  icon: const Icon(Icons.replay),
                  label: Text(l.playAgain, overflow: TextOverflow.ellipsis),
                )
              : FilledButton.tonalIcon(
                  style: FilledButton.styleFrom(minimumSize: size),
                  onPressed: () async {
                    final yes = await showDialog<bool>(
                      context: context,
                      builder: (d) => AlertDialog(
                        title: Text(l.resignQ),
                        content: Text(l.resignBody),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(d, false),
                              child: Text(l.keepPlaying)),
                          FilledButton(
                              onPressed: () => Navigator.pop(d, true),
                              child: Text(l.resign)),
                        ],
                      ),
                    );
                    if (yes == true) c.resign();
                  },
                  icon: const Icon(Icons.flag_outlined),
                  label: Text(l.resign, overflow: TextOverflow.ellipsis),
                ),
        ),
      ]),
    );
  }
}

class _MoveList extends StatelessWidget {
  final Game game;
  const _MoveList({required this.game});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final moves = game.moves;
    if (moves.isEmpty) {
      return Center(
          child: Text(context.l.noMovesYet, style: t.textTheme.bodySmall));
    }
    final rows = (moves.length + 1) ~/ 2;
    const tab = TextStyle(fontFeatures: [FontFeature.tabularFigures()]);
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: rows,
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        // Move notation reads left to right in every language.
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Row(children: [
            SizedBox(
                width: 34,
                child: Text('${i + 1}.',
                    style: t.textTheme.bodySmall
                        ?.copyWith(color: t.colorScheme.onSurfaceVariant))),
            Expanded(child: Text(moveText(game.rules, moves[2 * i]), style: tab)),
            Expanded(
                child: Text(
                    2 * i + 1 < moves.length
                        ? moveText(game.rules, moves[2 * i + 1])
                        : '',
                    style: tab)),
          ]),
        ),
      ),
    );
  }
}
