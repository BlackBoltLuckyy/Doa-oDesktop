import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_tokens.dart';
import 'app_card.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? subtitle;
  final bool? isPositiveTrend;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.subtitle,
    this.isPositiveTrend,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return SizedBox(
      width: 220,
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.input),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 16),
            Text(title, style: AppTextStyles.label.copyWith(color: tokens.textMuted)),
            const SizedBox(height: 6),
            Text(
              value,
              style: AppTextStyles.metricValue.copyWith(color: tokens.text),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 6),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isPositiveTrend != null) ...[
                    Icon(
                      isPositiveTrend! ? Icons.trending_up : Icons.trending_down,
                      size: 14,
                      color: isPositiveTrend!
                          ? AppColors.statusApproved
                          : AppColors.statusRejected,
                    ),
                    const SizedBox(width: 4),
                  ],
                  Flexible(
                    child: Text(
                      subtitle!,
                      style: AppTextStyles.label.copyWith(
                        color: isPositiveTrend == null
                            ? tokens.textMuted
                            : isPositiveTrend!
                                ? AppColors.statusApproved
                                : AppColors.statusRejected,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
