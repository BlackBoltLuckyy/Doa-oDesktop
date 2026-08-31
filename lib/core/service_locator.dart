import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import 'config/app_config.dart';
import 'network/api_client.dart';
import '../data/repositories/auth_repository.dart';
import '../data/services/auth_service.dart';
import '../data/services/local_storage_service.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Infraestrutura
  final localStorageService = LocalStorageService();
  sl.registerSingleton<LocalStorageService>(localStorageService);

  final savedApiBaseUrl = await localStorageService.readApiBaseUrl();
  sl.registerSingleton<AppConfig>(
    AppConfig(
      baseUrl: savedApiBaseUrl ??
          dotenv.env['API_BASE_URL'] ??
          'http://localhost:8080',
    ),
  );

  // O token é lido do storage a cada requisição — sem estado estático no cliente.
  sl.registerSingleton<ApiClient>(
    ApiClient(
      config: sl<AppConfig>(),
      tokenProvider: sl<LocalStorageService>().readToken,
    ),
  );

  // Repositórios
  sl.registerSingleton<AuthRepository>(AuthRepository(sl<ApiClient>()));

  // Serviços
  sl.registerSingleton<AuthService>(
    AuthService(sl<AuthRepository>(), sl<LocalStorageService>()),
  );
}
