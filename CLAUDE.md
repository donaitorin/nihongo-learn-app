# CLAUDE.md

Guidance for Claude when working in this repository.

## Project

**nihongo-learn-app** is a Flutter app for learning Japanese.

- Learning path: **Kana** (hiragana and katakana basics), then JLPT levels **N5 → N4 → N3**.
- First module: Kana tables with audio pronunciation for every character.
- Audio files were generated with Azure TTS and are bundled in `assets/audio/kana/`.
- All user-facing copy is in **Spanish** (Rioplatense, using "vos": "Empezá", "Tocá").
- Code, identifiers, comments and docs are in **English**.

## Golden rules

1. **Git: ask first, always.** Do not run any `git` command without asking me first. That includes
   read-only ones like `status`, `diff` and `log`. Never commit, push, pull, merge, rebase, stash,
   reset, checkout or create branches on your own. When work is done, suggest which files to commit,
   grouped into commits, with messages. I review the diff in VS Code and commit by hand.
   At the end of every task, list the suggested commits in order, each with a Conventional Commits
   message (`type(scope): message`) and the exact files or folders it includes. Each commit must leave
   the project in a buildable state (for example, `pubspec.yaml` must not reference assets that arrive
   in a later commit, and `lib/main.dart` must exist): merge commits when needed. After the list, give
   ONE shell command in a ```bash block that I can paste from the repo root to create all the commits in
   order: steps chained with `&&`, one `git add <paths>` plus `git commit -m "<message>"` per commit,
   paths with spaces quoted, only explicit paths in `git add` (never `.` or `-A`), and no `push`.
   Never run that command yourself.
2. **Use fvm for everything.** Run `fvm flutter ...` and `fvm dart ...`, never bare `flutter` or
   `dart`. Do not change the pinned Flutter version without asking.
3. **Ask before adding a dependency.** Say what the package is for, why it is needed, and what the
   alternative would be. Prefer well-maintained packages with a good pub.dev score.
4. **Do not delete or overwrite files I did not ask you to touch.** This covers assets above all
   (audio, fonts). If something looks unused, tell me instead of removing it.
5. **Never invent content.** If copy, data or an asset is missing, leave a clear `TODO(...)` and
   mention it in your summary.
6. **Stay in scope.** Do what was asked. Propose unrelated improvements at the end; do not apply them.

## Documentation (`docs/`)

Every task that changes code must be documented in `docs/` before you finish.

```
docs/
  README.md        Index: links to every document, newest first
  worklog/         One file per task: YYYY-MM-DD-short-topic.md
  decisions/       Architecture decisions (ADR): NNNN-short-title.md
  design/          Design system notes: colors, typography, components
```

**Worklog entry** (`docs/worklog/YYYY-MM-DD-short-topic.md`):

```markdown
# <Title>
Date: YYYY-MM-DD

## Goal
What was asked and why.

## What changed
- Files created or modified, with one line each on what changed.

## Decisions
Choices made and the reason (link an ADR if it deserves one).

## How to test
Commands and manual steps to verify it.

## Pending / TODO
Known gaps, missing assets, follow-ups.

## Suggested commits
- `type(scope): message` → files
```

- Write an **ADR** in `docs/decisions/` for decisions that are hard to reverse, like state
  management, navigation, audio library, data storage or folder structure. Use the sections
  Context, Decision, Alternatives considered and Consequences.
- Keep `docs/design/` in sync when theme tokens or shared widgets change.
- Update `docs/README.md` every time you add a document.

## Commands

```bash
fvm flutter pub get
fvm flutter analyze          # must pass with zero issues
fvm dart format lib test     # format before finishing
fvm flutter test
fvm flutter run
```

Before saying a task is done: `analyze` is clean, the code is formatted, tests pass, and the app runs.

## Architecture

```
lib/
  main.dart
  app.dart              MaterialApp, theme, routes
  theme/                Colors, text styles, decorations (single source of truth)
  data/                 Static content (kana tables, levels)
  models/               Plain data classes
  services/             Audio, storage, other side effects
  widgets/              Reusable UI components
  screens/              One folder or file per screen
test/                   Mirrors lib/
assets/
  fonts/                DelaGothicOne, MPlusRounded, KleeOne (+ OFL.txt)
  audio/kana/           Pronunciation audio
docs/
```

- Keep it simple. Plain `Navigator` and `StatefulWidget` are fine until there is a real need.
  If state grows, propose a solution in an ADR before introducing one.
- Screens compose widgets; they do not contain business logic or hardcoded data.
- Services are injected or accessed through a single instance, never created inside `build()`.
- Dispose controllers, players and streams in `dispose()`.

## Code style

- Follow `flutter_lints` (or stricter, if configured in `analysis_options.yaml`).
- Use `const` constructors wherever possible.
- Prefer small, focused widgets over long `build` methods. Extract a widget once `build` passes
  roughly 80 lines or a block repeats.
- Use `snake_case` for file names, `PascalCase` for classes and `camelCase` for members.
- Do not leave `print` behind: use `debugPrint` or a logger, and remove debug output before finishing.
- Comments explain *why*, not *what*.
- Never ignore a lint without a comment explaining the reason.

## Design system

- **Never hardcode colors, font families, radii or shadows in widgets.** Use the tokens in
  `lib/theme/`. If a token is missing, add it there.
- Fonts:
  - `DelaGothicOne`: titles, level codes, decorative glyphs.
  - `MPlusRounded`: all body and UI text.
  - `KleeOne`: only for kana and kanji meant to be *learned* (table cells, flashcards).
    It is a textbook style font, chosen for readability for beginners.
- Signature look: solid 2px ink borders, and a hard shadow (offset 0,5, no blur) on featured cards.
- Text sits on colored surfaces in ink color, never white.
- The source designs live in the Design canvas. When a screen does not match, the design wins
  unless I say otherwise.

## Accessibility

- Touch targets are at least 44×44.
- Text contrast is at least 4.5:1.
- Every icon-only button and every kana cell has a `Semantics` label (e.g. "あ, a").
- Layouts must not break at a 1.3× text scale.

## Assets

- Register every new asset folder in `pubspec.yaml`.
- Asset paths live in one place (constants or the data layer), never as scattered string literals.
- Audio file names follow one consistent convention. Document it in `docs/design/` or an ADR.
- Fonts must ship with their license file.

## Testing

- Unit tests for data and services (e.g. every kana maps to an existing audio file).
- Widget tests for key screens: they render, and navigation works.
- New features come with tests. Bug fixes come with a test that reproduces the bug.

## Security and privacy

- Never commit secrets, API keys or `.env` files. Use `--dart-define` or a git-ignored config.
- Do not add analytics, tracking or network calls without asking.

## When you finish a task

1. `fvm flutter analyze`, `fvm dart format`, `fvm flutter test`.
2. Write the worklog entry in `docs/worklog/` and update `docs/README.md`.
3. Reply with a short summary: what changed, how to test it, pending items, and the suggested commits
   (ordered list plus the single paste-ready `bash` command, as described in the Git rule above).