import 'package:checkers_core/checkers_core.dart';
import 'package:checkers_engine/checkers_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../game_controller.dart';
import '../info_tip.dart';
import '../i18n.dart';
import 'game_screen.dart';
import 'home.dart';

/// Choose the game, the opponent and your colour, then play.
class PlaySetupScreen extends ConsumerStatefulWidget {
  const PlaySetupScreen({super.key});

  @override
  ConsumerState<PlaySetupScreen> createState() => _PlaySetupState();
}

class _PlaySetupState extends ConsumerState<PlaySetupScreen> {
  VariantRules _variant = Variants.english;
  bool _vsBot = true;
  int _level = 4;
  int _side = white;

  void _start() {
    ref.read(gameProvider).start(
        GameSetup(_variant, _vsBot ? bots[_level - 1] : null, _side));
    Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => const GameScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final l = context.l;
    final bot = bots[_level - 1];
    return PageBody(title: l.navPlay, children: [
      SectionCard(
        title: l.sectionGame,
        trailing: InfoTip(title: l.variantsInfoTitle, text: l.variantsInfoText),
        child: Wrap(spacing: 8, runSpacing: 8, children: [
          for (final v in Variants.all)
            ChoiceChip(
              label: Text(variantName(l, v.id)),
              selected: v == _variant,
              onSelected: (_) => setState(() => _variant = v),
            ),
        ]),
      ),
      Padding(
        padding: const EdgeInsetsDirectional.only(start: 4, bottom: 12),
        child: Text(tagline(l, _variant),
            style: t.textTheme.bodySmall
                ?.copyWith(color: t.colorScheme.onSurfaceVariant)),
      ),
      SectionCard(
        title: l.opponent,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SegmentedButton<bool>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                  value: true,
                  icon: const Icon(Icons.smart_toy_outlined),
                  label: Text(l.computer)),
              ButtonSegment(
                  value: false,
                  icon: const Icon(Icons.people_outline),
                  label: Text(l.twoPlayers)),
            ],
            selected: {_vsBot},
            onSelectionChanged: (s) => setState(() => _vsBot = s.first),
          ),
          if (_vsBot) ...[
            const SizedBox(height: 16),
            Row(children: [
              CircleAvatar(
                backgroundColor: t.colorScheme.primary,
                foregroundColor: Colors.white,
                child: Text('${bot.level}'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bot.name,
                          style: t.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      Text(botDescription(l, bot.level), style: t.textTheme.bodySmall),
                    ]),
              ),
              InfoTip(title: l.botLevelsTitle, text: l.botLevelsText),
            ]),
            // 18 stops are hard to hit on a small slider, so - and + buttons
            // step one level at a time.
            Row(children: [
              IconButton(
                tooltip: l.levelN(_level - 1),
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: _level > 1 ? () => setState(() => _level--) : null,
              ),
              Expanded(
                child: Slider(
                  value: _level.toDouble(),
                  min: 1,
                  max: 18,
                  divisions: 17,
                  label: l.levelN(_level),
                  onChanged: (v) => setState(() => _level = v.round()),
                ),
              ),
              IconButton(
                tooltip: l.levelN(_level + 1),
                icon: const Icon(Icons.add_circle_outline),
                onPressed: _level < 18 ? () => setState(() => _level++) : null,
              ),
            ]),
          ] else
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(l.passDevice,
                  style: t.textTheme.bodySmall),
            ),
        ]),
      ),
      if (_vsBot)
        SectionCard(
          title: l.yourColour,
          child: SegmentedButton<int>(
            segments: [
              ButtonSegment(value: white, label: Text(l.white)),
              ButtonSegment(value: black, label: Text(l.black)),
            ],
            selected: {_side},
            onSelectionChanged: (s) => setState(() => _side = s.first),
          ),
        ),
      const SizedBox(height: 4),
      FilledButton.icon(
        onPressed: _start,
        icon: const Icon(Icons.play_arrow),
        label: Text(l.startGame),
      ),
    ]);
  }
}
