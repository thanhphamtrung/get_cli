# Flutter/Dart/GetX Compatibility Research Report
**Date:** 2026-03-16
**Status:** Comprehensive Version & Compatibility Analysis

---

## Executive Summary

`get_cli` (v1.9.1, SDK >=3.0.0 <4.0.0) hasn't been updated in ~19 months. Current ecosystem has significant advances:
- **Flutter:** 3.41.2 (stable as of Feb 2026)
- **Dart:** 3.11.0 (stable), 3.12.0 (beta available)
- **GetX:** 4.7.3 (stable), 5.0.0-rc available
- **Key deps:** Most at 2.x-3.x+ versions; need major constraint updates

**CRITICAL FINDING:** Multiple dependency versions have jumped significantly. CLI needs SDK constraint expansion (>=3.0.0 <4.0.0 → likely >=3.0.0 <5.0.0) and individual dependency pins updated.

---

## 1. Current Ecosystem Versions

### SDK Versions

| Component | Latest Stable | Notes |
|-----------|---------------|-------|
| **Flutter SDK** | 3.41.2 | Updated Feb 2026; last major = 3.38 (Nov 2025) |
| **Dart SDK** | 3.11.0 | Production-ready; 3.12.0 beta available |
| **GetX** | 4.7.3 | Actively maintained; 5.0.0-rc in progress |
| **GetX** | 5.0.0-rc-9.3.2 | Pre-release available; stability TBD |

**Current CLI Constraint:** `>=3.0.0 <4.0.0` — This **locks out Dart 4.x** and doesn't reflect modern Dart 3.5+ capabilities.

---

## 2. Dependency Version Analysis

### Critical Dependencies (Current vs Latest)

| Package | CLI Current | Latest Stable | Status | Notes |
|---------|------------|---------------|--------|-------|
| **dart_style** | >=2.3.6 <3.0.0 | 3.1.7 | ⚠️ MAJOR JUMP | Requires SDK ^3.9.0+ |
| **dcli** | >=6.0.5 <7.0.0 | 8.4.2 | ⚠️ MAJOR JUMP | Last update 47d ago; Dart 3 compatible |
| **http** | >=1.2.2 <2.0.0 | NOT FOUND | ⚠️ NEEDS CHECK | Check pub.dev directly for latest |
| **pubspec_parse** | >=1.3.0 <2.0.0 | 1.5.0 | ✓ MINOR UPDATE | Published 14mo ago |
| **recase** | >=4.0.0 <5.0.0 | 4.1.0 | ✓ STABLE | Last update Sept 2022; no breaking changes |
| **ansicolor** | (not found) | (not found) | ⚠️ NEEDS CHECK | Check pub.dev directly for latest |
| **process_run** | (not found) | 1.2.4 (stable) + 1.3.0-3 (prerelease) | ⚠️ NEEDS CHECK | dcli depends on this |

### Key Findings on Dependencies

**dart_style 3.1.7 Compatibility:**
- Requires Dart SDK `^3.9.0` or higher
- **Compatible with Dart 3.10 and 3.11** — supports new language features
- Removed dependency on analyzer internal APIs (uses `analyzer: ^10.0.0`)
- **BREAKING:** CLI constraint `<4.0.0` must expand to allow this version

**dcli 8.4.2 Compatibility:**
- Major version bump from 6.x to 8.x
- Published 47 days ago (early Feb 2026) — actively maintained
- Dart 3 compatible
- **CRITICAL ISSUE:** dcli 8.x uses different APIs than 6.x; migration needed
- Bug fix in 8.2.0 addressed random process hang — recommend upgrade

**pubspec_parse 1.5.0:**
- Minor version bump (1.3 → 1.5); API likely compatible
- Dart 3 compatible
- No major breaking changes documented

**recase 4.1.0:**
- Stable since Sept 2022; no recent updates needed
- Already compatible with current CLI constraints

---

## 3. Dart 3.x Breaking Changes Impact

### Breaking Changes Relevant to CLI

#### Named Optional Parameters
- **Change:** Pre-Dart 3, allowed `:` OR `=` for defaults; Dart 3 requires `=` only
- **Impact:** CLI code using `:` in function defaults **will fail** on Dart 3.x+
- **Action:** Audit codebase for `: value` syntax in optional params; replace with `= value`

#### Mixin Usage
- **Change:** Classes can't be used as mixins in Dart 3+ unless marked `mixin`
- **Impact:** Low — likely not used in CLI, but check if any classes used as mixins
- **Action:** If found, either add `mixin` keyword or use composition instead

#### Switch Cases / Continue Statements
- **Change:** Continue statements must target loops/switches; strict pattern matching in switch
- **Impact:** Low — unlikely to affect CLI
- **Action:** Check switch statements for deprecated patterns

#### Type Inference Context
- **Change:** Dart 3.5+ changed context for await expressions and type inference
- **Impact:** May affect code with dynamic await; generally backward compatible
- **Action:** Run tests; no code changes usually needed

### Language Features Added (Dart 3.5-3.7)

| Version | Feature | Relevance |
|---------|---------|-----------|
| 3.5 | Type inference improvements | No action needed; transparent |
| 3.6 | Digit separators (`1_000_000`) | Optional; improves readability |
| 3.7 | Wildcard variables, new dart format | **IMPORTANT:** New formatter might change code style |

**⚠️ DART 3.7 FORMATTER:** Dart 3.7 shipped with a **rewritten dart_style formatter** with different default behavior. If CLI uses `dart_style` for code generation, output formatting may change. This could impact generated file consistency.

---

## 4. Flutter Create Command Changes

### iOS Language Flag (`--ios-language`)

