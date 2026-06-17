import 'package:go_router/go_router.dart';

import '../../presentation/layouts/main_layout.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/beneficiaries/beneficiaries_screen.dart';
import '../../presentation/screens/beneficiaries/beneficiary_form_screen.dart';
import '../../presentation/screens/dashboard/dashboard_screen.dart';
import '../../presentation/screens/distribution/distribution_history_screen.dart';
import '../../presentation/screens/distribution/distribution_screen.dart';
import '../../presentation/screens/donations/donation_detail_screen.dart';
import '../../presentation/screens/donations/donations_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/stock/stock_entry_screen.dart';
import '../../presentation/screens/stock/stock_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const kLogin = '/login';
  static const kCadastro = '/cadastro';
  static const kDashboard = '/dashboard';
  static const kDoacoes = '/doacoes';
  static const kEstoque = '/estoque';
  static const kBeneficiarios = '/beneficiarios';
  static const kDistribuicoes = '/distribuicoes';
  static const kConfiguracoes = '/configuracoes';

  static final List<RouteBase> routes = [
    GoRoute(
      path: kLogin,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: kCadastro,
      builder: (context, state) => const RegisterScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        GoRoute(
          path: kDashboard,
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: kDoacoes,
          builder: (context, state) => const DonationsScreen(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) => DonationDetailScreen(
                donationId: state.pathParameters['id']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: kEstoque,
          builder: (context, state) => const StockScreen(),
          routes: [
            GoRoute(
              path: 'entrada',
              builder: (context, state) => const StockEntryScreen(),
            ),
          ],
        ),
        GoRoute(
          path: kBeneficiarios,
          builder: (context, state) => const BeneficiariesScreen(),
          routes: [
            GoRoute(
              path: 'novo',
              builder: (context, state) => const BeneficiaryFormScreen(),
            ),
            GoRoute(
              path: ':id/editar',
              builder: (context, state) => BeneficiaryFormScreen(
                beneficiaryId: state.pathParameters['id'],
              ),
            ),
          ],
        ),
        GoRoute(
          path: kDistribuicoes,
          builder: (context, state) => const DistributionScreen(),
          routes: [
            GoRoute(
              path: 'historico',
              builder: (context, state) => const DistributionHistoryScreen(),
            ),
          ],
        ),
        GoRoute(
          path: kConfiguracoes,
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ];
}
