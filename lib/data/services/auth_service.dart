import '../../core/utils/either.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import 'local_storage_service.dart';

/// Orquestra o fluxo de autenticação: chama o repositório HTTP e persiste
/// o token e os dados do usuário no armazenamento local.
class AuthService {
  final AuthRepository _repository;
  final LocalStorageService _storage;

  AuthService(this._repository, this._storage);

  Future<Either<String, AuthResponseModel>> login(
    String email,
    String senha,
  ) async {
    final result = await _repository.login(email, senha);
    if (result is Right<String, AuthResponseModel>) {
      await _storage.saveToken(result.value.token);
      await _storage.saveUser(result.value.usuario);
    }
    return result;
  }

  Future<void> logout() async {
    await _storage.clearAll();
  }

  Future<bool> isAuthenticated() async {
    final token = await _storage.readToken();
    return token != null && token.isNotEmpty;
  }

  Future<UserModel?> getCurrentUser() => _storage.readUser();
}
