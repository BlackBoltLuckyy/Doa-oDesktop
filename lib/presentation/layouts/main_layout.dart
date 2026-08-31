import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/theme/theme_controller.dart';
import '../widgets/sidebar/sidebar_widget.dart';

const _routeTitles = {
  AppRoutes.kDashboard: 'Dashboard',
  AppRoutes.kDoacoes: 'Doações',
  AppRoutes.kEstoque: 'Estoque',
  AppRoutes.kBeneficiarios: 'Beneficiários',
  AppRoutes.kDistribuicoes: 'Distribuições',
  AppRoutes.kConfiguracoes: 'Configurações',
};

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Scaffold(
      backgroundColor: tokens.bg,
      body: Container(
        decoration: tokens.dashboardGradient != null
            ? BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: tokens.dashboardGradient!,
                ),
              )
            : null,
        child: Row(
          children: [
            const SidebarWidget(),
            Expanded(
              child: Column(
                children: [
                  const _TopBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(AppSpacing.pagePadding),
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends ConsumerWidget {
  const _TopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = context.tokens;
    final location = GoRouterState.of(context).matchedLocation;
    final themeMode = ref.watch(themeProvider);

    String title = 'Doe+';
    for (final entry in _routeTitles.entries) {
      if (location.startsWith(entry.key)) {
        title = entry.value;
        break;
      }
    }

    return Container(
      height: AppSpacing.topbarHeight,
      decoration: BoxDecoration(
        color: tokens.topbarBg,
        border: Border(bottom: BorderSide(color: tokens.border)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Text(title, style: AppTextStyles.heading.copyWith(color: tokens.text)),
          const Spacer(),
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            ),
            tooltip: themeMode == ThemeMode.dark ? 'Modo claro' : 'Modo escuro',
            onPressed: () => ref.read(themeProvider.notifier).toggle(),
          ),
          const SizedBox(width: 4),
          Stack(
            clipBehavior: Clip.none,
            children: [
              const IconButton(
                icon: Icon(Icons.notifications_outlined),
                onPressed: null,
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
