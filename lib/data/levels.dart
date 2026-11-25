import '../models/jlpt_level.dart';
import '../theme/app_colors.dart';

const jlptLevels = [
  JlptLevel(
    code: 'N5',
    name: 'Principiante',
    description: 'Saludos y frases básicas',
    status: '0% completado',
    glyph: '一',
    color: AppColors.n5,
  ),
  JlptLevel(
    code: 'N4',
    name: 'Básico',
    description: 'Charlas simples, más kanji',
    status: 'Se abre al terminar N5',
    glyph: '会',
    color: AppColors.n4,
    locked: true,
  ),
  JlptLevel(
    code: 'N3',
    name: 'Intermedio',
    description: 'Textos y charlas cotidianas',
    status: 'Se abre al terminar N4',
    glyph: '話',
    color: AppColors.n3,
    locked: true,
  ),
];
