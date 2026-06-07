import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Navegação de volta
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
              style: AppTextStyles.body.copyWith(color: Colors.black54),
            ),
          ],
        ),
        const SizedBox(height: 8),

        Text(
          _isEditing ? 'Editar beneficiário' : 'Novo beneficiário',
          style: AppTextStyles.displayTitle,
        ),
        const SizedBox(height: 20),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Nome completo'),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Nome é obrigatório.' : null,
                  ),
                  const SizedBox(height: 16),

                  // Linha: CPF + Data de nascimento
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(labelText: 'CPF'),
                          inputFormatters: [_cpfFormatter],
                          validator: (v) =>
                              v == null || v.length < 14 ? 'CPF inválido.' : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Data de nascimento',
                            hintText: 'DD/MM/AAAA',
                          ),
                          validator: (v) =>
                              v == null || v.trim().isEmpty
                                  ? 'Data é obrigatória.'
                                  : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Telefone
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Telefone'),
                    inputFormatters: [_phoneFormatter],
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Telefone é obrigatório.' : null,
                  ),
                  const SizedBox(height: 16),

                  // Endereço
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Endereço completo'),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Endereço é obrigatório.' : null,
                  ),
                  const SizedBox(height: 16),

                  // Linha: Dependentes + Renda
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Número de dependentes',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (v) =>
                              v == null || v.trim().isEmpty
                                  ? 'Número é obrigatório.'
                                  : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Renda familiar (R\$)',
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Observações
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Observações sociais',
                      alignLabelWithHint: true,
                    ),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 28),

                  // Ações
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () => context.pop(),
                        child: const Text('Cancelar'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: _onSave,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,
                        ),
                        child: Text(
                          _isEditing ? 'Salvar alterações' : 'Cadastrar beneficiário',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
