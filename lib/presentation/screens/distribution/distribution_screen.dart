import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_tokens.dart';
import '../../widgets/common/app_card.dart';
import '../../widgets/common/app_text_field.dart';
import '../../widgets/common/gradient_button.dart';
import '../../widgets/common/page_header.dart';

class DistributionScreen extends StatefulWidget {
  const DistributionScreen({super.key});

  @override
  State<DistributionScreen> createState() => _DistributionScreenState();
}

class _DistributionScreenState extends State<DistributionScreen> {
  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageHeader(
          title: 'Nova distribuição',
          subtitle: 'Registre a entrega de itens a um beneficiário.',
        ),
        const SizedBox(height: 24),
        AppCard(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selecione o beneficiário',
                style: AppTextStyles.heading.copyWith(color: tokens.text),
              ),
              const SizedBox(height: 12),
              AppSearchField(
                hintText: 'Buscar por nome ou CPF',
                onChanged: (_) {},
              ),
              const SizedBox(height: 24),
              Text(
                'Itens disponíveis',
                style: AppTextStyles.heading.copyWith(color: tokens.text),
              ),
              const SizedBox(height: 12),
              Text(
                'Aqui será exibida lista de itens para distribuição.',
                style: AppTextStyles.body.copyWith(color: tokens.textMuted),
              ),
              const SizedBox(height: 24),
              GradientButton(label: 'Confirmar distribuição', onPressed: () {}),
            ],
          ),
        ),
      ],
    );
  }
}
