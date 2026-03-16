# Phase 3: Theme Scaffold Execution

**Priority:** High | **Status:** Pending

## Overview
Wire the theme samples into the scaffold command. Handle file creation, pubspec modification, and main.dart integration.

## Key Insights
- Follow `create feature` pattern: create directories → generate files → post-setup
- Use `ShellUtils.addPackage()` to auto-install shared_preferences
- Modifying main.dart is the trickiest part — need to inject theme imports and wiring
- Should detect if theme already scaffolded to avoid duplicates

## Requirements
- `dex scaffold theme` generates all 3 files in `lib/core/theme/`
- Auto-adds `shared_preferences` to pubspec.yaml
- Modifies `lib/main.dart` to wire theme (or prints instructions if can't)
- Runs `dex build` after (for @riverpod code generation)
- Shows clear success message with next steps

## Related Code Files

### Files to Modify
1. `lib/commands/impl/scaffold/theme/scaffold_theme.dart` — Full implementation
2. `lib/samples/impl/riverpod_clean/riverpod_main.dart` — May need to update main template to include theme wiring for new projects

### Reference Files
- `lib/commands/impl/create/feature/feature.dart` — Multi-file generation pattern
- `lib/functions/create/create_single_file.dart` — `writeFile()` utility
- `lib/functions/create/create_list_directory.dart` — `createListDirectory()`
- `lib/common/utils/pubspec/pubspec_utils.dart` — Package management

## Implementation Steps

### Step 1: Implement execute() in ScaffoldThemeCommand
```dart
Future<void> execute() async {
  // 1. Check if lib/core/theme/ already exists
  // 2. Create directory: lib/core/theme/
  // 3. Generate 3 files via Sample.create()
  // 4. Add shared_preferences dependency
  // 5. Attempt to wire into main.dart (or print instructions)
  // 6. Run build_runner for @riverpod code-gen
  // 7. Log success + next steps
}
```

### Step 2: Main.dart integration strategy
Two approaches (in order of preference):
1. **String replacement**: Read main.dart, find MaterialApp.router, inject theme/darkTheme/themeMode params + imports
2. **Fallback**: If main.dart structure is unrecognizable, print manual wiring instructions to console

For approach 1 — look for `MaterialApp.router(` and inject:
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
```
And add `theme:`, `darkTheme:`, `themeMode:` properties.

### Step 3: Update riverpod_main.dart sample (optional)
For NEW projects (`dex create project`), include theme wiring in the generated main.dart from the start. This makes `dex scaffold theme` work seamlessly on fresh projects.

### Step 4: Support `--no-build` flag
Skip build_runner if user passes `--no-build` (same as create feature).

## Todo
- [ ] Implement ScaffoldThemeCommand.execute()
- [ ] Implement directory creation + file generation
- [ ] Implement shared_preferences auto-install
- [ ] Implement main.dart integration (string replacement)
- [ ] Implement fallback instructions if main.dart can't be modified
- [ ] Support --no-build flag
- [ ] Test on fresh `dex create project` output
- [ ] Test on existing project

## Success Criteria
- `dex scaffold theme` generates 3 files without errors
- shared_preferences added to pubspec.yaml
- main.dart wired with theme (or clear instructions printed)
- `dex build` runs successfully after scaffold
- Running twice doesn't duplicate/overwrite (detects existing)

## Risk Assessment
- **main.dart modification**: Could fail on non-standard structures → mitigated by fallback instructions
- **Existing theme conflicts**: User may already have theme setup → check and warn before overwriting
