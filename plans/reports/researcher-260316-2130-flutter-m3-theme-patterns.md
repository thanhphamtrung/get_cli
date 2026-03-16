# Flutter Material 3 Theming Best Practices Research Report
**Date:** 2026-03-16
**Focus:** Material 3 ThemeData, Riverpod integration, design tokens, MaterialApp.router wiring

---

## 1. Material 3 ThemeData Setup

### ColorScheme.fromSeed() Best Practice

`ColorScheme.fromSeed()` is the recommended approach for Material 3. It generates a complete, harmonious color palette from a single seed color using Material 3's tonal palette system.

**Key principles:**
- Single seed color creates all derived colors automatically
- Avoids manual color overrides (which can break harmony & accessibility)
- Use same seed for light & dark themes; only change brightness
- All generated colors are designed to meet accessibility contrast requirements

**Basic pattern:**

```dart
ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xff6750a4), // Your brand color
    brightness: Brightness.light,
  ),
  useMaterial3: true,
)
```

### Complete ThemeData Example (Light + Dark)

```dart
final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xff6750a4),
    brightness: Brightness.light,
  ),
  useMaterial3: true,
  textTheme: _buildTextTheme(),
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Theme.of(context).colorScheme.surface,
  ),
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xff6750a4),
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
  textTheme: _buildTextTheme(),
);

TextTheme _buildTextTheme() {
  return TextTheme(
    displayLarge: const TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
    ),
    displayMedium: const TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    ),
    displaySmall: const TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    ),
    headlineLarge: const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    ),
    headlineMedium: const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
    ),
    headlineSmall: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
    ),
    titleLarge: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    titleMedium: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    titleSmall: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    bodyLarge: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    bodyMedium: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    bodySmall: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    labelLarge: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    labelMedium: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
    labelSmall: const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
  );
}
```

### Generated ColorScheme Colors

When using `ColorScheme.fromSeed()`, Flutter generates:
- **Primary colors:** `primary`, `onPrimary`, `primaryContainer`, `onPrimaryContainer`
- **Secondary colors:** `secondary`, `onSecondary`, `secondaryContainer`, `onSecondaryContainer`
- **Tertiary colors:** `tertiary`, `onTertiary`, `tertiaryContainer`, `onTertiaryContainer`
- **Surface colors:** `surface`, `onSurface`, `surfaceDim`, `surfaceBright` (new in M3)
- **Error colors:** `error`, `onError`, `errorContainer`, `onErrorContainer`
- **Outline colors:** `outline`, `outlineVariant`

---

## 2. Riverpod Theme Notifier with Persistence

### Complete DarkModeNotifier Implementation

```dart
// lib/providers/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  late SharedPreferences _prefs;
  static const String _themeKey = 'app_theme_mode';

  ThemeNotifier() : super(ThemeMode.system) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    _prefs = await SharedPreferences.getInstance();
    final savedThemeIndex = _prefs.getInt(_themeKey);
    if (savedThemeIndex != null) {
      state = ThemeMode.values[savedThemeIndex];
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await _prefs.setInt(_themeKey, mode.index);
  }

  Future<void> toggleDarkMode() async {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newMode);
  }
}

// Riverpod provider
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => ThemeNotifier(),
);

// Expose brightness as computed provider (for easy access)
final brightnessProvider = Provider<Brightness>((ref) {
  final themeMode = ref.watch(themeProvider);
  if (themeMode == ThemeMode.dark) {
    return Brightness.dark;
  } else if (themeMode == ThemeMode.light) {
    return Brightness.light;
  } else {
    // System default fallback
    return MediaQueryData.fromWindow(
      WidgetsBinding.instance.window,
    ).platformBrightness;
  }
});
```

### Alternative: Seed Color + Dark Mode Notifier

