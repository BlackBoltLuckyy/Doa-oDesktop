import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'sidebar_item.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    return Container(
      width: 240,
      color: AppColors.backgroundDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(Icons.favorite, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  'Painel ONG',
                  style: AppTextStyles.heading.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Divisor
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Divider(color: Colors.white.withOpacity(0.1), height: 1),
          ),

          // Itens de navegação
          SidebarItem(
            icon: Icons.dashboard_outlined,
            label: 'Dashboard',
            isActive: location.startsWith(AppRoutes.kDashboard),
            onTap: () => context.go(AppRoutes.kDashboard),
          ),
          SidebarItem(
            icon: Icons.inbox_outlined,
            label: 'Doações',
            isActive: location.startsWith(AppRoutes.kDoacoes),
            onTap: () => context.go(AppRoutes.kDoacoes),
          ),
          SidebarItem(
            icon: Icons.inventory_2_outlined,
            label: 'Estoque',
            isActive: location.startsWith(AppRoutes.kEstoque),
            onTap: () => context.go(AppRoutes.kEstoque),
          ),
          SidebarItem(
            icon: Icons.people_outline,
            label: 'Beneficiários',
            isActive: location.startsWith(AppRoutes.kBeneficiarios),
            onTap: () => context.go(AppRoutes.kBeneficiarios),
          ),
          SidebarItem(
            icon: Icons.local_shipping_outlined,
            label: 'Distribuições',
            isActive: location.startsWith(AppRoutes.kDistribuicoes),
            onTap: () => context.go(AppRoutes.kDistribuicoes),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Divider(color: Colors.white.withOpacity(0.1), height: 1),
          ),

          SidebarItem(
            icon: Icons.settings_outlined,
            label: 'Configurações',
            isActive: location.startsWith(AppRoutes.kConfiguracoes),
            onTap: () => context.go(AppRoutes.kConfiguracoes),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
