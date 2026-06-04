import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/config/app_config.dart';
import 'core/config/routes.dart';
import 'core/theme/app_theme.dart';
import 'data/services/local_storage_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LocalStorageService>(create: (_) => LocalStorageService()),
        Provider<AppConfig>(create: (_) => AppConfig(baseUrl: dotenv.env['API_BASE_URL'] ?? '')),
      ],
      child: MaterialApp.router(
        title: 'Painel ONG — Sistema de Doações',
        theme: AppTheme.lightTheme,
        routerConfig: AppRoutes.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
