import 'package:flutter/material.dart';
import 'sidebar_item.dart';
import '../../../core/theme/app_colors.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: AppColors.backgroundDark,
      child: Column(
        children: [
          const SizedBox(height: 32),
          Text('Painel ONG', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white)),
          const SizedBox(height: 24),
          SidebarItem(icon: Icons.dashboard, label: 'Dashboard', onTap: () {}),
          SidebarItem(icon: Icons.inbox, label: 'Doações', onTap: () {}),
          SidebarItem(icon: Icons.inventory, label: 'Estoque', onTap: () {}),
          SidebarItem(icon: Icons.people, label: 'Beneficiários', onTap: () {}),
          SidebarItem(icon: Icons.local_shipping, label: 'Distribuições', onTap: () {}),
          SidebarItem(icon: Icons.settings, label: 'Configurações', onTap: () {}),
        ],
      ),
    );
  }
}
