# Phase 2: Theme Template Samples

**Priority:** High | **Status:** Pending

## Overview
Create 3 Sample classes that generate the theme files in user's project. Follow existing Sample interface pattern.

## Key Insights
- All samples extend `Sample` base class, override `get content` to return Dart code as string
- Use `recase` for name transformations (though theme templates are mostly static)
- Templates must use `@riverpod` annotation (project requirement)
- Material 3: `ColorScheme.fromSeed()`, `useMaterial3: true`
- SharedPreferences for persistence — simple, no Freezed needed

## Requirements
- 3 template files generating production-ready Dart code
- M3 ThemeData with light+dark, component themes
- @riverpod theme notifier with SharedPreferences persistence
- Design tokens: spacing (4dp grid), border radius, elevation

## Related Code Files

### Files to Create
1. `lib/samples/impl/riverpod_clean/scaffold_theme_app_theme.dart`
2. `lib/samples/impl/riverpod_clean/scaffold_theme_provider.dart`
3. `lib/samples/impl/riverpod_clean/scaffold_theme_constants.dart`

### Reference Files (read pattern from)
- `lib/samples/interface/sample_interface.dart` — base class
- `lib/samples/impl/riverpod_clean/riverpod_provider.dart` — @riverpod pattern
- `lib/samples/impl/riverpod_clean/riverpod_page.dart` — ConsumerWidget pattern

## Implementation Steps

### Step 1: Create `scaffold_theme_app_theme.dart`
Sample that generates `lib/core/theme/app_theme.dart`:
- `AppTheme` class with static `lightTheme` and `darkTheme` getters
- `ColorScheme.fromSeed(seedColor: Color(0xff6750a4))` — configurable seed
- `useMaterial3: true`
- Typography: M3 TextTheme (displayLarge → labelSmall)
- Component themes: AppBarTheme, ElevatedButtonTheme, CardTheme, InputDecorationTheme
- Constructor takes optional `seedColor` parameter for customization

### Step 2: Create `scaffold_theme_provider.dart`
Sample that generates `lib/core/theme/theme_provider.dart`:
- Uses `@riverpod` annotation (NOT manual StateNotifierProvider)
- `ThemeNotifier` extends `_$ThemeNotifier` (code-gen pattern)
- State type: `ThemeMode`
- Methods: `setThemeMode(ThemeMode)`, `toggleDarkMode()`
- Persists to SharedPreferences
- Import `shared_preferences` and `riverpod_annotation`

### Step 3: Create `scaffold_theme_constants.dart`
Sample that generates `lib/core/theme/theme_constants.dart`:
- `abstract final class AppSpacing` — xs(4), sm(8), md(12), lg(16), xl(24), xxl(32), xxxl(48)
- Common `EdgeInsets` presets
- `abstract final class AppBorderRadius` — xs(4), sm(8), md(12), lg(16), xl(28)
- `abstract final class AppElevation` — level0-5

## Todo
- [ ] Create ScaffoldThemeAppThemeSample
- [ ] Create ScaffoldThemeProviderSample
- [ ] Create ScaffoldThemeConstantsSample
- [ ] Verify generated code compiles (manual test)
- [ ] Verify @riverpod annotation is correct

## Success Criteria
- Each Sample.create() writes valid, compilable Dart code
- Generated provider uses @riverpod code-gen pattern
- Generated theme uses ColorScheme.fromSeed() with M3
- Design tokens follow 4dp grid spacing system
