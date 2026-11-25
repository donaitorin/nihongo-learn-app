# 0002. Navigation and state management

Date: 2026-11-24

## Context
The first version has three screens in a straight line: Home → Kana menu → Kana table.

## Decision
Plain `Navigator.push` with `MaterialPageRoute`, `StatelessWidget` for screens and a
`StatefulWidget` only where there is local state (`KanaCell` playing feedback). No router package and
no state management package. The bottom nav's "Inicio" does `popUntil(isFirst)`.

## Alternatives considered
- `go_router`: worth it once there are deep links or tabs that keep their own stack.
- Provider/Riverpod/Bloc: no shared mutable state exists yet.

## Consequences
- Revisit this ADR when progress tracking or the JLPT levels introduce shared state, or when
  Repaso/Progreso become real tabs.
