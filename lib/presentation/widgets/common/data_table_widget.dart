import 'package:flutter/material.dart';

class DataTableWidget<T> extends StatelessWidget {
  final List<String> columns;
  final List<T> rows;
  final Widget Function(T item, int index) rowBuilder;
  final int totalItems;
  final int currentPage;
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
    this.onSearch,
    this.filterWidget,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (onSearch != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: onSearch,
            ),
          ),
        if (filterWidget != null) filterWidget!,
        if (isLoading)
          const Center(child: CircularProgressIndicator())
        else if (rows.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Text('Nenhum registro encontrado.'),
          )
        else
          Table(
            border: TableBorder.symmetric(
              inside: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            children: [
              TableRow(
                decoration: const BoxDecoration(color: Color(0xFFF4F7FA)),
                children: columns.map((column) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(column, style: const TextStyle(fontWeight: FontWeight.bold)),
                )).toList(),
              ),
              ...rows.asMap().entries.map((entry) => rowBuilder(entry.value, entry.key)).toList(),
            ],
          ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Página $currentPage de ${((totalItems / rows.length).ceil())}'),
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: currentPage < (totalItems / rows.length).ceil() ? () => onPageChanged(currentPage + 1) : null,
            ),
          ],
        ),
      ],
    );
  }
}
