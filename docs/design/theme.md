# Theme tokens

Source of truth: `lib/theme/`. Never hardcode these in widgets.

## Colors (`AppColors`)
| Token | Value | Use |
|---|---|---|
| `background` | `#F3F0FF` | Screen background |
| `ink` | `#1B1537` | Text, borders, dark buttons |
| `accent` | `#4C3FB0` | Secondary text |
| `navInactive` | `#5B5478` | Inactive nav items |
| `kana` / `n5` / `n4` / `n3` | `#FF7A59` / `#FFC53D` / `#4FDDB8` / `#A9B4FF` | Kana card, level cards |
| `navActive` | = `n5` | Active nav pill |
| `hiragana` / `katakana` | `#FF8FB8` / `#7CC8FF` | Syllabary colors |
| `emptyCellBorder` | `#CFC8F0` | Dashed border of empty table slots |
| `dividerDash` | `#B9B0E6` | Dashed section divider |

## Fonts (`AppFonts`, `AppText`)
- `DelaGothicOne` (400): titles, level codes, decorative glyphs.
- `MPlusRounded` (400/700/800): all body and UI text.
- `KleeOne` (600): only kana meant to be learned (table cells).

## Shape (`AppRadii`, `AppDecorations`)
- Every card: solid 2px ink border. Featured cards add the hard shadow, offset (0, 5), no blur.
- Radii: home Kana card 24, menu cards 26, level cards 20, boxes and buttons 14.

## Shared widgets (`lib/widgets/`)
`InkCard`, `InkButtonLabel`, `BackCircleButton`, `BottomNav`, `KanaCell`, `DashedBorderBox`, `DashedLine`.

## Notes
- Text sits on colored surfaces in ink. White text is used only on ink pills and buttons.
- Table cells clamp the text scale to 1.0 because their height is fixed at 52.
