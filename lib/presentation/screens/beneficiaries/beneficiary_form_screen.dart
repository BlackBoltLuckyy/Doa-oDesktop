import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_tokens.dart';
import '../../widgets/common/app_card.dart';
import '../../widgets/common/app_text_field.dart';
import '../../widgets/common/gradient_button.dart';

class BeneficiaryFormScreen extends StatefulWidget {
  /// Null para criação, preenchido para edição.
  final String? beneficiaryId;

  const BeneficiaryFormScreen({super.key, this.beneficiaryId});

  @override
  State<BeneficiaryFormScreen> createState() => _BeneficiaryFormScreenState();
}

class _BeneficiaryFormScreenState extends State<BeneficiaryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cpfFormatter = MaskTextInputFormatter(mask: '###.###.###-##');
  final _phoneFormatter = MaskTextInputFormatter(mask: '(##) #####-####');

  bool get _isEditing => widget.beneficiaryId != null;

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isEditing
              ? 'Beneficiário atualizado com sucesso.'
              : 'Beneficiário cadastrado com sucesso.',
        ),
        backgroundColor: AppColors.statusApproved,
      ),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
              tooltip: 'Voltar',
            ),
            const SizedBox(width: 4),
            Text(
              'Beneficiários / ${_isEditing ? 'Editar' : 'Novo'}',
              style: AppTextStyles.body.copyWith(color: tokens.textMuted),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _isEditing ? 'Editar beneficiário' : 'Novo beneficiário',
          style: AppTextStyles.pageTitle.copyWith(color: tokens.text),
        ),
        const SizedBox(height: 20),

        AppCard(
          padding: const EdgeInsets.all(28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  label: 'Nome completo',
                  validator: (v) => v == null || v.trim().isEmpty ? 'Nome é obrigatório.' : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'CPF',
                        inputFormatters: [_cpfFormatter],
                        validator: (v) => v == null || v.length < 14 ? 'CPF inválido.' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppTextField(
                        label: 'Data de nascimento',
                        hintText: 'DD/MM/AAAA',
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Data é obrigatória.' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Telefone',
                  inputFormatters: [_phoneFormatter],
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Telefone é obrigatório.' : null,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Endereço completo',
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Endereço é obrigatório.' : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'Número de dependentes',
                        keyboardType: TextInputType.number,
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Número é obrigatório.' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: AppTextField(
                        label: 'Renda familiar (R\$)',
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const AppTextField(label: 'Observações sociais', maxLines: 4),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => context.pop(),
                      child: const Text('Cancelar'),
                    ),
                    const SizedBox(width: 12),
                    GradientButton(
                      label: _isEditing ? 'Salvar alterações' : 'Cadastrar beneficiário',
                      onPressed: _onSave,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
