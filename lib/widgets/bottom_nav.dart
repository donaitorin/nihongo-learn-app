import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_decorations.dart';
import '../theme/app_text.dart';

/// Bottom navigation repeated on every screen. Only "Inicio" does something
/// for now and it is always the active item.
class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.ink,
              width: AppDecorations.borderWidth,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 74,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: Row(
                children: [
                  _NavItem(
                    icon: Icons.home_outlined,
                    label: 'Inicio',
                    active: true,
                    onTap: () => Navigator.of(
                      context,
                    ).popUntil((route) => route.isFirst),
                  ),
                  // TODO(nav): Repaso and Progreso have no screens yet.
                  const _NavItem(icon: Icons.style_outlined, label: 'Repaso'),
                  const _NavItem(
                    icon: Icons.bar_chart_rounded,
                    label: 'Progreso',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    this.active = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.ink : AppColors.navInactive;
    return Expanded(
      child: Semantics(
        button: true,
        selected: active,
        enabled: onTap != null,
        label: label,
        excludeSemantics: true,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 3,
            children: [
              Container(
                width: 52,
                height: 30,
                alignment: Alignment.center,
                decoration: active
                    ? BoxDecoration(
                        color: AppColors.navActive,
                        borderRadius: BorderRadius.circular(15),
                        border: AppDecorations.inkBorder,
                      )
                    : null,
                child: Icon(icon, size: active ? 18 : 20, color: color),
              ),
              Text(
                label,
                style: AppText.body(
                  11,
                  weight: active ? FontWeight.w800 : FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
