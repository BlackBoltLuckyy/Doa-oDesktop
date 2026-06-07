import 'package:dio/dio.dart';

import '../../core/network/api_client.dart';
import '../../core/network/error_handler.dart';
import '../../core/utils/either.dart';
import '../models/auth_response_model.dart';

/// Responsável exclusivamente pelo transporte HTTP de autenticação.
/// Não persiste dados — apenas retorna o resultado da API.
class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<Either<String, AuthResponseModel>> login(
    String email,
    String senha,
  ) async {
    try {
      final response = await _apiClient.client.post(
        '/auth/login',
        data: {'email': email, 'senha': senha},
      );
      final auth = AuthResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      return Right(auth);
    } on DioException catch (e) {
      return Left(ErrorHandler.extractMessage(e, 'Credenciais inválidas.'));
    }
  }
}
