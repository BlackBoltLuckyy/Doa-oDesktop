import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_tokens.dart';
import '../common/app_card.dart';

class StockPieChart extends StatelessWidget {
  final Map<String, double> data;

  const StockPieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final entries = data.entries.toList();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Composição do estoque', style: AppTextStyles.heading.copyWith(color: tokens.text)),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: Row(
              children: [
                Expanded(
                  child: PieChart(
                    PieChartData(
                      centerSpaceRadius: 52,
                      sectionsSpace: 2,
                      sections: entries.asMap().entries.map((entry) {
                        final color = AppColors.chartPalette[entry.key % AppColors.chartPalette.length];
                        return PieChartSectionData(
                          value: entry.value.value,
                          color: color,
                          radius: 46,
                          showTitle: false,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: entries.asMap().entries.map((entry) {
                      final color = AppColors.chartPalette[entry.key % AppColors.chartPalette.length];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                entry.value.key,
                                style: AppTextStyles.label.copyWith(color: tokens.text),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              entry.value.value.toInt().toString(),
                              style: AppTextStyles.label.copyWith(
                                color: tokens.textMuted,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
