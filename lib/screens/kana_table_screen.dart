import 'package:flutter/material.dart';

import '../data/kana.dart';
import '../models/syllabary.dart';
import '../services/audio_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_decorations.dart';
import '../theme/app_text.dart';
import '../widgets/back_circle_button.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/dashed_border.dart';
import '../widgets/kana_cell.dart';

class KanaTableScreen extends StatelessWidget {
  const KanaTableScreen({
    super.key,
    required this.syllabary,
    this.audioService,
  });

  final Syllabary syllabary;

  /// Defaults to [AudioService.instance]; tests pass a fake.
  final AudioService? audioService;

  @override
  Widget build(BuildContext context) {
    final table = kanaTableFor(syllabary);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12,
            children: [
              _Header(
                syllabary: syllabary,
                count: table.whereType<Kana>().length,
              ),
              const _Hint(),
              _KanaGrid(
                table: table,
                color: syllabary.color,
                audioService: audioService ?? AudioService.instance,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.syllabary, required this.count});

  final Syllabary syllabary;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        const BackCircleButton(semanticsLabel: 'Volver a Kana'),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${syllabary.japaneseName} · $count caracteres',
                style: AppText.body(
                  12,
                  weight: FontWeight.w800,
                  color: AppColors.accent,
                ),
              ),
              Text(syllabary.title, style: AppText.display(26, height: 1.05)),
            ],
          ),
        ),
        ExcludeSemantics(
          child: Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: AppDecorations.card(
              color: syllabary.color,
              radius: AppRadii.box,
            ),
            child: Text(syllabary.glyph, style: AppText.display(22, height: 1)),
          ),
        ),
      ],
    );
  }
}

class _Hint extends StatelessWidget {
  const _Hint();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: AppDecorations.card(
        color: AppColors.white,
        radius: AppRadii.box,
      ),
      child: Row(
        spacing: 8,
        children: [
          const Icon(Icons.volume_up_outlined, size: 18, color: AppColors.ink),
          Expanded(
            child: Text(
              'Tocá un carácter para escuchar cómo suena',
              style: AppText.body(12),
            ),
          ),
        ],
      ),
    );
  }
}

class _KanaGrid extends StatelessWidget {
  const _KanaGrid({
    required this.table,
    required this.color,
    required this.audioService,
  });

  final List<Kana?> table;
  final Color color;
  final AudioService audioService;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // The hard shadow of a playing cell spills into the gap below it.
      clipBehavior: Clip.none,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: kanaTableColumns,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        mainAxisExtent: 52,
      ),
      itemCount: table.length,
      itemBuilder: (context, index) {
        final kana = table[index];
        if (kana == null) {
          return const ExcludeSemantics(
            child: DashedBorderBox(
              color: AppColors.emptyCellBorder,
              radius: AppRadii.box,
            ),
          );
        }
        // The first column (a, ka, sa...) takes the syllabary color.
        return KanaCell(
          kana: kana,
          color: index % kanaTableColumns == 0 ? color : AppColors.white,
          audioService: audioService,
        );
      },
    );
  }
}
