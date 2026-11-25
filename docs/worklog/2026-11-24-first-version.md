# First version: Home, Kana menu, Hiragana and Katakana tables
Date: 2026-11-24

## Goal
Build the first version of the app as a pixel match of the 390×844 mockups: Home, Kana menu and a
Kana table screen parameterized by syllabary, with audio for every character.

## What changed
- `.fvmrc`: pins Flutter `stable` (3.41.6, Dart 3.11.4).
- Flutter project created in the repo (`fvm flutter create . --platforms ios,android`); the repo had
  no project yet. Default organization id (`com.example`) is still in place.
- `.gitignore`: standard Flutter entries plus `.fvm/` and `.env`.
- `pubspec.yaml`: fonts, audio folder, `audioplayers`; dropped the unused `cupertino_icons`.
- `assets/fonts/` (with `OFL.txt`) and `assets/audio/kana/` (101 mp3).
- `lib/theme/`: colors, text styles, radii, border and hard shadow, `ThemeData`.
- `lib/models/`: `Syllabary`, `JlptLevel`.
- `lib/data/`: `kana.dart` (tables), `levels.dart`, `app_info.dart` (placeholder app name).
- `lib/services/audio_service.dart`: single reused player.
- `lib/widgets/`: shared UI pieces (see `docs/design/theme.md`).
- `lib/screens/`: `HomeScreen`, `KanaMenuScreen`, `KanaTableScreen`.
- `test/`: kana data tests, screen/navigation tests, 1.3× text scale test.
- `docs/`: this entry, two ADRs, theme notes.

## Decisions
- ADR 0001: `audioplayers`, flat romaji-named audio files, を/ヲ reuses `o.mp3`.
- ADR 0002: plain `Navigator`, no state management package.
- Icons: Material outlined/rounded icons, no extra package.
- `AudioService.play` completes when the sound ends or is replaced, so a cell derives its pressed
  state from the future without a shared notifier.
- Menu cards avoid `IntrinsicHeight`: it measures text unwrapped and caused overflow.

## How to test
```bash
fvm flutter pub get
fvm flutter analyze
fvm flutter test
fvm flutter run
```
Manual: Home → "Entrar a Kana" → Hiragana / Katakana → tap cells (sound plays, cell shrinks with a hard
shadow). "Inicio" returns Home from any screen. Back buttons go one step back.

## Pending / TODO
- `TODO(branding)`: app name is the placeholder `[NOMBRE APP]`.
- `TODO(profile)`, `TODO(nav)`, `TODO(levels)`: profile button, Repaso, Progreso and the level cards
  do nothing yet.
- Dakuten and yōon audio files exist (101 mp3) but are not used by any table yet.
- Bundle id is still `com.example.nihongoLearnApp`; set the real one before any release.
- Dash length of the dashed borders (6 on, 4 off) is my choice; the mockup uses CSS `dashed`.

## Suggested commits
See the final summary of the task.
