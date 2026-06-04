import 'package:flutter/material.dart';

import '../../widgets/common/data_table_widget.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  int currentPage = 1;
  final rows = List.generate(5, (index) => {
        'id': index + 1,
        'item': 'Cobertor ${index + 1}',
        'categoria': 'Alimentos',
        'quantidade': 20,
        'unidade': 'un',
        'data': '22/05/2026',
        'origem': 'Doação #${index + 100}',
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gestão de estoque', style: Theme.of(context).textTheme.displayLarge),
        const SizedBox(height: 16),
        DataTableWidget<Map<String, dynamic>>(
          columns: const ['ID', 'Item', 'Categoria', 'Quantidade', 'Unidade', 'Data de entrada', 'Origem', 'Ações'],
          rows: rows,
          totalItems: 20,
          currentPage: currentPage,
          onPageChanged: (page) => setState(() => currentPage = page),
          onSearch: (query) {},
          rowBuilder: (item, index) {
            return TableRow(
              decoration: BoxDecoration(color: index.isEven ? Colors.white : const Color(0xFFF9FAFB)),
              children: [
                Padding(padding: const EdgeInsets.all(12), child: Text(item['id'].toString())),
                Padding(padding: const EdgeInsets.all(12), child: Text(item['item']!)),
                Padding(padding: const EdgeInsets.all(12), child: Text(item['categoria']!)),
                Padding(padding: const EdgeInsets.all(12), child: Text(item['quantidade'].toString())),
                Padding(padding: const EdgeInsets.all(12), child: Text(item['unidade']!)),
                Padding(padding: const EdgeInsets.all(12), child: Text(item['data']!)),
                Padding(padding: const EdgeInsets.all(12), child: Text(item['origem']!)),
                Padding(padding: const EdgeInsets.all(12), child: IconButton(onPressed: () {}, icon: const Icon(Icons.edit))),
              ],
            );
          },
        ),
      ],
    );
  }
}
