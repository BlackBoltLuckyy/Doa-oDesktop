import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_tokens.dart';
import '../../widgets/common/data_table_widget.dart';
import '../../widgets/common/gradient_button.dart';
import '../../widgets/common/page_header.dart';

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
        PageHeader(
          title: 'Gestão de estoque',
          subtitle: 'Itens disponíveis para distribuição.',
          trailing: GradientButton(
            label: 'Nova entrada',
            icon: Icons.add,
            onPressed: () => context.go('${AppRoutes.kEstoque}/entrada'),
          ),
        ),
        const SizedBox(height: 20),

        DataTableWidget<Map<String, dynamic>>(
          columns: const [
            '#', 'Item', 'Categoria', 'Quantidade', 'Unidade', 'Entrada', 'Origem', 'Ações',
          ],
          columnFlex: const [1, 2, 2, 2, 1, 1, 2, 1],
          rows: _rows,
          totalItems: _rows.length,
          currentPage: _currentPage,
          pageSize: _pageSize,
          onPageChanged: (p) => setState(() => _currentPage = p),
          onSearch: (query) {},
          cellsBuilder: (item, index) {
            final qtd = item['quantidade'] as int;
            final isLow = qtd < 10;
            final tokens = context.tokens;

            return [
              _Cell(item['id'].toString()),
              _Cell(item['item'] as String),
              _Cell(item['categoria'] as String),
              Row(
                children: [
                  Text(
                    qtd.toString(),
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isLow ? AppColors.statusRejected : tokens.text,
                    ),
                  ),
                  if (isLow) ...[
                    const SizedBox(width: 6),
                    const Icon(Icons.warning_amber, size: 14, color: AppColors.warning),
                  ],
                ],
              ),
              _Cell(item['unidade'] as String),
              _Cell(item['data'] as String),
              _Cell(item['origem'] as String),
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 18),
                tooltip: 'Ajustar quantidade',
                onPressed: () {},
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                padding: EdgeInsets.zero,
              ),
            ];
          },
        ),
      ],
    );
  }
}

class _Cell extends StatelessWidget {
  final String text;

  const _Cell(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.body.copyWith(color: context.tokens.text, fontSize: 13),
    );
  }
}
