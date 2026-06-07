import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../widgets/common/confirm_dialog.dart';
import '../../widgets/common/status_badge.dart';

class DonationDetailScreen extends StatelessWidget {
  final String donationId;

  const DonationDetailScreen({super.key, required this.donationId});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Navegação de volta
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
              tooltip: 'Voltar para doações',
            ),
            const SizedBox(width: 4),
            Text(
              'Doações / Detalhe #$donationId',
              style: AppTextStyles.body.copyWith(color: Colors.black54),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Conteúdo principal
        Card(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Casacos e roupas infantis',
                            style: AppTextStyles.displayTitle,
                          ),
                          const SizedBox(height: 10),
                          const StatusBadge(status: 'PENDENTE'),
                        ],
                      ),
                    ),
                    _ActionButtons(donationId: donationId),
                  ],
                ),
                const SizedBox(height: 28),

                const Divider(color: AppColors.borderColor),
                const SizedBox(height: 20),

                // Dados do doador
                Text('Dados do doador', style: AppTextStyles.heading),
                const SizedBox(height: 14),
                _InfoRow(label: 'Nome', value: 'José Pereira'),
                _InfoRow(label: 'Telefone', value: '(11) 99999-9999'),
                _InfoRow(label: 'Endereço', value: 'Rua das Flores, 123 — São Paulo/SP'),
                const SizedBox(height: 20),

                // Descrição
                Text('Descrição do item', style: AppTextStyles.heading),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Text(
                    'Pacote com 10 casacos de inverno e 5 peças de roupas infantis em bom estado. '
                    'Tamanhos variados entre 2 e 8 anos.',
                    style: AppTextStyles.body,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final String donationId;

  const _ActionButtons({required this.donationId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: () => _onApprove(context),
          icon: const Icon(Icons.check, size: 18, color: Colors.white),
          label: const Text('Aprovar', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.statusApproved,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: () => _onReject(context),
          icon: const Icon(Icons.close, size: 18, color: Colors.white),
          label: const Text('Recusar', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.statusRejected,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Future<void> _onApprove(BuildContext context) async {
    final confirmed = await ConfirmDialog.show(
      context: context,
      title: 'Aprovar doação',
      message: 'Confirmar a aprovação desta doação?',
      confirmLabel: 'Aprovar',
      confirmColor: AppColors.statusApproved,
    );
    if (confirmed && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Doação aprovada com sucesso.'),
          backgroundColor: AppColors.statusApproved,
        ),
      );
    }
  }

  Future<void> _onReject(BuildContext context) async {
    final confirmed = await ConfirmDialog.show(
      context: context,
      title: 'Recusar doação',
      message: 'Confirmar a recusa desta doação?',
      confirmLabel: 'Recusar',
      confirmColor: AppColors.statusRejected,
    );
    if (confirmed && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Doação recusada.'),
          backgroundColor: AppColors.statusRejected,
        ),
      );
    }
  }
}
