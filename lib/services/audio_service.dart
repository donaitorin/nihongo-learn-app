import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

/// Plays bundled pronunciation files through one reused [AudioPlayer].
///
/// Tests subclass it and override [play], so the player is created lazily and
/// the platform channel is never touched there.
class AudioService {
  AudioService();

  static final AudioService instance = AudioService();

  late final AudioPlayer _player = AudioPlayer();
  StreamSubscription<void>? _completeSub;
  Completer<void>? _current;

  /// Plays [assetPath] (relative to `assets/`), cutting off any sound that is
  /// still playing. The future completes when this sound ends or when another
  /// one replaces it, so callers can show a "playing" state.
  Future<void> play(String assetPath) async {
    _finishCurrent();
    final completer = _current = Completer<void>();
    _completeSub ??= _player.onPlayerComplete.listen((_) => _finishCurrent());
    try {
      await _player.stop();
      await _player.play(AssetSource(assetPath));
    } on Object catch (error) {
      debugPrint('AudioService: could not play $assetPath: $error');
      if (identical(_current, completer)) _finishCurrent();
    }
    return completer.future;
  }

  void _finishCurrent() {
    final completer = _current;
    _current = null;
    if (completer != null && !completer.isCompleted) completer.complete();
  }

  Future<void> dispose() async {
    _finishCurrent();
    await _completeSub?.cancel();
    await _player.dispose();
  }
}
