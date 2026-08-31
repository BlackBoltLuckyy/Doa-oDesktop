import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_tokens.dart';
import '../../widgets/common/app_card.dart';
import '../../widgets/common/page_header.dart';

class DistributionHistoryScreen extends StatelessWidget {
  const DistributionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageHeader(
          title: 'Histórico de distribuições',
          subtitle: 'Consulte entregas realizadas.',
        ),
        const SizedBox(height: 20),
        AppCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filtro por data, beneficiário ou operador',
                style: AppTextStyles.body.copyWith(color: tokens.text),
              ),
              const SizedBox(height: 16),
              Text(
                'Tabela de histórico aparecerá aqui.',
                style: AppTextStyles.body.copyWith(color: tokens.textMuted),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
