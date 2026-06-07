import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../widgets/charts/donations_bar_chart.dart';
import '../../widgets/charts/stock_pie_chart.dart';
import '../../widgets/common/stat_card.dart';
import '../../widgets/common/status_badge.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const _recentActivity = [
    {'doador': 'Maria Silva', 'item': 'Casacos', 'categoria': 'Roupas', 'status': 'PENDENTE', 'data': '07/06/2026'},
    {'doador': 'João Costa', 'item': 'Cesta básica', 'categoria': 'Alimentos', 'status': 'APROVADO', 'data': '07/06/2026'},
    {'doador': 'Ana Souza', 'item': 'Tênis', 'categoria': 'Calçados', 'status': 'EM_ESTOQUE', 'data': '06/06/2026'},
    {'doador': 'Pedro Alves', 'item': 'Cadeiras', 'categoria': 'Móveis', 'status': 'RECUSADO', 'data': '06/06/2026'},
    {'doador': 'Carla Lima', 'item': 'Livros', 'categoria': 'Educação', 'status': 'PENDENTE', 'data': '05/06/2026'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cabeçalho
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dashboard', style: AppTextStyles.displayTitle),
                const SizedBox(height: 4),
                Text(
                  'Visão geral das operações — hoje',
                  style: AppTextStyles.body.copyWith(color: Colors.black45),
                ),
              ],
            ),
            Text(
              '07 de junho de 2026',
              style: AppTextStyles.label,
            ),
          ],
        ),
        const SizedBox(height: 28),

        // KPIs
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: const [
            StatCard(
              title: 'Doações pendentes',
              value: '24',
              icon: Icons.pending_outlined,
              color: AppColors.statusPending,
              subtitle: '+12% nas últimas 24h',
              isPositiveTrend: false,
            ),
            StatCard(
              title: 'Aprovadas esta semana',
              value: '18',
              icon: Icons.check_circle_outline,
              color: AppColors.statusApproved,
              subtitle: '+8% vs. semana anterior',
              isPositiveTrend: true,
            ),
            StatCard(
              title: 'Itens em estoque',
              value: '312',
              icon: Icons.inventory_2_outlined,
              color: AppColors.statusInStock,
            ),
            StatCard(
              title: 'Beneficiários ativos',
              value: '96',
              icon: Icons.people_outline,
              color: AppColors.secondaryColor,
            ),
            StatCard(
              title: 'Distribuições este mês',
              value: '42',
              icon: Icons.local_shipping_outlined,
              color: AppColors.statusDelivered,
              subtitle: '+5 hoje',
              isPositiveTrend: true,
            ),
          ],
        ),
        const SizedBox(height: 28),

        // Gráficos
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: DonationsBarChart(
                values: const [12, 20, 18, 9, 6],
                categories: const ['Roupas', 'Alimentos', 'Móveis', 'Eletrônicos', 'Outros'],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
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
        const SizedBox(height: 28),

        // Atividade recente
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Atividade recente', style: AppTextStyles.heading),
                    TextButton.icon(
                      onPressed: () => context.go(AppRoutes.kDoacoes),
                      icon: const Icon(Icons.arrow_forward, size: 16),
                      label: const Text('Ver todas'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Cabeçalho da tabela
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundLight,
                    border: Border(
                      bottom: BorderSide(color: AppColors.borderColor),
                    ),
                  ),
                  child: Row(
                    children: [
                      _HeaderCell('Doador', flex: 2),
                      _HeaderCell('Item', flex: 2),
                      _HeaderCell('Categoria', flex: 2),
                      _HeaderCell('Status', flex: 2),
                      _HeaderCell('Data', flex: 1),
                    ],
                  ),
                ),

                // Linhas
                ..._recentActivity.asMap().entries.map((entry) {
                  final i = entry.key;
                  final row = entry.value;
                  return Container(
                    decoration: BoxDecoration(
                      color: i.isEven ? Colors.white : const Color(0xFFF9FAFB),
                      border: const Border(
                        bottom: BorderSide(color: AppColors.borderColor),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        _DataCell(row['doador']!, flex: 2),
                        _DataCell(row['item']!, flex: 2),
                        _DataCell(row['categoria']!, flex: 2),
                        Expanded(
                          flex: 2,
                          child: StatusBadge(status: row['status']!),
                        ),
                        _DataCell(row['data']!, flex: 1),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  final int flex;

  const _HeaderCell(this.text, {required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: Colors.black54,
        ),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text;
  final int flex;

  const _DataCell(this.text, {required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(text, style: const TextStyle(fontSize: 13)),
    );
  }
}
