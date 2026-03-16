# Phase 1: Upgrade dart_style to 3.x

## Overview
- **Priority:** P1 (blocks other phases)
- **Status:** complete
- **Effort:** 1.5h
- **Completed:** 2026-03-16

## Context
- Current: `dart_style: ">=2.3.6 <3.0.0"` resolving to 2.3.6
- Target: `dart_style: ">=3.0.0 <4.0.0"` resolving to 3.1.7
- dart_style 3.x requires Dart SDK ^3.9.0 but we want to keep SDK >=3.0.0
- **Solution:** Bump minimum SDK to >=3.11.0 (latest stable Dart, aligns with current Flutter 3.41.4)

## Breaking Change
`DartFormatter()` no-arg constructor removed in 3.0.0. Now requires a language version parameter.

**Migration:** `DartFormatter()` -> `DartFormatter(languageVersion: DartFormatter.latestLanguageVersion)`

This tells the formatter to use latest language rules. A `// @dart=` comment in source overrides this.

## Files to Modify

### 1. `pubspec.yaml`
- Change SDK constraint: `">=3.0.0 <4.0.0"` -> `">=3.11.0 <4.0.0"`
- Change dart_style: `">=2.3.6 <3.0.0"` -> `">=3.0.0 <4.0.0"`

### 2. `lib/functions/formatter_dart_file/frommatter_dart_file.dart`
```dart
// Before:
var formatter = DartFormatter();

// After:
var formatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);
```

### 3. `lib/common/utils/json_serialize/model_generator.dart` (line 182)
```dart
// Before:
final formatter = DartFormatter();

// After:
final formatter = DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);
```

## Implementation Steps
- [x] Update `pubspec.yaml` SDK and dart_style constraints
- [x] Update `DartFormatter()` calls in both files
- [x] Run `dart pub get` to verify resolution
- [x] Run `dart analyze` to verify no new warnings
- [x] Run `dart compile exe bin/get.dart` to verify compilation

## Success Criteria
- `dart pub get` resolves dart_style 3.1.7+
- `dart analyze` produces no errors related to dart_style
- CLI compiles successfully

## Risk
- **Low:** Well-documented migration path, only 2 call sites
- SDK minimum bump from 3.0.0 to 3.11.0 drops support for Dart <3.11 users (acceptable -- 3.11 is current stable)

## Sources
- [dart_style 3.0.0 changelog](https://pub.dev/packages/dart_style/versions/3.0.0/changelog)
- [DartFormatter class API](https://pub.dev/documentation/dart_style/latest/dart_style/DartFormatter-class.html)
- [Issue #1581 - languageVersion parameter](https://github.com/dart-lang/dart_style/issues/1581)