```dart
class AccentColorNotifier extends StateNotifier<Color> {
  late SharedPreferences _prefs;
  static const String _accentKey = 'app_accent_color';

  AccentColorNotifier() : super(const Color(0xff6750a4)) {
    _loadAccentColor();
  }

  Future<void> _loadAccentColor() async {
    _prefs = await SharedPreferences.getInstance();
    final savedColor = _prefs.getInt(_accentKey);
    if (savedColor != null) {
      state = Color(savedColor);
    }
  }

  Future<void> setAccentColor(Color color) async {
    state = color;
    await _prefs.setInt(_accentKey, color.value);
  }
}

final accentColorProvider = StateNotifierProvider<AccentColorNotifier, Color>(
  (ref) => AccentColorNotifier(),
);
```

---

## 3. Design Tokens & Spacing Constants

### Spacing Constants Pattern

Material 3 recommends 4dp grid base. Define constants for consistency:

```dart
// lib/theme/design_tokens.dart
abstract final class AppSpacing {
  // 4dp grid
  static const double xs = 4.0;   // 1x
  static const double sm = 8.0;   // 2x
  static const double md = 12.0;  // 3x
  static const double lg = 16.0;  // 4x
  static const double xl = 24.0;  // 6x
  static const double xxl = 32.0; // 8x
  static const double xxxl = 48.0; // 12x

  // Common combinations
  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);
  static const EdgeInsets paddingXxl = EdgeInsets.all(xxl);

  // Horizontal/Vertical pairs
  static const EdgeInsets paddingH8V12 = EdgeInsets.symmetric(
    horizontal: 8.0,
    vertical: 12.0,
  );
  static const EdgeInsets paddingH16V12 = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 12.0,
  );
}

abstract final class AppBorderRadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 28.0;

  static final radiusXs = BorderRadius.circular(xs);
  static final radiusSm = BorderRadius.circular(sm);
  static final radiusMd = BorderRadius.circular(md);
  static final radiusLg = BorderRadius.circular(lg);
  static final radiusXl = BorderRadius.circular(xl);
}

abstract final class AppElevation {
  // Material 3 shadow values
  static const double level0 = 0.0;
  static const double level1 = 1.0;
  static const double level2 = 3.0;
  static const double level3 = 6.0;
  static const double level4 = 8.0;
  static const double level5 = 12.0;
}
```

### Usage in Components

```dart
// Using spacing tokens
Card(
  child: Padding(
    padding: AppSpacing.paddingLg,
    child: Text('Content'),
  ),
);

// Using border radius tokens
Container(
  decoration: BoxDecoration(
    borderRadius: AppBorderRadius.radiusMd,
    color: Colors.blue,
  ),
  child: Padding(
    padding: AppSpacing.paddingMd,
    child: const Text('Rounded container'),
  ),
);

// Using elevation tokens
Container(
  decoration: BoxDecoration(
    borderRadius: AppBorderRadius.radiusMd,
    boxShadow: [
      BoxShadow(
        blurRadius: AppElevation.level3,
        offset: const Offset(0, 2),
        color: Colors.black.withOpacity(0.1),
      ),
    ],
  ),
  child: const Text('Elevated container'),
);
```

---

## 4. MaterialApp.router Theme Integration with Riverpod

