import 'package:flutter/painting.dart';

import 'app_colors.dart';

abstract final class AppFonts {
  static const display = 'DelaGothicOne';
  static const body = 'MPlusRounded';
  static const kana = 'KleeOne';
}

/// Text style factories. Text is always ink on colored surfaces, never white,
/// except on the ink-colored pills and buttons.
abstract final class AppText {
  /// Titles, level codes and decorative glyphs.
  static TextStyle display(
    double size, {
    Color color = AppColors.ink,
    double height = 1.15,
  }) => TextStyle(
    fontFamily: AppFonts.display,
    fontSize: size,
    fontWeight: FontWeight.w400,
    height: height,
    color: color,
  );

  /// Body and UI text.
  static TextStyle body(
    double size, {
    FontWeight weight = FontWeight.w700,
    Color color = AppColors.ink,
    double? height,
    double? letterSpacing,
  }) => TextStyle(
    fontFamily: AppFonts.body,
    fontSize: size,
    fontWeight: weight,
    height: height,
    color: color,
    letterSpacing: letterSpacing,
  );

  /// Only for kana meant to be learned (table cells).
  static TextStyle kana(double size) => TextStyle(
    fontFamily: AppFonts.kana,
    fontSize: size,
    fontWeight: FontWeight.w600,
    height: 1,
    color: AppColors.ink,
  );

  /// Giant decorative glyph. The even leading distribution centers the glyph in
  /// its line box, so it lands where the mockup places it.
  static TextStyle decoration(double size, {required Color color}) => TextStyle(
    fontFamily: AppFonts.display,
    fontSize: size,
    height: 1,
    leadingDistribution: TextLeadingDistribution.even,
    color: color,
  );
}
