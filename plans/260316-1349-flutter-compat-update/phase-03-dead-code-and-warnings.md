# Phase 3: Fix Warnings, Dead Code, and Secondary Deps

## Overview
- **Priority:** P2
- **Status:** complete
- **Effort:** 1.5h
- **Independent:** Can run parallel with Phases 1-2
- **Completed:** 2026-03-16

## Current Analyzer Output (7 issues)

### Warning (1)
1. `lib/common/utils/pubspec/pubspec_utils.dart:146` -- unnecessary non-null assertion
   ```dart
   // Before:
   static bool get nullSafeSupport => !pubSpec.environment!['sdk']!
       .allowsAny(VersionConstraint.parse('<2.12.0'));
   // Need to check which ! is unnecessary and remove it
   ```

### Info (6) -- unnecessary_overrides
2-6. `lib/common/utils/json_serialize/json_ast/tokenize.dart` -- lines 175, 205, 254, 292, 308
7. `lib/common/utils/json_serialize/sintaxe.dart` -- line 400

## Dead Code: iOS/Android Language Menus

### Location: `lib/commands/impl/create/project/project.dart` (lines 56-66)
After PR #294, `ShellUtils.flutterCreate()` no longer uses `iosLang` and `androidLang` parameters.
But project.dart still:
1. Shows iOS language menu (Swift/Obj-C)
2. Shows Android language menu (Kotlin/Java)
3. Passes unused values to `flutterCreate()`

### Fix:
1. Remove iOS/Android language menus from `project.dart`
2. Simplify `ShellUtils.flutterCreate()` signature -- remove `iosLang`, `androidLang` params

## Secondary Dependency Updates

### pubspec.yaml changes
- `lints: ^4.0.0` → `lints: ^6.0.0` (dev dependency)
- `test: ^1.25.8` → `test: ^1.30.0` (dev dependency)

### Deprecated `flutter_lints` in project template
- `lib/commands/impl/create/project/project.dart` lines 87-88 reference `flutter_lints`
- `flutter_lints` is deprecated, replaced by `flutter_lints` → official `lints` package
- Update template to use `lints` package instead

## Files to Modify

| File | Change |
|------|--------|
| `pubspec.yaml` | Update lints and test dev_dependencies |
| `lib/common/utils/pubspec/pubspec_utils.dart` | Remove unnecessary `!` (line 146) |
| `lib/common/utils/json_serialize/json_ast/tokenize.dart` | Remove 5 unnecessary overrides |
| `lib/common/utils/json_serialize/sintaxe.dart` | Remove 1 unnecessary override |
| `lib/commands/impl/create/project/project.dart` | Remove iOS/Android lang menus, fix flutter_lints reference |
| `lib/common/utils/shell/shel.utils.dart` | Remove `iosLang`, `androidLang` params from `flutterCreate()` |

## Implementation Steps

- [x] Update `lints` and `test` in pubspec.yaml dev_dependencies
- [x] Fix the unnecessary non-null assertion in pubspec_utils.dart
- [x] Remove each unnecessary override in tokenize.dart and sintaxe.dart
- [x] Remove iOS/Android language menu code from project.dart
- [x] Replace `flutter_lints` with `lints` in project.dart template
- [x] Simplify `flutterCreate` signature in shel.utils.dart
- [x] Run `dart pub get`, `dart analyze` -- expect 0 issues
- [x] Run `dart compile exe bin/get.dart`

## Success Criteria
- `dart analyze` returns 0 issues
- No dead code for iOS/Android language selection
- `flutterCreate` has clean, minimal signature
- Secondary deps updated to latest compatible versions
- No deprecated package references in templates
