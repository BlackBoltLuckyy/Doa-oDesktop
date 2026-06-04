import 'package:flutter/material.dart';

import '../../widgets/charts/donations_bar_chart.dart';
import '../../widgets/charts/stock_pie_chart.dart';
import '../../widgets/common/stat_card.dart';
import '../../widgets/common/status_badge.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dashboard', style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: const [
              StatCard(title: 'Doações pendentes', value: '24', icon: Icons.pending, color: Color(0xFFF59E0B), subtitle: '+12% nas últimas 24h'),
              StatCard(title: 'Aprovadas esta semana', value: '18', icon: Icons.check_circle, color: Color(0xFF10B981), subtitle: '+8%'),
              StatCard(title: 'Itens em estoque', value: '312', icon: Icons.inventory, color: Color(0xFF3B82F6)),
              StatCard(title: 'Beneficiários ativos', value: '96', icon: Icons.people, color: Color(0xFF2E7D5E)),
              StatCard(title: 'Distribuições mês', value: '42', icon: Icons.local_shipping, color: Color(0xFF8B5CF6)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DonationsBarChart(
                  values: const [12, 20, 18, 9, 6],
                  categories: const ['Roupas', 'Alimentos', 'Móveis', 'Eletrônicos', 'Outros'],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: StockPieChart(data: const {
                  'Roupas': 28,
                  'Alimentos': 34,
                  'Móveis': 18,
                  'Eletrônicos': 10,
                  'Outros': 10,
                }),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Atividade recente', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      TextButton(onPressed: () {}, child: const Text('Ver todas')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Table(
                    border: TableBorder.all(color: const Color(0xFFE2E8F0)),
                    children: const [
                      TableRow(children: [Text('Doador'), Text('Item'), Text('Categoria'), Text('Status'), Text('Data')]),
                      TableRow(children: [Text('Maria Silva'), Text('Casacos'), Text('Roupas'), StatusBadge(status: 'PENDENTE'), Text('24/05/2026')]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
