import 'package:flutter/material.dart';

import '../models/syllabary.dart';
import '../theme/app_colors.dart';
import '../theme/app_decorations.dart';
import '../theme/app_text.dart';
import '../widgets/back_circle_button.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/ink_button_label.dart';
import '../widgets/ink_card.dart';
import 'kana_table_screen.dart';

class KanaMenuScreen extends StatelessWidget {
  const KanaMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              const _TopRow(),
              const _Title(),
              for (final syllabary in Syllabary.values)
                _SyllabaryCard(syllabary: syllabary),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}

class _TopRow extends StatelessWidget {
  const _TopRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        const BackCircleButton(semanticsLabel: 'Volver al inicio'),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.kana,
            border: AppDecorations.inkBorder,
            borderRadius: BorderRadius.circular(AppRadii.pill),
          ),
          child: Text(
            'PASO 0',
            style: AppText.body(
              11,
              weight: FontWeight.w800,
              letterSpacing: 0.66,
            ),
          ),
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text('Kana', style: AppText.display(40, height: 1)),
        Text(
          'Elegí qué silabario querés practicar',
          style: AppText.body(14, height: 1.4, color: AppColors.accent),
        ),
      ],
    );
  }
}

class _SyllabaryCard extends StatelessWidget {
  const _SyllabaryCard({required this.syllabary});

  final Syllabary syllabary;

  @override
  Widget build(BuildContext context) {
    return InkCard(
      color: syllabary.color,
      radius: AppRadii.kanaMenuCard,
      shadow: true,
      minHeight: 230,
      semanticsLabel: '${syllabary.title}. Ver tabla',
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => KanaTableScreen(syllabary: syllabary),
        ),
      ),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Positioned(
            right: syllabary == Syllabary.hiragana ? -10 : -4,
            bottom: syllabary == Syllabary.hiragana ? -34 : -30,
            child: ExcludeSemantics(
              child: IgnorePointer(
                child: Text(
                  syllabary.glyph,
                  style: AppText.decoration(
                    190,
                    color: AppColors.white.withValues(alpha: 0.4),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            // spaceBetween pushes the button to the bottom of the card's minimum
            // height; spacing keeps the gap when the content is taller than that.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    _GlyphBox(glyph: syllabary.glyph),
                    _Texts(syllabary: syllabary),
                  ],
                ),
                const InkButtonLabel(
                  label: 'Ver tabla',
                  height: 44,
                  fontSize: 14,
                  iconSize: 16,
                  horizontalPadding: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GlyphBox extends StatelessWidget {
  const _GlyphBox({required this.glyph});

  final String glyph;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      alignment: Alignment.center,
      decoration: AppDecorations.card(
        color: AppColors.white,
        radius: AppRadii.menuGlyph,
      ),
      child: Text(glyph, style: AppText.display(34, height: 1)),
    );
  }
}

class _Texts extends StatelessWidget {
  const _Texts({required this.syllabary});

  final Syllabary syllabary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Text(
          syllabary.japaneseName,
          style: AppText.body(13, weight: FontWeight.w800),
        ),
        Text(syllabary.title, style: AppText.display(30, height: 1.05)),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 190),
            child: Text(
              syllabary.description,
              style: AppText.body(13, height: 1.35),
            ),
          ),
        ),
      ],
    );
  }
}
