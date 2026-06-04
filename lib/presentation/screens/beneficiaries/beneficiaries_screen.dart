import 'package:flutter/material.dart';

import '../../widgets/common/data_table_widget.dart';

class BeneficiariesScreen extends StatefulWidget {
  const BeneficiariesScreen({super.key});

  @override
  State<BeneficiariesScreen> createState() => _BeneficiariesScreenState();
}

class _BeneficiariesScreenState extends State<BeneficiariesScreen> {
  int currentPage = 1;
  final rows = List.generate(5, (index) => {
        'id': index + 1,
        'nome': 'Beneficiário ${index + 1}',
        'cpf': '000.000.000-0${index + 1}',
        'telefone': '(11) 9${index + 1}000-000${index}',
        'dependentes': 3,
        'ultimaDistribuicao': '20/05/2026',
        'status': 'Ativo',
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Beneficiários', style: Theme.of(context).textTheme.displayLarge),
        const SizedBox(height: 16),
        DataTableWidget<Map<String, dynamic>>(
          columns: const ['Nome', 'CPF', 'Telefone', 'Dependentes', 'Última distribuição', 'Status', 'Ações'],
          rows: rows,
          totalItems: 10,
          currentPage: currentPage,
          onPageChanged: (page) => setState(() => currentPage = page),
          onSearch: (query) {},
          rowBuilder: (item, index) {
            return TableRow(
              decoration: BoxDecoration(color: index.isEven ? Colors.white : const Color(0xFFF9FAFB)),
              children: [
                Padding(padding: const EdgeInsets.all(12), child: Text(item['nome']!)),
                Padding(padding: const EdgeInsets.all(12), child: Text(item['cpf']!)),
                Padding(padding: const EdgeInsets.all(12), child: Text(item['telefone']!)),
                Padding(padding: const EdgeInsets.all(12), child: Text(item['dependentes'].toString())),
                Padding(padding: const EdgeInsets.all(12), child: Text(item['ultimaDistribuicao']!)),
                Padding(padding: const EdgeInsets.all(12), child: Text(item['status']!)),
                Padding(padding: const EdgeInsets.all(12), child: IconButton(onPressed: () {}, icon: const Icon(Icons.edit))),
              ],
            );
          },
        ),
      ],
    );
  }
}
