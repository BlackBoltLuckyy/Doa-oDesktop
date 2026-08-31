import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

const kThemePrefsKey = '@doemais:theme';

class ThemeNotifier extends Notifier<ThemeMode> {
  ThemeNotifier([this._initial = ThemeMode.light]);

  final ThemeMode _initial;

  @override
  ThemeMode build() => _initial;

  Future<void> toggle() async {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      kThemePrefsKey,
      state == ThemeMode.dark ? 'dark' : 'light',
    );
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);
