import 'package:flutter/painting.dart';

import 'app_colors.dart';

abstract final class AppRadii {
  static const double homeKanaCard = 24;
  static const double kanaMenuCard = 26;
  static const double levelCard = 20;
  static const double levelCode = 16;
  static const double box = 14;
  static const double appLogo = 10;
  static const double menuGlyph = 18;
  static const double pill = 999;
}

abstract final class AppDecorations {
  static const double borderWidth = 2;

  static const inkBorder = Border.fromBorderSide(
    BorderSide(color: AppColors.ink, width: borderWidth),
  );

  /// Hard shadow of the signature look: offset (0, 5), no blur.
  static const hardShadow = [
    BoxShadow(color: AppColors.ink, offset: Offset(0, 5)),
  ];

  static BoxDecoration card({
    required Color color,
    required double radius,
    bool shadow = false,
  }) => BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
    border: inkBorder,
    boxShadow: shadow ? hardShadow : null,
  );
}
