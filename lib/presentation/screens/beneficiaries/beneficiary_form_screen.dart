import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class BeneficiaryFormScreen extends StatefulWidget {
  const BeneficiaryFormScreen({super.key});

  @override
  State<BeneficiaryFormScreen> createState() => _BeneficiaryFormScreenState();
}

class _BeneficiaryFormScreenState extends State<BeneficiaryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cpfFormatter = MaskTextInputFormatter(mask: '###.###.###-##');
  final _phoneFormatter = MaskTextInputFormatter(mask: '(##) #####-####');

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Beneficiário salvo com sucesso.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de beneficiário')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(decoration: const InputDecoration(labelText: 'Nome completo'), validator: (value) => value?.isEmpty == true ? 'Nome é obrigatório.' : null),
              const SizedBox(height: 16),
              TextFormField(decoration: const InputDecoration(labelText: 'CPF'), inputFormatters: [_cpfFormatter], validator: (value) => value?.length != 14 ? 'CPF inválido.' : null),
              const SizedBox(height: 16),
              TextFormField(decoration: const InputDecoration(labelText: 'Data de nascimento'), validator: (value) => value?.isEmpty == true ? 'Data é obrigatória.' : null),
              const SizedBox(height: 16),
              TextFormField(decoration: const InputDecoration(labelText: 'Telefone'), inputFormatters: [_phoneFormatter], validator: (value) => value?.isEmpty == true ? 'Telefone é obrigatório.' : null),
              const SizedBox(height: 16),
              TextFormField(decoration: const InputDecoration(labelText: 'Endereço completo'), validator: (value) => value?.isEmpty == true ? 'Endereço é obrigatório.' : null),
              const SizedBox(height: 16),
              TextFormField(decoration: const InputDecoration(labelText: 'Número de dependentes'), keyboardType: TextInputType.number, validator: (value) => value?.isEmpty == true ? 'Número é obrigatório.' : null),
              const SizedBox(height: 16),
              TextFormField(decoration: const InputDecoration(labelText: 'Renda familiar aproximada'), keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              TextFormField(decoration: const InputDecoration(labelText: 'Observações sociais'), maxLines: 4),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _onSave, child: const Text('Salvar beneficiário')),
            ],
          ),
        ),
      ),
    );
  }
}
