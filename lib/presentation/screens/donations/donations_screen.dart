import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../widgets/common/data_table_widget.dart';
import '../../widgets/common/status_badge.dart';

class DonationsScreen extends StatefulWidget {
  const DonationsScreen({super.key});

  @override
  State<DonationsScreen> createState() => _DonationsScreenState();
}

class _DonationsScreenState extends State<DonationsScreen> {
  String _statusFilter = 'TODOS';
  int _currentPage = 1;
  static const int _pageSize = 10;

  final List<Map<String, dynamic>> _rows = List.generate(
    8,
    (i) => {
      'id': i + 1,
      'doador': 'Doador ${i + 1}',
      'item': 'Item ${i + 1}',
      'categoria': ['Roupas', 'Alimentos', 'Móveis', 'Outros'][i % 4],
      'status': ['PENDENTE', 'APROVADO', 'RECUSADO', 'EM_ESTOQUE'][i % 4],
      'data': '${(i + 1).toString().padLeft(2, '0')}/06/2026',
    },
  );

  List<Map<String, dynamic>> get _filteredRows {
    if (_statusFilter == 'TODOS') return _rows;
    return _rows.where((r) => r['status'] == _statusFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredRows;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Triagem de doações', style: AppTextStyles.displayTitle),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.filter_list, size: 18, color: Colors.white),
              label: const Text('Filtros', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Filtro de status
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ['TODOS', 'PENDENTE', 'APROVADO', 'RECUSADO', 'EM_ESTOQUE']
                .map((status) => _StatusFilterChip(
                      status: status,
                      isSelected: _statusFilter == status,
                      onTap: () => setState(() {
                        _statusFilter = status;
                        _currentPage = 1;
                      }),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 16),

        DataTableWidget<Map<String, dynamic>>(
          columns: const ['#', 'Doador', 'Item', 'Categoria', 'Status', 'Data', 'Ações'],
          rows: filtered,
          totalItems: filtered.length,
          currentPage: _currentPage,
          pageSize: _pageSize,
          onPageChanged: (p) => setState(() => _currentPage = p),
          onSearch: (query) {},
          rowBuilder: (item, index) {
            return TableRow(
              decoration: BoxDecoration(
                color: index.isEven ? Colors.white : const Color(0xFFF9FAFB),
              ),
              children: [
                _Cell(item['id'].toString()),
                _Cell(item['doador'] as String),
                _Cell(item['item'] as String),
                _Cell(item['categoria'] as String),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: StatusBadge(status: item['status'] as String),
                ),
                _Cell(item['data'] as String),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _ActionButton(
                        icon: Icons.visibility_outlined,
                        tooltip: 'Ver detalhes',
                        onPressed: () => context.go(
                          '${AppRoutes.kDoacoes}/${item['id']}',
                        ),
                      ),
                      _ActionButton(
                        icon: Icons.check_circle_outline,
                        tooltip: 'Aprovar',
                        color: AppColors.statusApproved,
                        onPressed: item['status'] == 'PENDENTE'
                            ? () => _onApprove(item['id'] as int)
                            : null,
                      ),
                      _ActionButton(
                        icon: Icons.cancel_outlined,
                        tooltip: 'Recusar',
                        color: AppColors.statusRejected,
                        onPressed: item['status'] == 'PENDENTE'
                            ? () => _onReject(item['id'] as int)
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _onApprove(int id) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Doação aprovada.'),
        backgroundColor: AppColors.statusApproved,
      ),
    );
  }

  void _onReject(int id) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Doação recusada.'),
        backgroundColor: AppColors.statusRejected,
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  final String text;

  const _Cell(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Text(text, style: const TextStyle(fontSize: 13)),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final Color? color;
  final VoidCallback? onPressed;

  const _ActionButton({
    required this.icon,
    required this.tooltip,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 18, color: onPressed == null ? Colors.black26 : color),
      tooltip: tooltip,
      onPressed: onPressed,
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      padding: EdgeInsets.zero,
    );
  }
}

class _StatusFilterChip extends StatelessWidget {
  final String status;
  final bool isSelected;
  final VoidCallback onTap;

  const _StatusFilterChip({
    required this.status,
    required this.isSelected,
    required this.onTap,
  });

  static const _labels = {
    'TODOS': 'Todos',
    'PENDENTE': 'Pendentes',
    'APROVADO': 'Aprovados',
    'RECUSADO': 'Recusados',
    'EM_ESTOQUE': 'Em estoque',
  };

  static const _colors = {
    'TODOS': AppColors.primaryColor,
    'PENDENTE': AppColors.statusPending,
    'APROVADO': AppColors.statusApproved,
    'RECUSADO': AppColors.statusRejected,
    'EM_ESTOQUE': AppColors.statusInStock,
  };

  @override
  Widget build(BuildContext context) {
    final color = _colors[status] ?? AppColors.primaryColor;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.transparent,
            border: Border.all(color: isSelected ? color : AppColors.borderColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            _labels[status] ?? status,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black54,
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