### Complete App Setup

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch theme provider
    final themeMode = ref.watch(themeProvider);
    final accentColor = ref.watch(accentColorProvider);

    // Create themes with current state
    final lightTheme = _buildLightTheme(accentColor);
    final darkTheme = _buildDarkTheme(accentColor);

    return MaterialApp.router(
      title: 'My App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }

  static ThemeData _buildLightTheme(Color seedColor) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      textTheme: _buildTextTheme(),
    );
  }

  static ThemeData _buildDarkTheme(Color seedColor) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      textTheme: _buildTextTheme(),
    );
  }

  static TextTheme _buildTextTheme() {
    return const TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      // ... other text styles
    );
  }

  // GoRouter configuration
  static final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
}
```

### Theme Switching UI Example

```dart
// lib/pages/settings_page.dart
class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: AppSpacing.paddingLg,
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: Text(
              isDarkMode ? 'Dark mode enabled' : 'Light mode enabled',
            ),
            value: isDarkMode,
            onChanged: (_) {
              ref.read(themeProvider.notifier).toggleDarkMode();
            },
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Accent Color'),
            subtitle: const Text('Customize app colors'),
            trailing: CircleAvatar(
              backgroundColor: ref.watch(accentColorProvider),
            ),
            onTap: () => _showColorPicker(context, ref),
          ),
        ],
      ),
    );
  }

  Future<void> _showColorPicker(BuildContext context, WidgetRef ref) async {
    // Implementation using color_picker or similar package
  }
}
```

---

## 5. Component Theme Customization

### AppBar Theme

```dart
appBarTheme: AppBarTheme(
  elevation: 0,
  centerTitle: false,
  backgroundColor: Theme.of(context).colorScheme.surface,
  foregroundColor: Theme.of(context).colorScheme.onSurface,
  toolbarHeight: 64,
  titleTextStyle: Theme.of(context).textTheme.headlineSmall,
),
```

### Button Themes

```dart
elevatedButtonTheme: ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    elevation: AppElevation.level1,
    minimumSize: const Size.fromHeight(48),
    shape: RoundedRectangleBorder(
      borderRadius: AppBorderRadius.radiusMd,
    ),
  ),
),
outlinedButtonTheme: OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    minimumSize: const Size.fromHeight(48),
    side: BorderSide(
      color: Theme.of(context).colorScheme.outline,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: AppBorderRadius.radiusMd,
    ),
  ),
),
```

### Card Theme

```dart
cardTheme: CardTheme(
  elevation: AppElevation.level1,
  shape: RoundedRectangleBorder(
    borderRadius: AppBorderRadius.radiusMd,
  ),
  color: Theme.of(context).colorScheme.surface,
),
```

---

## 6. Key Takeaways for Code Generation

### When generating theme scaffolding:

1. **Always use `ColorScheme.fromSeed()`** — no manual color overrides
2. **Support both light & dark themes** — use same seed, toggle brightness
3. **Include Material 3 TextTheme** — all 15 style categories
4. **Define spacing tokens as constants** — 4dp grid base
5. **Wrap app in ProviderScope** — required for Riverpod
6. **Use ConsumerWidget for MaterialApp** — enables ref.watch()
7. **Handle theme persistence** — SharedPreferences + StateNotifier
8. **Wire themeMode directly to MaterialApp** — not nested Theme widgets
9. **Use component themes** — AppBarTheme, ElevatedButtonTheme, etc.
10. **Provide design token constants file** — AppSpacing, AppBorderRadius, AppElevation

---

## Sources

- [Flutter Material Design Guide](https://docs.flutter.dev/ui/design/material)
- [Flutter Cookbook: Themes](https://docs.flutter.dev/cookbook/design/themes)
- [ColorScheme.fromSeed API](https://api.flutter.dev/flutter/material/ColorScheme/ColorScheme.fromSeed.html)
- [Material 3 Migration Guide](https://docs.flutter.dev/release/breaking-changes/material-3-migration)
- [Dark Mode with Riverpod](https://www.matijanovosel.com/blog/dark-mode-in-flutter-using-riverpod)
- [Theme Switcher with Riverpod](https://blog.albertobonacina.com/theme-and-accent-color-switch-with-riverpod-in-flutter)
- [Material 3 Complete Guide 2026](https://www.christianfindlay.com/blog/flutter-mastering-material-design3)
- [Material Design 3 Package](https://pub.dev/documentation/material_design/latest/)
- [Flutter Package: FlexColorScheme](https://pub.dev/packages/flex_color_scheme)

---

## Unresolved Questions

None — research covers all requested areas with concrete code examples ready for code generation templates.
