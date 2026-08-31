import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

import 'app.dart';
import 'core/service_locator.dart';
import 'core/theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await setupServiceLocator();

  if (!kIsWeb) {
    await windowManager.ensureInitialized();

    const windowOptions = WindowOptions(
      size: Size(1280, 800),
      minimumSize: Size(1024, 768),
      center: true,
      title: 'Doe+ — Sistema de Doações',
      titleBarStyle: TitleBarStyle.normal,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  final prefs = await SharedPreferences.getInstance();
  final initialThemeMode =
      prefs.getString(kThemePrefsKey) == 'dark' ? ThemeMode.dark : ThemeMode.light;

  runApp(ProviderScope(
    overrides: [
      themeProvider.overrideWith(() => ThemeNotifier(initialThemeMode)),
    ],
    child: const MyApp(),
  ));
}
