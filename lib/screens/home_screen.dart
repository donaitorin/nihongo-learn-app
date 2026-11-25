import 'package:flutter/material.dart';

import '../data/app_info.dart';
import '../data/levels.dart';
import '../models/jlpt_level.dart';
import '../theme/app_colors.dart';
import '../theme/app_decorations.dart';
import '../theme/app_text.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/dashed_border.dart';
import '../widgets/ink_button_label.dart';
import '../widgets/ink_card.dart';
import 'kana_menu_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12,
            children: [
              const _Header(),
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: _Greeting(),
              ),
              const _KanaCard(),
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: _LevelsDivider(),
              ),
              for (final level in jlptLevels) _LevelCard(level: level),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 8,
          children: [
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.ink,
                borderRadius: BorderRadius.circular(AppRadii.appLogo),
              ),
              child: Text(
                '日',
                style: AppText.display(18, color: AppColors.n5, height: 1),
              ),
            ),
            Text(
              appName,
              style: AppText.body(
                15,
                weight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        // TODO(profile): the profile button has no action yet.
        Semantics(
          button: true,
          label: 'Perfil',
          excludeSemantics: true,
          child: Material(
            color: AppColors.white,
            shape: const CircleBorder(
              side: BorderSide(
                color: AppColors.ink,
                width: AppDecorations.borderWidth,
              ),
            ),
            child: SizedBox.square(
              dimension: 44,
              child: Center(
                child: Text('D', style: AppText.display(16, height: 1)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Greeting extends StatelessWidget {
  const _Greeting();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Text(
          'おかえり · Bienvenido de nuevo',
          style: AppText.body(13, color: AppColors.accent),
        ),
        Text('¿Qué estudiamos hoy?', style: AppText.display(27)),
      ],
    );
  }
}

class _KanaCard extends StatelessWidget {
  const _KanaCard();

  @override
  Widget build(BuildContext context) {
    return InkCard(
      color: AppColors.kana,
      radius: AppRadii.homeKanaCard,
      shadow: true,
      semanticsLabel: 'Kana. Entrar a Kana',
      onTap: () => Navigator.of(
        context,
      ).push(MaterialPageRoute<void>(builder: (_) => const KanaMenuScreen())),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Positioned(
            right: -6,
            top: -18,
            child: _Decoration(
              'あ',
              size: 128,
              color: AppColors.white.withValues(alpha: 0.35),
            ),
          ),
          Positioned(
            right: 70,
            top: 54,
            child: _Decoration(
              'ア',
              size: 76,
              color: AppColors.ink.withValues(alpha: 0.14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: _StepPill(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kana', style: AppText.display(38, height: 1)),
                    const SizedBox(height: 6),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 210),
                      child: Text(
                        'Las bases: hiragana y katakana, con audio de cada sonido',
                        style: AppText.body(13, height: 1.35),
                      ),
                    ),
                  ],
                ),
                const InkButtonLabel(
                  label: 'Entrar a Kana',
                  height: 46,
                  fontSize: 15,
                  iconSize: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepPill extends StatelessWidget {
  const _StepPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Text(
        'PASO 0 · EMPEZÁ ACÁ',
        style: AppText.body(
          11,
          weight: FontWeight.w800,
          color: AppColors.white,
          letterSpacing: 0.66,
        ),
      ),
    );
  }
}

/// Giant background glyph: decorative, so it is hidden from screen readers and
/// from touches.
class _Decoration extends StatelessWidget {
  const _Decoration(this.glyph, {required this.size, required this.color});

  final String glyph;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: IgnorePointer(
        child: Text(glyph, style: AppText.decoration(size, color: color)),
      ),
    );
  }
}

class _LevelsDivider extends StatelessWidget {
  const _LevelsDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Text(
          'NIVELES JLPT',
          style: AppText.body(13, weight: FontWeight.w800, letterSpacing: 0.78),
        ),
        const Expanded(child: DashedLine(color: AppColors.dividerDash)),
      ],
    );
  }
}

class _LevelCard extends StatelessWidget {
  const _LevelCard({required this.level});

  final JlptLevel level;

  @override
  Widget build(BuildContext context) {
    // TODO(levels): levels do not navigate in this version.
    return InkCard(
      color: level.color,
      radius: AppRadii.levelCard,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      minHeight: 44,
      child: Row(
        spacing: 12,
        children: [
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: AppDecorations.card(
              color: AppColors.white,
              radius: AppRadii.levelCode,
            ),
            child: Text(level.code, style: AppText.display(20, height: 1)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Text(
                  level.name,
                  style: AppText.body(15, weight: FontWeight.w800),
                ),
                Text(
                  level.description,
                  style: AppText.body(
                    12,
                    height: 1.3,
                    color: AppColors.ink.withValues(alpha: 0.85),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Row(
                    spacing: 4,
                    children: [
                      if (level.locked)
                        const Icon(
                          Icons.lock_outline,
                          size: 12,
                          color: AppColors.ink,
                        ),
                      Flexible(
                        child: Text(
                          level.status,
                          style: AppText.body(11, weight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 2),
            child: ExcludeSemantics(
              child: Text(
                level.glyph,
                style: AppText.display(
                  46,
                  color: AppColors.ink.withValues(alpha: 0.22),
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
