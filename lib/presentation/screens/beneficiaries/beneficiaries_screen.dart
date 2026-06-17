import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../widgets/common/data_table_widget.dart';

class BeneficiariesScreen extends StatefulWidget {
  const BeneficiariesScreen({super.key});

  @override
  State<BeneficiariesScreen> createState() => _BeneficiariesScreenState();
}

class _BeneficiariesScreenState extends State<BeneficiariesScreen> {
  int _currentPage = 1;
  static const int _pageSize = 10;

  final List<Map<String, dynamic>> _rows = List.generate(
    7,
    (i) => {
      'id': i + 1,
      'nome': [
        'Maria Silva',
        'João Costa',
        'Ana Souza',
        'Pedro Alves',
        'Carla Lima',
        'Roberto Nunes',
        'Lucia Santos',
      ][i],
      'cpf':
          '${(i + 1) * 111}.${(i + 1) * 222}.${(i + 1) * 333}-${(i + 1) * 11}',
      'telefone': '(11) 9${i + 1}000-000${i}',
      'dependentes': [3, 1, 4, 2, 5, 0, 3][i],
      'ultimaDistribuicao': '${(i * 3 + 1).toString().padLeft(2, '0')}/05/2026',
      'status': i == 3 ? 'Inativo' : 'Ativo',
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
            Text('Beneficiários', style: AppTextStyles.displayTitle),
            ElevatedButton.icon(
              onPressed: () => context.go('${AppRoutes.kBeneficiarios}/novo'),
              icon: const Icon(Icons.person_add_outlined,
                  size: 18, color: Colors.white),
              label: const Text('Novo beneficiário',
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        DataTableWidget<Map<String, dynamic>>(
          columns: const [
            'Nome',
            'CPF',
            'Telefone',
            'Dependentes',
            'Última distribuição',
            'Status',
            'Ações',
          ],
          rows: _rows,
          totalItems: _rows.length,
          currentPage: _currentPage,
          pageSize: _pageSize,
          onPageChanged: (p) => setState(() => _currentPage = p),
          onSearch: (query) {},
          rowBuilder: (item, index) {
            final isActive = item['status'] == 'Ativo';

            return TableRow(
              decoration: BoxDecoration(
                color: index.isEven ? Colors.white : const Color(0xFFF9FAFB),
              ),
              children: [
                // Nome com avatar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor:
                            AppColors.primaryColor.withOpacity(0.1),
                        child: Text(
                          (item['nome'] as String)[0],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(item['nome'] as String,
                          style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
                _Cell(item['cpf'] as String),
                _Cell(item['telefone'] as String),
                _Cell(item['dependentes'].toString()),
                _Cell(item['ultimaDistribuicao'] as String),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.statusApproved.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item['status'] as String,
                      style: TextStyle(
                        color:
                            isActive ? AppColors.statusApproved : Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, size: 18),
                        tooltip: 'Editar',
                        onPressed: () => context.go(
                          '${AppRoutes.kBeneficiarios}/${item['id']}/editar',
                        ),
                        constraints:
                            const BoxConstraints(minWidth: 32, minHeight: 32),
                        padding: EdgeInsets.zero,
                      ),
                      IconButton(
                        icon:
                            const Icon(Icons.local_shipping_outlined, size: 18),
                        tooltip: 'Nova distribuição',
                        color: AppColors.secondaryColor,
                        onPressed: () => context.go(AppRoutes.kDistribuicoes),
                        constraints:
                            const BoxConstraints(minWidth: 32, minHeight: 32),
                        padding: EdgeInsets.zero,
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
