import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DonationsBarChart extends StatelessWidget {
  final List<double> values;
  final List<String> categories;

  const DonationsBarChart({super.key, required this.values, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Doações por categoria (últimos 7 dias)'),
            const SizedBox(height: 16),
            SizedBox(
              height: 260,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: values.isNotEmpty ? values.reduce((a, b) => a > b ? a : b) + 4 : 10,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        return Text(categories[index]);
                      }, reservedSize: 40),
                    ),
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                  ),
                  barGroups: values.asMap().entries.map((entry) {
                    return BarChartGroupData(
                      x: entry.key,
                      barRods: [BarChartRodData(toY: entry.value, color: Theme.of(context).primaryColor)],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
