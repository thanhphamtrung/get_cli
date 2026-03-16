---
title: "Update get_cli for Flutter/Dart compatibility"
description: "Upgrade dependencies (dart_style 3.x, dcli 8.x), fix analyzer warnings, clean dead code, update secondary deps"
status: complete
priority: P1
effort: 6h
branch: master
tags: [compatibility, dependencies, dart-style, dcli]
created: 2026-03-16
completed: 2026-03-16
---

# get_cli Flutter/Dart Compatibility Update

## Goal
Make get_cli fully compatible with Dart 3.11+, Flutter 3.41+.

## Current State
- v1.9.1, SDK >=3.0.0 <4.0.0
- Compiles and passes `dart analyze` (7 warnings/infos)
- dcli 6.1.2 resolves fine on Dart 3.11.1
- dart_style pinned to <3.0.0 (latest: 3.1.7)
- `flutterCreate` already fixed (PR #294) but dead code remains

## Phase Summary

| Phase | Description | Effort | Status |
|-------|-------------|--------|--------|
| [Phase 1](phase-01-dart-style-upgrade.md) | Upgrade dart_style 2.x → 3.x, SDK to >=3.11.0 | 1.5h | complete |
| [Phase 2](phase-02-dcli-upgrade.md) | Upgrade dcli 6.x → 8.x (try first, adapter fallback) | 2.5h | complete |
| [Phase 3](phase-03-dead-code-and-warnings.md) | Fix warnings, dead code, update secondary deps (lints, test, flutter_lints) | 1h | complete |
| [Phase 4](phase-04-version-bump-and-testing.md) | Version bump to 1.10.0, test, changelog | 1h | complete |

## Dependencies
- Phase 2 depends on Phase 1 (both touch pubspec.yaml)
- Phase 3 is independent, can run parallel with 1-2
- Phase 4 depends on all others

## Key Decisions
1. **SDK constraint**: `>=3.0.0 <4.0.0` → `>=3.11.0 <4.0.0` (user preference: latest stable only)
2. **dart_style 3.x**: `DartFormatter()` → `DartFormatter(languageVersion: DartFormatter.latestLanguageVersion)` in 2 files
3. **dcli 8.x**: Try upgrade first. If API breaks, write thin adapter. Fallback: replace with dart:io stdin code
4. **GetX 5**: SKIPPED — still RC for 1+ year, no stable date. Will add in future release
5. **Secondary deps**: Update lints (4→6), test (1.25→1.30), replace deprecated flutter_lints in templates
6. **Version**: Bump to 1.10.0

## Research Reports
- [Flutter/Dart/GetX Compat](../reports/researcher-260316-1346-flutter-dart-getx-compat.md)
- [GitHub Issues & Community](../reports/researcher-260316-1346-github-issues-community.md)
