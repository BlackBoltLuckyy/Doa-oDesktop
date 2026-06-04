import 'package:flutter/material.dart';

import '../../widgets/common/data_table_widget.dart';
import '../../widgets/common/status_badge.dart';

class DonationsScreen extends StatefulWidget {
  const DonationsScreen({super.key});

  @override
  State<DonationsScreen> createState() => _DonationsScreenState();
}

class _DonationsScreenState extends State<DonationsScreen> {
  String statusFilter = 'TODOS';
  int currentPage = 1;
  final rows = List.generate(5, (index) => {
        'id': index + 1,
        'doador': 'Doador ${index + 1}',
        'item': 'Item ${index + 1}',
        'categoria': 'Roupas',
        'status': 'PENDENTE',
        'data': '24/05/2026',
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Triagem de doações', style: Theme.of(context).textTheme.displayLarge),
        const SizedBox(height: 16),
        DataTableWidget<Map<String, dynamic>>(
          columns: const ['ID', 'Doador', 'Item', 'Categoria', 'Status', 'Data', 'Ações'],
          rows: rows,
          totalItems: 25,
          currentPage: currentPage,
          onPageChanged: (page) => setState(() => currentPage = page),
          onSearch: (query) {},
          rowBuilder: (item, index) {
            return TableRow(
              decoration: BoxDecoration(color: index.isEven ? Colors.white : const Color(0xFFF9FAFB)),
              children: [
                Padding(padding: const EdgeInsets.all(12), child: Text(item['id'].toString())),
                Padding(padding: const EdgeInsets.all(12), child: Text(item['doador']!)),
                Padding(padding: const EdgeInsets.all(12), child: Text(item['item']!)),
                Padding(padding: const EdgeInsets.all(12), child: Text(item['categoria']!)),
                Padding(padding: const EdgeInsets.all(12), child: StatusBadge(status: item['status']!)),
                Padding(padding: const EdgeInsets.all(12), child: Text(item['data']!)),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.visibility)),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.check, color: Colors.green)),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.close, color: Colors.red)),
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
}
