import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_tokens.dart';
import '../../providers/auth_provider.dart';
import '../common/confirm_dialog.dart';
import 'sidebar_item.dart';

class SidebarWidget extends ConsumerWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = context.tokens;
    final location = GoRouterState.of(context).matchedLocation;
    final user = ref.watch(authProvider).user;

    return Container(
      width: AppSpacing.sidebarWidth,
      decoration: BoxDecoration(
        color: tokens.sidebarBg,
        border: Border(right: BorderSide(color: tokens.sidebarBorder)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Marca
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.favorite, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                RichText(
                  text: TextSpan(
                    style: AppTextStyles.heading.copyWith(color: tokens.text),
                    children: const [
                      TextSpan(text: 'Doe'),
                      TextSpan(
                        text: '+',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Cartão do usuário
          if (user != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.primary, AppColors.secondary],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      user.nome.isNotEmpty ? user.nome[0].toUpperCase() : 'U',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.nome,
                          style: AppTextStyles.body.copyWith(
                            color: tokens.text,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          user.papel,
                          style: AppTextStyles.label.copyWith(color: tokens.textMuted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Divider(color: tokens.sidebarBorder, height: 1),
          ),

          // Navegação
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
            child: Divider(color: tokens.sidebarBorder, height: 1),
          ),

          SidebarItem(
            icon: Icons.settings_outlined,
            label: 'Configurações',
            isActive: location.startsWith(AppRoutes.kConfiguracoes),
            onTap: () => context.go(AppRoutes.kConfiguracoes),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.input),
              onTap: () => _onLogout(context, ref),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    const Icon(Icons.logout, size: 20, color: AppColors.secondary),
                    const SizedBox(width: 12),
                    Text(
                      'Sair',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Future<void> _onLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await ConfirmDialog.show(
      context: context,
      title: 'Encerrar sessão',
      message: 'Deseja sair do sistema?',
      confirmLabel: 'Sair',
      confirmColor: AppColors.secondary,
      icon: Icons.logout,
    );
    if (confirmed) {
      await ref.read(authProvider.notifier).logout();
    }
  }
}
