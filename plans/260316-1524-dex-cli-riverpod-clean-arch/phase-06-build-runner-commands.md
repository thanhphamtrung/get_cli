# Phase 6: Build Runner Commands

## Overview
- **Priority:** P2
- **Status:** completed
- **Effort:** Low (~1 hour)
- **Description:** Add `dex build` and `dex watch` convenience commands for code generation

## Context
- Depends on: Phase 3 (feature scaffolding generates code that needs build_runner)
- Simple wrapper around `flutter pub run build_runner`

## Requirements

### Functional
- `dex build` runs `flutter pub run build_runner build --delete-conflicting-outputs`
- `dex watch` runs `flutter pub run build_runner watch --delete-conflicting-outputs`
- Both show progress/output in terminal
- Error output passed through to user

## Related Code Files

### New Files to Create
- `lib/commands/impl/build/build.dart` — build command
- `lib/commands/impl/build/watch.dart` — watch command (or single file with flag)

### Files to Modify
- `lib/commands/impl/commads_export.dart` — export new commands
- `lib/core/generator.dart` — register in command tree

## Implementation Steps

### Step 1: Create Build Command
```dart
class BuildCommand extends Command {
  @override
  String get commandName => 'build';

  @override
  Future<void> execute() async {
    await ShellUtils.run('flutter pub run build_runner build --delete-conflicting-outputs');
  }
}
```

### Step 2: Create Watch Command
Same as build but with `watch` instead of `build`.

### Step 3: Register Commands
Add to command tree in generator.dart:
```dart
'build': BuildCommand(),
'watch': WatchCommand(),
```

## Todo List
- [x] Create build command
- [x] Create watch command
- [x] Register in command tree
- [x] Update exports
- [x] Test: dex build runs build_runner
- [x] Test: dex watch runs build_runner watch

## Success Criteria
- `dex build` triggers build_runner and shows output
- `dex watch` triggers build_runner watch mode
- Errors displayed correctly

## Risk Assessment
- **Minimal risk** — simple shell command wrappers. Main risk is flutter/dart not in PATH (already handled by existing shell utils).
