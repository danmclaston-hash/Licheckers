import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'game_controller.dart';

/// Plays the short game sounds and a small vibration on phones.
/// Sounds are made by tools/sounds/make_sounds.py (about 70 KB in total).
class Sounds {
  Sounds._();
  static final instance = Sounds._();

  final Map<GameSound, AudioPlayer> _players = {};

  static const _files = {
    GameSound.move: 'sounds/move.wav',
    GameSound.capture: 'sounds/capture.wav',
    GameSound.king: 'sounds/king.wav',
    GameSound.lowTime: 'sounds/lowtime.wav',
    GameSound.end: 'sounds/end.wav',
  };

  Future<void> play(GameSound s) async {
    _buzz(s);
    try {
      final p = _players.putIfAbsent(s, () {
        final p = AudioPlayer();
        p.setReleaseMode(ReleaseMode.stop);
        return p;
      });
      await p.stop();
      await p.play(AssetSource(_files[s]!), volume: .8);
    } catch (_) {
      // No sound device, or the browser blocked it until the first tap.
    }
  }

  void _buzz(GameSound s) {
    if (kIsWeb) return;
    switch (s) {
      case GameSound.move:
        HapticFeedback.selectionClick();
      case GameSound.capture || GameSound.king:
        HapticFeedback.mediumImpact();
      case GameSound.lowTime || GameSound.end:
        HapticFeedback.heavyImpact();
    }
  }
}
