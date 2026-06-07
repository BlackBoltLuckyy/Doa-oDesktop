import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../widgets/common/data_table_widget.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  int _currentPage = 1;
  static const int _pageSize = 10;

  final List<Map<String, dynamic>> _rows = List.generate(
    8,
    (i) => {
      'id': i + 1,
      'item': ['Cobertor', 'Cesta básica', 'Casaco', 'Calçado', 'Brinquedo',
          'Caderno', 'Caneta', 'Mochila'][i],
      'categoria': ['Roupas', 'Alimentos', 'Roupas', 'Calçados', 'Brinquedos',
          'Material escolar', 'Material escolar', 'Acessórios'][i],
      'quantidade': [20, 15, 30, 12, 8, 50, 100, 6][i],
      'unidade': ['un', 'cesta', 'un', 'par', 'un', 'un', 'un', 'un'][i],
      'data': '${(i + 1).toString().padLeft(2, '0')}/06/2026',
      'origem': 'Doação #${i + 100}',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Gestão de estoque', style: AppTextStyles.displayTitle),
            ElevatedButton.icon(
              onPressed: () => context.go('${AppRoutes.kEstoque}/entrada'),
              icon: const Icon(Icons.add, size: 18, color: Colors.white),
              label: const Text('Nova entrada', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        DataTableWidget<Map<String, dynamic>>(
          columns: const [
            '#', 'Item', 'Categoria', 'Quantidade', 'Unidade',
            'Entrada', 'Origem', 'Ações',
          ],
          rows: _rows,
          totalItems: _rows.length,
          currentPage: _currentPage,
          pageSize: _pageSize,
          onPageChanged: (p) => setState(() => _currentPage = p),
          onSearch: (query) {},
          rowBuilder: (item, index) {
            final qtd = item['quantidade'] as int;
            final isLow = qtd < 10;

            return TableRow(
              decoration: BoxDecoration(
                color: index.isEven ? Colors.white : const Color(0xFFF9FAFB),
              ),
              children: [
                _Cell(item['id'].toString()),
                _Cell(item['item'] as String),
                _Cell(item['categoria'] as String),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Row(
                    children: [
                      Text(
                        qtd.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isLow ? AppColors.statusRejected : Colors.black87,
                          fontSize: 13,
                        ),
                      ),
                      if (isLow) ...[
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.warning_amber,
                          size: 14,
                          color: AppColors.statusPending,
                        ),
                      ],
                    ],
                  ),
                ),
                _Cell(item['unidade'] as String),
                _Cell(item['data'] as String),
                _Cell(item['origem'] as String),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    tooltip: 'Ajustar quantidade',
                    onPressed: () {},
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    padding: EdgeInsets.zero,
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
