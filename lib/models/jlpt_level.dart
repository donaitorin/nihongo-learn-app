import 'dart:ui';

class JlptLevel {
  const JlptLevel({
    required this.code,
    required this.name,
    required this.description,
    required this.status,
    required this.glyph,
    required this.color,
    this.locked = false,
  });

  final String code;
  final String name;
  final String description;
  final String status;
  final String glyph;
  final Color color;
  final bool locked;
}
