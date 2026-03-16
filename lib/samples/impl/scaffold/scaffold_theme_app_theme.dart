import '../../interface/sample_interface.dart';

/// Template for lib/core/theme/app_theme.dart — Material 3 ThemeData
///
/// Generates light + dark themes using ColorScheme.fromSeed() with
/// comprehensive component themes. Users can easily modify or remove
/// any component theme they don't need.
class ScaffoldThemeAppThemeSample extends Sample {
  ScaffoldThemeAppThemeSample({String? path})
      : super(path ?? 'lib/core/theme/app_theme.dart', overwrite: false);

  @override
  String get content => '''
import 'package:flutter/material.dart';

import 'theme_constants.dart';

/// App-wide Material 3 theme configuration.
///
/// Uses [ColorScheme.fromSeed] for automatic tonal palette generation.
/// Customize [_seedColor] to match your brand. All component themes
/// reference the colorScheme so light/dark mode works automatically.
class AppTheme {
  AppTheme._();

  /// Change this to your brand color — all other colors derive from it.
  static const Color _seedColor = Color(0xff6750a4);

  // ── Light Theme ──────────────────────────────────────────────────────

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    );
    return _buildTheme(colorScheme);
  }

  // ── Dark Theme ───────────────────────────────────────────────────────

  static ThemeData get dark {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    );
    return _buildTheme(colorScheme);
  }

  // ── Shared builder ───────────────────────────────────────────────────

  static ThemeData _buildTheme(ColorScheme colorScheme) {
    final textTheme = _buildTextTheme(colorScheme);

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      textTheme: textTheme,

      // ── AppBar ─────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),

      // ── Buttons ────────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.radiusMd,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.radiusMd,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          side: BorderSide(color: colorScheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.radiusMd,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.radiusMd,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: AppElevation.level2,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.radiusLg,
        ),
      ),

      // ── Card ───────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        elevation: AppElevation.level1,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.radiusMd,
        ),
      ),

      // ── Input ──────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: AppBorderRadius.radiusSm,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),

      // ── Dialog ─────────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        elevation: AppElevation.level3,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.radiusMd,
        ),
      ),

      // ── Bottom Sheet ───────────────────────────────────────────────
      bottomSheetTheme: BottomSheetThemeData(
        elevation: AppElevation.level1,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),

      // ── SnackBar ───────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.radiusSm,
        ),
      ),

      // ── Navigation Bar (M3) ────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        elevation: AppElevation.level1,
        indicatorColor: colorScheme.secondaryContainer,
        height: 80,
      ),

      // ── Bottom Navigation Bar (legacy) ─────────────────────────────
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: AppElevation.level1,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
      ),

      // ── Chip ───────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.radiusSm,
        ),
      ),

      // ── Divider ────────────────────────────────────────────────────
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: AppSpacing.lg,
      ),

      // ── ListTile ───────────────────────────────────────────────────
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.radiusSm,
        ),
      ),
    );
  }

  // ── Typography ──────────────────────────────────────────────────────
  //
  // Material 3 type scale. Modify font sizes, weights, and letter spacing
  // to match your design system. To use a custom font, add google_fonts
  // package and set fontFamily on each style or apply globally via
  // `textTheme: GoogleFonts.interTextTheme(_buildTextTheme(colorScheme))`.

  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    final color = colorScheme.onSurface;
    return TextTheme(
      // Display — large hero text
      displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400, letterSpacing: -0.25, color: color),
      displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w400, letterSpacing: 0, color: color),
      displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w400, letterSpacing: 0, color: color),
      // Headline — section headers
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0, color: color),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, letterSpacing: 0, color: color),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, letterSpacing: 0, color: color),
      // Title — card titles, app bar
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, letterSpacing: 0, color: color),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15, color: color),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, color: color),
      // Body — main content
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5, color: color),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, color: color),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, color: color),
      // Label — buttons, chips, captions
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, color: color),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5, color: color),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5, color: color),
    );
  }
}
''';
}
