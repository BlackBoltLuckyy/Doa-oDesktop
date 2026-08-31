import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_tokens.dart';
import 'app_card.dart';
import 'app_text_field.dart';

class DataTableWidget<T> extends StatelessWidget {
  final List<String> columns;
  final List<T> rows;
  final List<Widget> Function(T item, int index) cellsBuilder;
  final List<int>? columnFlex;
  final int totalItems;
  final int currentPage;
  final int pageSize;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<String>? onSearch;
  final Widget? filterWidget;
  final bool isLoading;

  const DataTableWidget({
    super.key,
    required this.columns,
    required this.rows,
    required this.cellsBuilder,
    this.columnFlex,
    required this.totalItems,
    required this.currentPage,
    required this.onPageChanged,
    this.pageSize = 10,
    this.onSearch,
    this.filterWidget,
    this.isLoading = false,
  });

  int get _totalPages => totalItems == 0 ? 1 : (totalItems / pageSize).ceil();

  List<int> get _flex => columnFlex ?? List.filled(columns.length, 1);

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (onSearch != null || filterWidget != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  if (onSearch != null) Expanded(child: AppSearchField(onChanged: onSearch!)),
                  if (onSearch != null && filterWidget != null) const SizedBox(width: 12),
                  if (filterWidget != null) filterWidget!,
                ],
              ),
            ),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.input),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: tokens.border)),
              child: Column(
                children: [
                  Container(
                    color: tokens.tableHeaderBg,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    child: Row(
                      children: [
                        for (var i = 0; i < columns.length; i++)
                          Expanded(
                            flex: _flex[i],
                            child: Text(
                              columns[i].toUpperCase(),
                              style: AppTextStyles.tableHeader
                                  .copyWith(color: tokens.textMuted),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (isLoading)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 48),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (rows.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 48),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Icons.inbox_outlined, size: 40, color: tokens.textMuted),
                            const SizedBox(height: 12),
                            Text(
                              'Nenhum registro encontrado.',
                              style: AppTextStyles.body.copyWith(color: tokens.textMuted),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ...rows.asMap().entries.map(
                          (entry) => _DataRow(
                            cells: cellsBuilder(entry.value, entry.key),
                            flex: _flex,
                            isLast: entry.key == rows.length - 1,
                          ),
                        ),
                ],
              ),
            ),
          ),
          if (!isLoading) ...[
            const SizedBox(height: 16),
            _Pagination(
              totalItems: totalItems,
              currentPage: currentPage,
              pageSize: pageSize,
              totalPages: _totalPages,
              onPageChanged: onPageChanged,
            ),
          ],
        ],
      ),
    );
  }
}

class _DataRow extends StatefulWidget {
  final List<Widget> cells;
  final List<int> flex;
  final bool isLast;

  const _DataRow({super.key, required this.cells, required this.flex, required this.isLast});

  @override
  State<_DataRow> createState() => _DataRowState();
}

class _DataRowState extends State<_DataRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.primary.withValues(alpha: 0.06) : Colors.transparent,
          border: widget.isLast
              ? null
              : Border(bottom: BorderSide(color: tokens.border)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            for (var i = 0; i < widget.cells.length; i++)
              Expanded(flex: widget.flex[i], child: widget.cells[i]),
          ],
        ),
      ),
    );
  }
}

class _Pagination extends StatelessWidget {
  final int totalItems;
  final int currentPage;
  final int pageSize;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const _Pagination({
    super.key,
    required this.totalItems,
    required this.currentPage,
    required this.pageSize,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    final start = totalItems == 0 ? 0 : (currentPage - 1) * pageSize + 1;
    var end = currentPage * pageSize;
    if (end > totalItems) end = totalItems;

    var windowStart = currentPage - 2;
    if (windowStart < 1) windowStart = 1;
    var windowEnd = windowStart + 4;
    if (windowEnd > totalPages) {
      windowEnd = totalPages;
      windowStart = windowEnd - 4;
      if (windowStart < 1) windowStart = 1;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Mostrando $start–$end de $totalItems',
          style: AppTextStyles.label.copyWith(color: tokens.textMuted),
        ),
        Row(
          children: [
            _PageArrow(
              icon: Icons.chevron_left,
              onTap: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
            ),
            for (var page = windowStart; page <= windowEnd; page++)
              _PagePill(
                page: page,
                isActive: page == currentPage,
                onTap: () => onPageChanged(page),
              ),
            _PageArrow(
              icon: Icons.chevron_right,
              onTap: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
            ),
          ],
        ),
      ],
    );
  }
}

class _PagePill extends StatelessWidget {
  final int page;
  final bool isActive;
  final VoidCallback onTap;

  const _PagePill({super.key, required this.page, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: isActive ? null : Border.all(color: tokens.border),
          ),
          child: Text(
            '$page',
            style: AppTextStyles.label.copyWith(
              color: isActive ? Colors.white : tokens.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _PageArrow extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _PageArrow({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: tokens.border),
          ),
          child: Icon(
            icon,
            size: 18,
            color: onTap == null ? tokens.textMuted.withValues(alpha: 0.4) : tokens.textSecondary,
          ),
        ),
      ),
    );
  }
}
