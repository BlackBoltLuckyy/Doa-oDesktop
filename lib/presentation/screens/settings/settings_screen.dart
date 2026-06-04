import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Configurações', style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Dados da ONG'),
                  SizedBox(height: 16),
                  Text('Usuários do sistema'),
                  SizedBox(height: 16),
                  Text('Categorias de doação'),
                  SizedBox(height: 16),
                  Text('Notificações e minha conta'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
