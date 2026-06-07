import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StockPieChart extends StatelessWidget {
  final Map<String, double> data;

  const StockPieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Composição do estoque'),
            const SizedBox(height: 16),
            SizedBox(
              height: 260,
              child: PieChart(
                PieChartData(
                  sections: data.entries.map((entry) {
                    return PieChartSectionData(
                      value: entry.value,
                      title: entry.key,
                      color: Colors.primaries[data.keys.toList().indexOf(entry.key) % Colors.primaries.length],
                      radius: 80,
                      titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
