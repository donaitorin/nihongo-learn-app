import 'package:flutter/material.dart';

import '../theme/app_decorations.dart';

const _dash = 6.0;
const _gap = 4.0;

void _paintDashed(Canvas canvas, Path path, Paint paint) {
  for (final metric in path.computeMetrics()) {
    for (var d = 0.0; d < metric.length; d += _dash + _gap) {
      canvas.drawPath(metric.extractPath(d, d + _dash), paint);
    }
  }
}

Paint _stroke(Color color) => Paint()
  ..color = color
  ..style = PaintingStyle.stroke
  ..strokeWidth = AppDecorations.borderWidth;

/// Rounded rectangle with a 2px dashed border, for empty table slots.
class DashedBorderBox extends StatelessWidget {
  const DashedBorderBox({super.key, required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: _DashedRRectPainter(color, radius),
    child: const SizedBox.expand(),
  );
}

class _DashedRRectPainter extends CustomPainter {
  const _DashedRRectPainter(this.color, this.radius);

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    // Inset by half the stroke so the border stays inside the cell bounds.
    final rect = (Offset.zero & size).deflate(AppDecorations.borderWidth / 2);
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
    _paintDashed(canvas, path, _stroke(color));
  }

  @override
  bool shouldRepaint(_DashedRRectPainter old) =>
      old.color != color || old.radius != radius;
}

/// Horizontal 2px dashed line that fills the available width.
class DashedLine extends StatelessWidget {
  const DashedLine({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) => CustomPaint(
    size: const Size(double.infinity, AppDecorations.borderWidth),
    painter: _DashedLinePainter(color),
  );
}

class _DashedLinePainter extends CustomPainter {
  const _DashedLinePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height / 2;
    final path = Path()
      ..moveTo(0, y)
      ..lineTo(size.width, y);
    _paintDashed(canvas, path, _stroke(color));
  }

  @override
  bool shouldRepaint(_DashedLinePainter old) => old.color != color;
}
