import 'package:flutter/material.dart';

class DistributionHistoryScreen extends StatelessWidget {
  const DistributionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Histórico de distribuições', style: Theme.of(context).textTheme.displayLarge),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Filtro por data, beneficiário ou operador'),
                SizedBox(height: 16),
                Text('Tabela de histórico aparecerá aqui.'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
