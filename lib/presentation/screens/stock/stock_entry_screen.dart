import 'package:flutter/material.dart';

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

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Entrada de estoque registrada.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entrada de estoque')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome do item'),
                validator: (value) => value?.isEmpty == true ? 'Nome é obrigatório.' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Categoria'),
                validator: (value) => value?.isEmpty == true ? 'Categoria é obrigatória.' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
                validator: (value) => value?.isEmpty == true ? 'Quantidade é obrigatória.' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _unitController,
                decoration: const InputDecoration(labelText: 'Unidade'),
                validator: (value) => value?.isEmpty == true ? 'Unidade é obrigatória.' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _observationController,
                decoration: const InputDecoration(labelText: 'Observação'),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _onSubmit, child: const Text('Registrar entrada')),
            ],
          ),
        ),
      ),
    );
  }
}
