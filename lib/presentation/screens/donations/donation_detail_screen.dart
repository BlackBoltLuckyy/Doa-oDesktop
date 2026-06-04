import 'package:flutter/material.dart';

import '../../widgets/common/status_badge.dart';

class DonationDetailScreen extends StatelessWidget {
  const DonationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhe da doação')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Casacos e roupas infantis', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const StatusBadge(status: 'PENDENTE'),
            const SizedBox(height: 24),
            const Text('Doador: José Pereira'),
            const Text('Telefone: (11) 99999-9999'),
            const Text('Endereço: Rua das Flores, 123, São Paulo'),
            const SizedBox(height: 24),
            const Text('Descrição:', style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('Pacote com 10 casacos e 5 peças de roupas infantis em bom estado.'),
            const SizedBox(height: 24),
            Row(
              children: [
                ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: const Text('Aprovar doação')),
                const SizedBox(width: 12),
                ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text('Recusar doação')),
                const SizedBox(width: 12),
                OutlinedButton(onPressed: () {}, child: const Text('Registrar entrada no estoque')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
