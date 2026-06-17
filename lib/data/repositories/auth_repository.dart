import '../../core/network/api_client.dart';
import '../../core/utils/either.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';

// MODO PROTÓTIPO: autenticação local sem backend.
// Credenciais aceitas: admin@ong.com / admin123
class AuthRepository {
  // ignore: unused_field
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  static const _mockEmail = 'admin@ong.com';
  static const _mockSenha = 'admin123';

  Future<Either<String, AuthResponseModel>> login(
    String email,
    String senha,
  ) async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (email.trim().toLowerCase() == _mockEmail && senha == _mockSenha) {
      return Right(AuthResponseModel(
        token: 'mock-token-prototipo',
        usuario: UserModel(
          id: 1,
          nome: 'Administrador',
          email: _mockEmail,
          papel: 'ADMIN',
        ),
      ));
    }
    return const Left('E-mail ou senha incorretos. Use admin@ong.com / admin123');
  }

  Future<Either<String, String>> register({
    required String nome,
    required String email,
    required String senha,
    required String papel,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return const Right('Conta criada com sucesso! (modo protótipo)');
  }
}
