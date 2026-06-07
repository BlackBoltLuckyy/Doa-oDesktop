import 'package:flutter/material.dart';

class DistributionScreen extends StatefulWidget {
  const DistributionScreen({super.key});

  @override
  State<DistributionScreen> createState() => _DistributionScreenState();
}

class _DistributionScreenState extends State<DistributionScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nova distribuição', style: Theme.of(context).textTheme.displayLarge),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Selecione o beneficiário'),
                const SizedBox(height: 12),
                TextField(decoration: const InputDecoration(hintText: 'Buscar por nome ou CPF')),
                const SizedBox(height: 24),
                const Text('Itens disponíveis'),
                const SizedBox(height: 12),
                const Text('Aqui será exibida lista de itens para distribuição.'),
                const SizedBox(height: 24),
                ElevatedButton(onPressed: () {}, child: const Text('Confirmar distribuição')),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
