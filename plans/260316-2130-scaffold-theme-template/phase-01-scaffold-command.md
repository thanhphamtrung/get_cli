# Phase 1: Scaffold Command Infrastructure

**Priority:** High | **Status:** Pending

## Overview
Create the `dex scaffold` parent command with interactive menu. Establishes the pattern for future scaffold templates (auth, FCM, etc.).

## Key Insights
- Follow existing `CommandParent` + child `Command` pattern from `create` command
- Use dcli `menu()` for interactive selection — same as existing prompt patterns
- Register in `commands_list.dart` alongside existing commands

## Requirements
- `dex scaffold` → shows interactive menu of available templates
- `dex scaffold theme` → directly runs theme scaffold (skip menu)
- `dex scaffold --help` → shows available templates
- Extensible: adding new scaffolds = add new child command + register

## Related Code Files

### Files to Create
1. `lib/commands/impl/scaffold/scaffold.dart` — Parent command (`CommandParent`)
2. `lib/commands/impl/scaffold/theme/scaffold_theme.dart` — Theme scaffold command

### Files to Modify
1. `lib/commands/commands_list.dart` — Register scaffold command
2. `lib/commands/impl/commads_export.dart` — Export new files

## Implementation Steps

### Step 1: Create scaffold parent command
```
lib/commands/impl/scaffold/scaffold.dart
```
- Use `CommandParent('scaffold', [ScaffoldThemeCommand()], ['-sc'])`
- Or implement a custom parent that shows menu when no child specified

### Step 2: Create theme scaffold command stub
```
lib/commands/impl/scaffold/theme/scaffold_theme.dart
```
- Implement `Command` interface
- `commandName` = `'theme'`
- `hint` = `'Scaffold Material 3 theme with Riverpod (dark/light mode, design tokens)'`
- `codeSample` = `'dex scaffold theme'`
- `execute()` — will be implemented in Phase 3
- For now: just log "Theme scaffold coming soon"

### Step 3: Register in commands_list.dart
Add to the commands list:
```dart
CommandParent('scaffold', [
  ScaffoldThemeCommand(),
], ['-sc']),
```

### Step 4: Export in commads_export.dart
Add exports for new files.

## Todo
- [ ] Create scaffold parent command
- [ ] Create theme scaffold command stub
- [ ] Register in commands_list.dart
- [ ] Export in commads_export.dart
- [ ] Verify `dex scaffold` shows help / menu
- [ ] Verify `dex scaffold theme` runs stub

## Success Criteria
- `dex scaffold` lists available templates
- `dex scaffold theme` executes without error
- `dex help` shows scaffold command
- Pattern is extensible for future scaffolds
