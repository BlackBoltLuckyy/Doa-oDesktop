import 'package:go_router/go_router.dart';

import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/dashboard/dashboard_screen.dart';
import '../../presentation/layouts/main_layout.dart';

class AppRoutes {
  static const kLogin = '/login';
  static const kDashboard = '/dashboard';

  static final router = GoRouter(
    initialLocation: kLogin,
    routes: [
      GoRoute(
        path: kLogin,
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainLayout(child: child),
        routes: [
          GoRoute(
            path: kDashboard,
            builder: (context, state) => const DashboardScreen(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final loggedIn = false; // Guard temporário
      final loggingIn = state.location == kLogin;
      if (!loggedIn && !loggingIn) return kLogin;
      if (loggedIn && loggingIn) return kDashboard;
      return null;
    },
  );
}
