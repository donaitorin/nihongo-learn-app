import 'package:nihongo_learn_app/services/audio_service.dart';

/// Records played paths without touching the audio platform channel.
class FakeAudioService extends AudioService {
  final played = <String>[];

  @override
  Future<void> play(String assetPath) async => played.add(assetPath);

  @override
  Future<void> dispose() async {}
}
