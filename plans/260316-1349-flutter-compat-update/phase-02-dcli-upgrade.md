# Phase 2: Upgrade dcli to 8.x

## Overview
- **Priority:** P1
- **Status:** complete
- **Effort:** 2.5h
- **Depends on:** Phase 1 (shared pubspec.yaml edits)
- **Completed:** 2026-03-16
- **Note:** No API changes needed — dcli 8.x is backward compatible

## Context
- Current: `dcli: ">=6.0.5 <7.0.0"` resolving to 6.1.2
- Target: `dcli: ">=8.0.0 <9.0.0"` resolving to 8.4.2
- dcli 6.1.2 works on Dart 3.11 (uses `native_synchronization_temp` instead of `dart:cli waitFor`)
- dcli 8.x had bug fix in 8.2.0 for "random process hang" -- important for CLI tool
- Major version jump: API changes possible

## dcli Usage in get_cli

Only 2 APIs used from dcli:
1. **`menu()`** function -- interactive terminal menu selection
2. **`ask()`** function -- prompt user for text input

### Usage locations:

| File | API | Purpose |
|------|-----|---------|
| `lib/common/menu/menu.dart` | `menu()` | Wrapper around dcli's menu function |
| `lib/commands/impl/create/project/project.dart` | `ask()` | Ask project name, company domain |
| `lib/commands/impl/create/page/page.dart` | `ask()` | Ask new page name |
| `lib/commands/impl/generate/model/model.dart` | `ask()` | Ask model name |

## Investigation Required
Before implementation, verify dcli 8.x API compatibility:

1. Check if `menu()` function signature changed
2. Check if `ask()` function signature changed
3. Check if import path changed (`package:dcli/dcli.dart`)

## Implementation Steps

- [x] Research dcli 8.x API compatibility
- [x] Update pubspec.yaml dcli constraint to >=8.0.0 <9.0.0
- [x] Run `dart pub get` to verify resolution
- [x] Verify no compilation errors (API was backward compatible)
- [x] Confirm `dart analyze` clean
- [x] Confirm `dart compile exe bin/get.dart` succeeds

## Files Potentially Modified
1. `pubspec.yaml` -- dependency constraint
2. `lib/common/menu/menu.dart` -- if menu() API changed
3. `lib/commands/impl/create/project/project.dart` -- if ask() API changed
4. `lib/commands/impl/create/page/page.dart` -- if ask() API changed
5. `lib/commands/impl/generate/model/model.dart` -- if ask() API changed

## Fallback Strategy
If dcli 8.x has incompatible API changes that require major refactoring:
- **Option A:** Write a thin wrapper that adapts the new API to old signatures (preferred)
- **Option B:** Replace dcli with `dart:io` stdin/stdout for `ask()` and a simple custom menu implementation (last resort, ~50 LOC)

## Risk Assessment
- **Medium:** Major version jump means potential API breaks, but only 2 APIs used
- dcli is actively maintained (last update 47 days ago)
- The `menu()` and `ask()` functions are core dcli features unlikely to be removed

## Success Criteria
- dcli 8.x resolves and compiles
- Interactive menu selection works in terminal
- Text input prompts work in terminal
- No regressions in `get init`, `get create project`, `get create page`, `get generate model`
