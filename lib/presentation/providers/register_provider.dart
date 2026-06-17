import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/service_locator.dart';
import '../../core/utils/either.dart';
import '../../data/services/auth_service.dart';

class RegisterState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;
  final String? successMessage;

  const RegisterState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
    this.successMessage,
  });
}

class RegisterNotifier extends StateNotifier<RegisterState> {
  final AuthService _authService;

  RegisterNotifier(this._authService) : super(const RegisterState());

  Future<void> register({
    required String nome,
    required String email,
    required String senha,
    required String papel,
  }) async {
    state = const RegisterState(isLoading: true);

    final result = await _authService.register(
      nome: nome,
      email: email,
      senha: senha,
      papel: papel,
    );

    if (result is Right<String, String>) {
      state = RegisterState(isSuccess: true, successMessage: result.value);
    } else if (result is Left<String, String>) {
      state = RegisterState(error: result.value);
    }
  }

  void reset() => state = const RegisterState();
}

final registerProvider =
    StateNotifierProvider.autoDispose<RegisterNotifier, RegisterState>((ref) {
  return RegisterNotifier(sl<AuthService>());
});
