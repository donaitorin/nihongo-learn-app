import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_decorations.dart';
import '../theme/app_text.dart';

/// Dark button face with a trailing arrow. It is not tappable by itself: it
/// sits inside a card that is.
class InkButtonLabel extends StatelessWidget {
  const InkButtonLabel({
    super.key,
    required this.label,
    required this.height,
    required this.fontSize,
    required this.iconSize,
    this.horizontalPadding = 0,
  });

  final String label;
  final double height;
  final double fontSize;
  final double iconSize;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: const BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.all(Radius.circular(AppRadii.box)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          Text(
            label,
            style: AppText.body(
              fontSize,
              weight: FontWeight.w800,
              color: AppColors.white,
            ),
          ),
          Icon(
            Icons.arrow_forward_rounded,
            size: iconSize,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
