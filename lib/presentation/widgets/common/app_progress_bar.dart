import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class AppProgressBar extends StatelessWidget {
  /// Valor entre 0 e 1.
  final double value;

  const AppProgressBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final clamped = value < 0 ? 0.0 : (value > 1 ? 1.0 : value);

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        height: 8,
        width: double.infinity,
        color: AppColors.primary.withValues(alpha: 0.15),
        child: Align(
          alignment: Alignment.centerLeft,
          child: AnimatedFractionallySizedBox(
            duration: const Duration(milliseconds: 300),
            widthFactor: clamped,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
