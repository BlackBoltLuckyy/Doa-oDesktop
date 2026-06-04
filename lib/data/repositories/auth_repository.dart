import 'package:dio/dio.dart';

import '../../core/config/app_config.dart';
import '../../core/network/api_client.dart';
import '../../core/utils/either.dart';
import '../models/user_model.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(AppConfig config, String? token)
      : _apiClient = ApiClient(config, token);

  Future<Either<String, UserModel>> login(String email, String senha) async {
    try {
      final response = await _apiClient.client.post('/auth/login', data: {
        'email': email,
        'senha': senha,
      });
      final data = response.data as Map<String, dynamic>;
      final usuario = UserModel.fromJson(data['usuario'] as Map<String, dynamic>);
      return Right(usuario);
    } on DioException catch (e) {
      final message = e.error?.toString() ?? 'Erro na autenticação';
      return Left(message);
    }
  }
}
