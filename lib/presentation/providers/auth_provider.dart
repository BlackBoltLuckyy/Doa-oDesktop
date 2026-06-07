import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/network_events.dart';
import '../../core/service_locator.dart';
import '../../core/utils/either.dart';
import '../../data/models/auth_response_model.dart';
import '../../data/models/user_model.dart';
import '../../data/services/auth_service.dart';

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;
  final bool isInitializing;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
    this.isInitializing = true,
  });
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;
  late final StreamSubscription<void> _unauthorizedSub;

  AuthNotifier(this._authService) : super(const AuthState()) {
    _unauthorizedSub = unauthorizedStream.listen((_) => _handleUnauthorized());
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final isAuth = await _authService.isAuthenticated();
    if (isAuth) {
      final user = await _authService.getCurrentUser();
      state = AuthState(isAuthenticated: true, user: user, isInitializing: false);
    } else {
      state = const AuthState(isAuthenticated: false, isInitializing: false);
    }
  }

  /// Retorna a mensagem de erro em caso de falha, ou null em caso de sucesso.
  Future<String?> login(String email, String senha) async {
    state = const AuthState(isLoading: true, isInitializing: false);
    final result = await _authService.login(email, senha);
    if (result is Right<String, AuthResponseModel>) {
      state = AuthState(
        isAuthenticated: true,
        user: result.value.usuario,
        isInitializing: false,
      );
      return null;
    } else if (result is Left<String, AuthResponseModel>) {
      state = AuthState(
        isLoading: false,
        error: result.value,
        isInitializing: false,
      );
      return result.value;
    }
    return null;
  }

  Future<void> logout() async {
    await _authService.logout();
    state = const AuthState(isAuthenticated: false, isInitializing: false);
  }

  void _handleUnauthorized() {
    _authService.logout();
    state = const AuthState(isAuthenticated: false, isInitializing: false);
  }

  @override
  void dispose() {
    _unauthorizedSub.cancel();
    super.dispose();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(sl<AuthService>());
});
