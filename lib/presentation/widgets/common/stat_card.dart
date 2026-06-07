import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

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
    return SizedBox(
      width: 200,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: color, size: 22),
                  ),
                  if (isPositiveTrend != null)
                    Icon(
                      isPositiveTrend! ? Icons.trending_up : Icons.trending_down,
                      color: isPositiveTrend! ? AppColors.statusApproved : AppColors.statusRejected,
                      size: 18,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(title, style: AppTextStyles.label),
              const SizedBox(height: 6),
              Text(
                value,
                style: AppTextStyles.heading.copyWith(
                  fontSize: 26,
                  color: AppColors.primaryColor,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 6),
                Text(
                  subtitle!,
                  style: AppTextStyles.label.copyWith(
                    color: isPositiveTrend == null
                        ? Colors.black45
                        : isPositiveTrend!
                            ? AppColors.statusApproved
                            : AppColors.statusRejected,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
