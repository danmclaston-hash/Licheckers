import 'package:checkers_core/checkers_core.dart';
import 'package:checkers_engine/checkers_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../game_controller.dart';
import '../info_tip.dart';
import '../rules_text.dart';
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
    final bot = bots[_level - 1];
    return PageBody(title: 'Play', children: [
      SectionCard(
        title: 'Game',
        trailing: const InfoTip(
          title: 'Variants',
          text: 'Checkers is played with different rules around the world. '
              'Pick one here. Open Learn to read the rules of each game.',
        ),
        child: Wrap(spacing: 8, runSpacing: 8, children: [
          for (final v in Variants.all)
            ChoiceChip(
              label: Text(v.name),
              selected: v == _variant,
              onSelected: (_) => setState(() => _variant = v),
            ),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 12),
        child: Text(tagline(_variant),
            style: t.textTheme.bodySmall
                ?.copyWith(color: t.colorScheme.onSurfaceVariant)),
      ),
      SectionCard(
        title: 'Opponent',
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(
                  value: true,
                  icon: Icon(Icons.smart_toy_outlined),
                  label: Text('Computer')),
              ButtonSegment(
                  value: false,
                  icon: Icon(Icons.people_outline),
                  label: Text('Two players')),
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
                      Text(bot.description, style: t.textTheme.bodySmall),
                    ]),
              ),
              const InfoTip(
                title: 'Bot levels',
                text: 'There are 18 computer players. Level 1 plays almost '
                    'at random. Higher levels look more moves ahead and make '
                    'fewer mistakes. The top levels think for a few seconds.',
              ),
            ]),
            Slider(
              value: _level.toDouble(),
              min: 1,
              max: 18,
              divisions: 17,
              label: 'Level $_level',
              onChanged: (v) => setState(() => _level = v.round()),
            ),
          ] else
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text('Pass the device after each move.',
                  style: t.textTheme.bodySmall),
            ),
        ]),
      ),
      if (_vsBot)
        SectionCard(
          title: 'Your colour',
          child: SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: white, label: Text('White')),
              ButtonSegment(value: black, label: Text('Black')),
            ],
            selected: {_side},
            onSelectionChanged: (s) => setState(() => _side = s.first),
          ),
        ),
      const SizedBox(height: 4),
      FilledButton.icon(
        onPressed: _start,
        icon: const Icon(Icons.play_arrow),
        label: const Text('Start game'),
      ),
    ]);
  }
}
