import 'package:flutter/painting.dart';

/// Color tokens. Never hardcode colors in widgets: add them here.
abstract final class AppColors {
  static const background = Color(0xFFF3F0FF);
  static const ink = Color(0xFF1B1537);
  static const accent = Color(0xFF4C3FB0);
  static const navInactive = Color(0xFF5B5478);
  static const white = Color(0xFFFFFFFF);

  static const kana = Color(0xFFFF7A59);
  static const n5 = Color(0xFFFFC53D);
  static const n4 = Color(0xFF4FDDB8);
  static const n3 = Color(0xFFA9B4FF);

  static const navActive = n5;

  static const hiragana = Color(0xFFFF8FB8);
  static const katakana = Color(0xFF7CC8FF);

  static const emptyCellBorder = Color(0xFFCFC8F0);
  static const dividerDash = Color(0xFFB9B0E6);
}
