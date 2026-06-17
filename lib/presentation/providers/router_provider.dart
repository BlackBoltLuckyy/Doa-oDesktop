import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/routes.dart';
import 'auth_provider.dart';

/// Bridge entre o [AuthNotifier] (Riverpod) e o [GoRouter] (refreshListenable).
/// Notifica o GoRouter sempre que o estado de autenticação muda.
class RouterChangeNotifier extends ChangeNotifier {
  RouterChangeNotifier(Ref ref) {
    ref.listen<AuthState>(authProvider, (_, __) {
      notifyListeners();
    });
  }
}

final routerChangeNotifierProvider =
    ChangeNotifierProvider<RouterChangeNotifier>((ref) {
  return RouterChangeNotifier(ref);
});

final goRouterProvider = Provider<GoRouter>((ref) {
  // ref.read intencional: o router é criado uma única vez.
  // O refreshListenable cuida das reavaliações de redirect.
  final notifier = ref.read(routerChangeNotifierProvider.notifier);

  return GoRouter(
    initialLocation: AppRoutes.kLogin,
    refreshListenable: notifier,
    redirect: (context, state) {
      final authState = ref.read(authProvider);

      // Aguarda o check inicial de token antes de redirecionar.
      if (authState.isInitializing) return null;

      final isAuthenticated = authState.isAuthenticated;
      final loc = state.matchedLocation;
      final isPublicPage =
          loc == AppRoutes.kLogin || loc == AppRoutes.kCadastro;

      if (!isAuthenticated && !isPublicPage) return AppRoutes.kLogin;
      if (isAuthenticated && isPublicPage) return AppRoutes.kDashboard;
      return null;
    },
    routes: AppRoutes.routes,
  );
});
