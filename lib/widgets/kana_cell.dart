import 'package:flutter/material.dart';

import '../data/kana.dart';
import '../services/audio_service.dart';
import '../theme/app_decorations.dart';
import '../theme/app_text.dart';

/// One tappable table cell. Plays the pronunciation and, while it sounds,
/// shrinks slightly and shows the hard shadow.
class KanaCell extends StatefulWidget {
  const KanaCell({
    super.key,
    required this.kana,
    required this.color,
    required this.audioService,
  });

  final Kana kana;
  final Color color;
  final AudioService audioService;

  @override
  State<KanaCell> createState() => _KanaCellState();
}

class _KanaCellState extends State<KanaCell> {
  bool _playing = false;

  // Tells apart overlapping taps: only the latest one may clear the state.
  int _tapId = 0;

  Future<void> _onTap() async {
    final tapId = ++_tapId;
    setState(() => _playing = true);
    await widget.audioService.play(widget.kana.audioPath);
    if (mounted && tapId == _tapId) setState(() => _playing = false);
  }

  @override
  Widget build(BuildContext context) {
    final kana = widget.kana;
    return Semantics(
      button: true,
      label: kana.semanticsLabel,
      excludeSemantics: true,
      onTap: _onTap,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        child: AnimatedScale(
          scale: _playing ? 0.95 : 1,
          duration: const Duration(milliseconds: 120),
          child: DecoratedBox(
            decoration: AppDecorations.card(
              color: widget.color,
              radius: AppRadii.box,
              shadow: _playing,
            ),
            // The cell height is fixed by the design, so text must not grow with
            // the system text scale.
            child: MediaQuery.withClampedTextScaling(
              maxScaleFactor: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 1,
                children: [
                  Text(kana.char, style: AppText.kana(27)),
                  Text(
                    kana.romaji,
                    style: AppText.body(
                      11,
                      weight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