**Status:** DEPRECATED (Flutter 3.27.0+)
- **What:** `flutter create --ios-language objc` (Objective-C)
- **Why:** <1% of apps used Objective-C in 2024 Q1
- **Timeline:** Deprecation warning added; flag will be removed in future release
- **Action for CLI:** If CLI emits this flag, remove it; default is Swift-only

### Android Language Flag (`--android-language`)

**Status:** NOT FOUND in breaking changes
- Likely `--android-language java` already defaults to Kotlin
- **Action for CLI:** Verify no unsupported flags are emitted; test with current Flutter versions

### Android V1 Embedding (ALREADY REMOVED)

**Status:** NO LONGER SUPPORTED
- Android V2 embedding is mandatory in all `flutter create` projects
- Old `--enable-android-embedding-v1` flag removed
- **Action for CLI:** If template still references v1 embedding, update to v2

### Java Version Requirement

**Status:** Java 17 minimum (Flutter 3.38+)
- Gradle 8.14 (July 2025) also requires Java 17
- **Action for CLI:** Document this requirement; validate during project creation

---

## 5. Known Compatibility Issues

### get_cli Build Failures (Documented)

**Issue #264:** "Failed to build get_cli"
- Root cause: `dcli-2.3.0` missing `waitFor` method in `wait_for_ex.dart`
- **Status:** Old issue; current dcli (8.4.2) should not have this
- **Action:** Verify dcli 8.4.2 has all expected APIs during migration

### Dependency Resolution

- Old constraint ranges (6.0.5 <7.0.0 for dcli) prevent newer versions
- Pub solver will fail if multiple packages specify conflicting ranges
- **Action:** Update constraints systematically; run `pub get` after each change to validate resolution

---

## 6. Migration Path Summary

### Phase 1: SDK Constraint Expansion
```yaml
# Current (problematic)
sdk: '>=3.0.0 <4.0.0'

# Recommended (enables Dart 3.5-3.11)
sdk: '>=3.0.0 <4.0.0'  # Keep for now; test with 3.11.0

# Future (when Dart 4 is stable; not yet)
sdk: '>=3.0.0 <5.0.0'  # Only after thorough testing
```

### Phase 2: Dependency Updates (High Priority)

1. **dart_style:** 2.3.6 → 3.1.7 (requires audit for syntax changes)
2. **dcli:** 6.0.5 → 8.4.2 (major version; API changes likely)
3. **pubspec_parse:** 1.3.0 → 1.5.0 (minor; likely safe)

### Phase 3: Code Audit

- [ ] Search for named optional params using `:` syntax → replace with `=`
- [ ] Check iOS template for `--ios-language objc` flag → remove
- [ ] Verify no Android V1 embedding references
- [ ] Test generated code formatting with dart_style 3.1.7
- [ ] Validate pubspec.yaml parsing with pubspec_parse 1.5.0

### Phase 4: Testing & Release

- [ ] Run full test suite against Dart 3.11.0
- [ ] Test `flutter create` with Flutter 3.41.2
- [ ] Test GetX 4.7.3 project generation
- [ ] Verify generated code compiles with latest GetX
- [ ] Document breaking changes in changelog

---

## 7. Unresolved Questions

1. **http package latest version:** Web search didn't capture exact latest version of `http`. **Action:** Visit `https://pub.dev/packages/http` directly to confirm current version (constraint: `>=1.2.2 <2.0.0`).

2. **ansicolor latest version:** Exact version not captured. **Action:** Visit `https://pub.dev/packages/ansicolor` to confirm latest (currently unconstrained in CLI).

3. **process_run exact latest:** Found 1.2.4 stable and 1.3.0-3 prerelease, but unclear if 1.3 is production-ready. **Action:** Check if dcli 8.4.2 depends on specific process_run version.

4. **dcli 8.x API breaking changes:** Migration guide not found. **Action:** Check dcli GitHub changelog between 6.0.5 and 8.4.2 for API-breaking changes.

5. **GetX 5.0.0-rc stability:** Prerelease available but unclear if CLI should support it. **Action:** Decide on support timeline for GetX 5.0.0.

6. **Dart 3.7 formatter impact:** New formatter in Dart 3.7 may change code generation output. **Action:** Test code generation with both Dart 3.6 and 3.7 dart_style.

7. **Flutter 3.41.2 specific changes:** What new flags/features were added between 3.38 and 3.41.2? **Action:** Check Flutter 3.39-3.41 release notes for CLI-relevant changes.

---

## Sources
- [Flutter SDK archive](https://docs.flutter.dev/install/archive)
- [Dart SDK archive](https://dart.dev/get-dart/archive)
- [GetX package on pub.dev](https://pub.dev/packages/get)
- [Dart 3 migration guide](https://dart.dev/resources/dart-3-migration)
- [Breaking changes and migration guides](https://docs.flutter.dev/release/breaking-changes)
- [dart_style package](https://pub.dev/packages/dart_style)
- [dcli package](https://pub.dev/packages/dcli)
- [pubspec_parse package](https://pub.dev/packages/pubspec_parse)
- [recase package](https://pub.dev/packages/recase)
- [process_run package](https://pub.dev/packages/process_run)
- [Dart 3.7 announcement](https://medium.com/dartlang/announcing-dart-3-7-bf864a1b195c)
- [Dart 3.6 announcement](https://medium.com/dartlang/announcing-dart-3-6-778dd7a80983)
- [iOS language flag deprecation](https://github.com/flutter/flutter/pull/155867)
- [Android V1 embedding deprecation](https://docs.flutter.dev/release/breaking-changes/android-v1-embedding-create-deprecation)
- [get_cli GitHub repository](https://github.com/jonataslaw/get_cli)
