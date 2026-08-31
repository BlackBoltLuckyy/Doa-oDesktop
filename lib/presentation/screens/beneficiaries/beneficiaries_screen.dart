import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_tokens.dart';
import '../../widgets/common/gradient_button.dart';
import '../../widgets/common/data_table_widget.dart';
import '../../widgets/common/page_header.dart';
import '../../widgets/common/status_badge.dart';

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
      'telefone': '(11) 9${i + 1}000-000$i',
      'dependentes': [3, 1, 4, 2, 5, 0, 3][i],
      'ultimaDistribuicao': '${(i * 3 + 1).toString().padLeft(2, '0')}/05/2026',
      'status': i == 3 ? 'INATIVO' : 'ATIVO',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageHeader(
          title: 'Beneficiários',
          subtitle: 'Cadastro de famílias e pessoas atendidas.',
          trailing: GradientButton(
            label: 'Novo beneficiário',
            icon: Icons.person_add_outlined,
            onPressed: () => context.go('${AppRoutes.kBeneficiarios}/novo'),
          ),
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
          columnFlex: const [2, 2, 2, 1, 2, 1, 1],
          rows: _rows,
          totalItems: _rows.length,
          currentPage: _currentPage,
          pageSize: _pageSize,
          onPageChanged: (p) => setState(() => _currentPage = p),
          onSearch: (query) {},
          cellsBuilder: (item, index) {
            final tokens = context.tokens;

            return [
              Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                    child: Text(
                      (item['nome'] as String)[0],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item['nome'] as String,
                      style: AppTextStyles.body.copyWith(color: tokens.text, fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              _Cell(item['cpf'] as String),
              _Cell(item['telefone'] as String),
              _Cell(item['dependentes'].toString()),
              _Cell(item['ultimaDistribuicao'] as String),
              StatusBadge(status: item['status'] as String),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    tooltip: 'Editar',
                    onPressed: () => context.go(
                      '${AppRoutes.kBeneficiarios}/${item['id']}/editar',
                    ),
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    padding: EdgeInsets.zero,
                  ),
                  IconButton(
                    icon: const Icon(Icons.local_shipping_outlined, size: 18),
                    tooltip: 'Nova distribuição',
                    color: AppColors.secondary,
                    onPressed: () => context.go(AppRoutes.kDistribuicoes),
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    padding: EdgeInsets.zero,
                  ),
                ],
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
