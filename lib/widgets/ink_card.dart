import 'package:flutter/material.dart';

import '../theme/app_decorations.dart';

/// Card with the signature solid ink border and, when [shadow] is set, the
/// hard shadow. Everything inside is clipped to the rounded shape.
class InkCard extends StatelessWidget {
  const InkCard({
    super.key,
    required this.color,
    required this.radius,
    required this.child,
    this.shadow = false,
    this.padding = EdgeInsets.zero,
    this.minHeight,
    this.onTap,
    this.semanticsLabel,
  });

  final Color color;
  final double radius;
  final bool shadow;
  final EdgeInsetsGeometry padding;
  final double? minHeight;
  final VoidCallback? onTap;
  final String? semanticsLabel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      constraints: minHeight == null
          ? null
          : BoxConstraints(minHeight: minHeight!),
      decoration: AppDecorations.card(
        color: color,
        radius: radius,
        shadow: shadow,
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
    if (onTap == null) return card;
    return Semantics(button: true, label: semanticsLabel, child: card);
  }
}
