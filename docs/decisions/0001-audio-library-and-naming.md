# 0001. Audio library and audio file naming

Date: 2026-11-24

## Context
Every kana in the tables plays its pronunciation. The files were generated with Azure TTS and are
bundled as assets. We need a playback library and one naming convention for the files.

## Decision
- Use `audioplayers` with a single reused `AudioPlayer` wrapped in `AudioService`
  (`lib/services/audio_service.dart`). Tapping another cell stops the previous sound.
- Files live flat in `assets/audio/kana/` and are named by Hepburn romaji: `ka.mp3`, `shi.mp3`.
  Hiragana and katakana share one file per sound.
- Asset paths are built in one place, `lib/data/kana.dart` (`kanaAudioDir`), relative to `assets/`
  as `AssetSource` expects.
- を/ヲ has no file of its own: it reuses `o.mp3` because the sound is identical
  (`_audioIdOverrides` in `lib/data/kana.dart`).

## Alternatives considered
- `just_audio`: more powerful (gapless, streaming, caching), but nothing here needs it.
- Separate `hiragana/` and `katakana/` folders: would duplicate 46 identical recordings.

## Consequences
- Adding sounds (dakuten, yōon) means dropping `<romaji>.mp3` in the same folder.
- `test/data/kana_test.dart` fails if a kana points to a missing file.
- Tests replace `AudioService` with a fake, so no platform channel is touched.
