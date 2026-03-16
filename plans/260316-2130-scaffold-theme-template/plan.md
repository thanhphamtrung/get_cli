---
status: pending
---

# Plan: `dex scaffold theme` Command

## Overview
Add a `dex scaffold` command with an interactive wizard. First template: **Theme** — generates Material 3 theme setup with Riverpod dark/light toggle and design tokens.

**No Clean Architecture layers.** Theme is a UI concern — 3 files in `lib/core/theme/`, plus wiring into MaterialApp.

## Phases

| # | Phase | Status | Files Changed |
|---|-------|--------|---------------|
| 1 | [Scaffold command infrastructure](phase-01-scaffold-command.md) | complete | 4 CLI files |
| 2 | [Theme template samples](phase-02-theme-samples.md) | complete | 3 sample files + barrel |
| 3 | [Theme scaffold execution](phase-03-theme-scaffold-execution.md) | complete | command + init + main sample |
| 4 | [Testing & docs](phase-04-testing-docs.md) | complete | README updated, help auto-discovered |

## What Gets Generated (User's Project)

```
lib/core/theme/
├── app_theme.dart           # ThemeData light+dark, ColorScheme.fromSeed, component themes
├── theme_provider.dart      # @riverpod notifier: toggle ThemeMode + persist SharedPreferences
└── theme_constants.dart     # AppSpacing, AppBorderRadius, AppElevation design tokens
```

Plus modifies `lib/main.dart` — wires `themeMode`, `theme`, `darkTheme` into MaterialApp.router.

## Key Decisions
- **No data/domain layers** — YAGNI, theme is a UI concern
- **No Freezed entity** — persisting a ThemeMode enum, not a complex object
- **@riverpod for provider** — consistent with existing Dex CLI patterns
- **SharedPreferences** — auto-added to pubspec.yaml via `flutter pub add`
- **Material 3 only** — `useMaterial3: true`, `ColorScheme.fromSeed()`
- **Interactive wizard** — `dex scaffold` shows menu, `dex scaffold theme` skips menu

## Dependencies
- Existing: dcli (prompts), recase (naming)
- User project: shared_preferences (auto-installed)

## Research
- [Flutter M3 theme patterns](../reports/researcher-260316-2130-flutter-m3-theme-patterns.md)
- [Brainstorm report](../reports/brainstorm-260316-2111-scaffold-feature-templates.md)
