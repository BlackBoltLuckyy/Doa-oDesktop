import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class DataTableWidget<T> extends StatelessWidget {
  final List<String> columns;
  final List<T> rows;
  final TableRow Function(T item, int index) rowBuilder;
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
    required this.rowBuilder,
    required this.totalItems,
    required this.currentPage,
    required this.onPageChanged,
    this.pageSize = 10,
    this.onSearch,
    this.filterWidget,
    this.isLoading = false,
  });

  int get _totalPages => totalItems == 0 ? 1 : (totalItems / pageSize).ceil();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Barra de busca e filtros
        if (onSearch != null || filterWidget != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                if (onSearch != null)
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Buscar...',
                        prefixIcon: Icon(Icons.search, size: 20),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onChanged: onSearch,
                    ),
                  ),
                if (onSearch != null && filterWidget != null)
                  const SizedBox(width: 12),
                if (filterWidget != null) filterWidget!,
              ],
            ),
          ),

        // Conteúdo
        if (isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: CircularProgressIndicator(),
            ),
          )
        else if (rows.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Column(
                children: [
                  Icon(Icons.inbox_outlined, size: 48, color: Colors.black26),
                  const SizedBox(height: 12),
                  const Text(
                    'Nenhum registro encontrado.',
                    style: TextStyle(color: Colors.black45),
                  ),
                ],
              ),
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Table(
                border: TableBorder.symmetric(
                  inside: const BorderSide(color: AppColors.borderColor),
                ),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  // Cabeçalho
                  TableRow(
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundLight,
                    ),
                    children: columns
                        .map(
                          (col) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            child: Text(
                              col,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  // Linhas de dados
                  ...rows.asMap().entries.map(
                        (entry) => rowBuilder(entry.value, entry.key),
                      ),
                ],
              ),
            ),
          ),

        // Paginação
        if (!isLoading)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$totalItems registro${totalItems == 1 ? '' : 's'}',
                  style: const TextStyle(fontSize: 13, color: Colors.black45),
                ),
                Row(
                  children: [
                    Text(
                      'Página $currentPage de $_totalPages',
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.chevron_left, size: 20),
                      onPressed: currentPage > 1
                          ? () => onPageChanged(currentPage - 1)
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right, size: 20),
                      onPressed: currentPage < _totalPages
                          ? () => onPageChanged(currentPage + 1)
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
