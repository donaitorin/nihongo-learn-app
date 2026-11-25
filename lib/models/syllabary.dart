import 'dart:ui';

import '../theme/app_colors.dart';

enum Syllabary {
  hiragana(
    title: 'Hiragana',
    japaneseName: 'ひらがな',
    glyph: 'あ',
    color: AppColors.hiragana,
    description: 'Para palabras japonesas y partículas. Empezá por acá.',
  ),
  katakana(
    title: 'Katakana',
    japaneseName: 'カタカナ',
    glyph: 'ア',
    color: AppColors.katakana,
    description: 'Para palabras extranjeras, nombres y onomatopeyas.',
  );

  const Syllabary({
    required this.title,
    required this.japaneseName,
    required this.glyph,
    required this.color,
    required this.description,
  });

  final String title;
  final String japaneseName;
  final String glyph;
  final Color color;
  final String description;
}
