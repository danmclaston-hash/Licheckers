import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings.dart';

/// The small (i) button. Tap it to read a short explanation.
/// Hidden everywhere when "Show info buttons" is off in Settings.
class InfoTip extends ConsumerWidget {
  final String title;
  final String text;
  const InfoTip({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(settingsProvider.select((s) => s.showInfo))) {
      return const SizedBox.shrink();
    }
    return IconButton(
      icon: const Icon(Icons.info_outline, size: 18),
      tooltip: 'What is this?',
      visualDensity: VisualDensity.compact,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
      onPressed: () => showDialog<void>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(c), child: const Text('Got it')),
          ],
        ),
      ),
    );
  }
}
