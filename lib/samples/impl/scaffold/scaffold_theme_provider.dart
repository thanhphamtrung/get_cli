import '../../interface/sample_interface.dart';

/// Template for lib/core/theme/theme_provider.dart — @riverpod theme notifier
///
/// Generates a Riverpod notifier that toggles ThemeMode (light/dark/system)
/// and persists the choice to SharedPreferences.
class ScaffoldThemeProviderSample extends Sample {
  ScaffoldThemeProviderSample({String? path})
      : super(path ?? 'lib/core/theme/theme_provider.dart', overwrite: false);

  @override
  String get content => '''
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

/// Manages the app-wide [ThemeMode] with persistence.
///
/// Usage:
/// ```dart
/// // Read current theme mode
/// final themeMode = ref.watch(themeProvider);
///
/// // Toggle dark/light
/// ref.read(themeProvider.notifier).toggleDarkMode();
///
/// // Set specific mode
/// ref.read(themeProvider.notifier).setThemeMode(ThemeMode.dark);
/// ```
@riverpod
class ThemeNotifier extends _\$ThemeNotifier {
  static const String _themeKey = 'app_theme_mode';

  @override
  ThemeMode build() {
    // Loads persisted value async — briefly uses system default on cold start.
    // This keeps the provider synchronous (ThemeMode, not AsyncValue<ThemeMode>)
    // which simplifies consumer code. The flash is typically imperceptible.
    _loadFromPrefs();
    return ThemeMode.system;
  }

  /// Loads persisted theme mode from SharedPreferences.
  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_themeKey);
    if (index != null && index < ThemeMode.values.length) {
      state = ThemeMode.values[index];
    }
  }

  /// Sets theme mode and persists to SharedPreferences.
  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, mode.index);
  }

  /// Toggles between dark and light mode.
  Future<void> toggleDarkMode() async {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newMode);
  }
}
''';
}
