import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_tokens.dart';
import '../../widgets/common/app_card.dart';
import '../../widgets/common/app_text_field.dart';
import '../../widgets/common/gradient_button.dart';

class StockEntryScreen extends StatefulWidget {
  const StockEntryScreen({super.key});

  @override
  State<StockEntryScreen> createState() => _StockEntryScreenState();
}

class _StockEntryScreenState extends State<StockEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitController = TextEditingController();
  final _categoryController = TextEditingController();
  final _observationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    _categoryController.dispose();
    _observationController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Entrada de estoque registrada com sucesso.'),
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
              tooltip: 'Voltar para estoque',
            ),
            const SizedBox(width: 4),
            Text(
              'Estoque / Nova entrada',
              style: AppTextStyles.body.copyWith(color: tokens.textMuted),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text('Nova entrada de estoque', style: AppTextStyles.pageTitle.copyWith(color: tokens.text)),
        const SizedBox(height: 20),

        AppCard(
          padding: const EdgeInsets.all(28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  label: 'Nome do item',
                  controller: _nameController,
                  validator: (v) => v == null || v.trim().isEmpty ? 'Nome é obrigatório.' : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'Categoria',
                        controller: _categoryController,
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Categoria é obrigatória.' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppTextField(
                        label: 'Unidade (ex: kg, un, caixa)',
                        controller: _unitController,
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Unidade é obrigatória.' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppTextField(
                        label: 'Quantidade',
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Quantidade é obrigatória.';
                          if (int.tryParse(v.trim()) == null) return 'Valor inválido.';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Observação',
                  controller: _observationController,
                  maxLines: 3,
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => context.pop(),
                      child: const Text('Cancelar'),
                    ),
                    const SizedBox(width: 12),
                    GradientButton(label: 'Registrar entrada', onPressed: _onSubmit),
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
