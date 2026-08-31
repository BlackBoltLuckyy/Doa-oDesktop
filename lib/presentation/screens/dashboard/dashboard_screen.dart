import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../data/models/dashboard_stats_model.dart';
import '../../providers/dashboard_provider.dart';
import '../../widgets/charts/donations_bar_chart.dart';
import '../../widgets/charts/stock_pie_chart.dart';
import '../../widgets/common/app_card.dart';
import '../../widgets/common/app_progress_bar.dart';
import '../../widgets/common/page_header.dart';
import '../../widgets/common/stat_card.dart';
import '../../widgets/common/status_badge.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageHeader(
          title: 'Dashboard',
          subtitle: 'Visão geral das operações — hoje',
        ),
        const SizedBox(height: 28),
        statsAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 80),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: Center(
              child: Text(
                'Não foi possível carregar o dashboard: $error',
                style: AppTextStyles.body.copyWith(color: context.tokens.textMuted),
              ),
            ),
          ),
          data: (stats) => _DashboardContent(stats: stats),
        ),
      ],
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final DashboardStatsModel stats;

  const _DashboardContent({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // KPIs
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            StatCard(
              title: 'Doações pendentes',
              value: '${stats.doacoesPendentes}',
              icon: Icons.pending_outlined,
              color: AppColors.statusPending,
              subtitle: stats.tendenciaPendentes,
              isPositiveTrend: stats.tendenciaPendentes == null
                  ? null
                  : stats.tendenciaPendentesPositiva,
            ),
            StatCard(
              title: 'Aprovadas esta semana',
              value: '${stats.doacoesAprovadas}',
              icon: Icons.check_circle_outline,
              color: AppColors.statusApproved,
              subtitle: stats.tendenciaAprovadas,
              isPositiveTrend: stats.tendenciaAprovadas == null
                  ? null
                  : stats.tendenciaAprovadasPositiva,
            ),
            StatCard(
              title: 'Itens em estoque',
              value: '${stats.itensEstoque}',
              icon: Icons.inventory_2_outlined,
              color: AppColors.statusInStock,
            ),
            StatCard(
              title: 'Beneficiários ativos',
              value: '${stats.beneficiariosAtivos}',
              icon: Icons.people_outline,
              color: AppColors.secondary,
            ),
            StatCard(
              title: 'Distribuições este mês',
              value: '${stats.distribuicoesNoMes}',
              icon: Icons.local_shipping_outlined,
              color: AppColors.statusDelivered,
              subtitle: stats.tendenciaDistribuicoes,
              isPositiveTrend: stats.tendenciaDistribuicoes == null
                  ? null
                  : stats.tendenciaDistribuicoesPositiva,
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
                values: stats.doacoesValores,
                categories: stats.doacoesCategorias,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: StockPieChart(data: stats.estoquePorCategoria),
            ),
          ],
        ),
        const SizedBox(height: 28),

        // Metas do mês
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Metas do mês', style: AppTextStyles.heading.copyWith(color: tokens.text)),
              const SizedBox(height: 16),
              _GoalRow(label: 'Distribuições', value: stats.distribuicoesNoMes, target: 60),
              const SizedBox(height: 14),
              _GoalRow(label: 'Beneficiários atendidos', value: stats.beneficiariosAtivos, target: 120),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // Atividade recente
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Atividade recente', style: AppTextStyles.heading.copyWith(color: tokens.text)),
                  TextButton.icon(
                    onPressed: () => context.go(AppRoutes.kDoacoes),
                    icon: const Icon(Icons.arrow_forward, size: 16),
                    label: const Text('Ver todas'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: tokens.tableHeaderBg,
                  border: Border(bottom: BorderSide(color: tokens.border)),
                ),
                child: const Row(
                  children: [
                    _HeaderCell('Doador', flex: 2),
                    _HeaderCell('Item', flex: 2),
                    _HeaderCell('Categoria', flex: 2),
                    _HeaderCell('Status', flex: 2),
                    _HeaderCell('Data', flex: 1),
                  ],
                ),
              ),
              ...stats.atividadeRecente.map((item) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: tokens.border)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Row(
                    children: [
                      _DataCell(item.doador, flex: 2),
                      _DataCell(item.item, flex: 2),
                      _DataCell(item.categoria, flex: 2),
                      Expanded(flex: 2, child: StatusBadge(status: item.status)),
                      _DataCell(item.data, flex: 1),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _GoalRow extends StatelessWidget {
  final String label;
  final int value;
  final int target;

  const _GoalRow({super.key, required this.label, required this.value, required this.target});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final progress = target == 0 ? 0.0 : value / target;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTextStyles.body.copyWith(color: tokens.text)),
            Text(
              '$value / $target',
              style: AppTextStyles.label.copyWith(color: tokens.textMuted),
            ),
          ],
        ),
        const SizedBox(height: 8),
        AppProgressBar(value: progress),
      ],
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  final int flex;

  const _HeaderCell(this.text, {super.key, required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text.toUpperCase(),
        style: AppTextStyles.tableHeader.copyWith(color: context.tokens.textMuted),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text;
  final int flex;

  const _DataCell(this.text, {super.key, required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: AppTextStyles.body.copyWith(color: context.tokens.text, fontSize: 13),
      ),
    );
  }
}
