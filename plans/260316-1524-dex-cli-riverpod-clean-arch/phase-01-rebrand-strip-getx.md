# Phase 1: Rebrand & Strip GetX

## Overview
- **Priority:** P0 (must do first)
- **Status:** completed
- **Effort:** Medium (~2-3 hours)
- **Description:** Rename package/binary from get_cli→dex_cli, strip all GetX-specific code

## Context
- [Codebase scout report](../reports/) — 29 files need package name changes, 11 GetX-specific files to remove

## Requirements

### Functional
- `dex` binary works from command line
- All `get_cli` references replaced with `dex_cli`
- All `GetCli` class references replaced with `DexCli`
- GetX-specific files removed
- CLI compiles and runs `dex help` / `dex -v` successfully

### Non-Functional
- Zero GetX imports remain in codebase
- No broken imports after rename

## Related Code Files

### Files to Modify (Rebrand)
- `pubspec.yaml` — name, description, executables section (`get` → `dex`)
- `bin/get.dart` → rename to `bin/dex.dart`, update imports
- `lib/get_cli.dart` → rename to `lib/dex_cli.dart`, update exports
- `lib/core/generator.dart` — rename `GetCli` class → `DexCli`
- `lib/commands/interface/command.dart` — update package imports
- `lib/commands/impl/args_mixin.dart` — update package imports
- `lib/commands/impl/commads_export.dart` — update exports
- `lib/commands/impl/version/version.dart` — update version display text
- `lib/functions/version/print_get_cli.dart` — update print text, rename file
- `lib/functions/version/version_update.dart` — update pub.dev package name
- `lib/common/utils/pubspec/pubspec_utils.dart` — remove GetX-specific checks
- `lib/common/utils/shell/shel.utils.dart` — update package refs
- `lib/cli_config/cli_config.dart` — update config key from `get_cli` to `dex_cli`
- All remaining files with `package:get_cli/` imports (~20 files)

### Files to Remove (GetX-Specific)
- `lib/samples/impl/getx_pattern/get_main.dart`
- `lib/samples/impl/get_controller.dart`
- `lib/samples/impl/get_binding.dart`
- `lib/samples/impl/get_view.dart`
- `lib/samples/impl/get_route.dart`
- `lib/samples/impl/get_provider.dart`
- `lib/samples/impl/get_app_pages.dart`
- `lib/commands/impl/init/flutter/init_getxpattern.dart`
- `lib/functions/binding/add_dependencies.dart`
- `lib/functions/binding/find_bindings.dart`
- `lib/functions/routes/get_app_pages.dart`
- `lib/functions/routes/get_add_route.dart`
- `lib/functions/routes/get_support_children.dart`

### Files to Remove (Arktekko — will be replaced in Phase 2)
- `lib/samples/impl/arctekko/arc_main.dart`
- `lib/samples/impl/arctekko/arc_navigation.dart`
- `lib/samples/impl/arctekko/arc_routes.dart`
- `lib/samples/impl/arctekko/arc_screen.dart`
- `lib/samples/impl/arctekko/config_example.dart`
- `lib/commands/impl/init/flutter/init_katteko.dart`
- `lib/functions/routes/arc_add_route.dart`

### Files to Keep (No changes needed)
- `lib/common/utils/json_serialize/` — entire directory
- `lib/common/utils/logger/log_utils.dart`
- `lib/functions/create/` — all files
- `lib/functions/find_file/` — all files
- `lib/functions/sorter_imports/sort.dart`
- `lib/functions/is_url/is_url.dart`
- `lib/functions/replace_vars/replace_vars.dart`
- `lib/exception_handler/` — all files
- `lib/models/file_model.dart`
- `lib/extensions/` — all files (except dart_code.dart may need GetX ref check)

## Implementation Steps

### Step 1: Rename Package & Binary
1. Update `pubspec.yaml`: `name: dex_cli`, executables `dex: dex`
2. Rename `bin/get.dart` → `bin/dex.dart`
3. Rename `lib/get_cli.dart` → `lib/dex_cli.dart`
4. Global find-replace: `package:get_cli/` → `package:dex_cli/`
5. Rename class `GetCli` → `DexCli` in `lib/core/generator.dart`
6. Update all instantiations of `GetCli` → `DexCli`

### Step 2: Remove GetX-Specific Files
1. Delete all files listed in "Files to Remove" sections above
2. Remove empty directories left behind
3. Remove imports referencing deleted files from `commads_export.dart` and other barrel files

### Step 3: Clean Up References
1. In `pubspec_utils.dart`: remove `isGetXProject`, `isGetServerProject` checks (or adapt for new pattern detection)
2. In `init.dart`: remove GetX Pattern init option, keep only structure for new pattern
3. In `create/page/page.dart` and `create/screen/screen.dart`: strip GetX binding/route logic (will be replaced in Phase 3)
4. Remove `get_server` references from `lib/samples/impl/get_server/` or adapt for future use

### Step 4: Update CLI Metadata
1. Update `print_get_cli.dart` → rename to `print_dex_cli.dart`, update ASCII art/banner
2. Update `version_update.dart` to check `dex_cli` on pub.dev (or disable for internal tool)
3. Update help text in command descriptions

### Step 5: Verify Compilation
1. Run `dart analyze` — fix all errors
2. Run `dart compile exe bin/dex.dart` — verify binary builds
3. Run `dex -v` and `dex help` — verify basic CLI works

## Todo List
- [x] Rename pubspec.yaml (name, executables)
- [x] Rename bin/get.dart → bin/dex.dart
- [x] Rename lib/get_cli.dart → lib/dex_cli.dart
- [x] Global replace package:get_cli → package:dex_cli
- [x] Rename GetCli class → DexCli
- [x] Delete 13 GetX-specific files
- [x] Delete 7 Arktekko files
- [x] Remove broken imports from barrel files
- [x] Clean pubspec_utils.dart GetX checks
- [x] Update init.dart command (remove GetX option)
- [x] Rename print_get_cli.dart → print_dex_cli.dart
- [x] Update version/help text
- [x] Run dart analyze — zero errors
- [x] Run dart compile — binary builds
- [x] Run dex -v and dex help — works

## Success Criteria
- `dart analyze` passes with zero errors
- `dex -v` prints version
- `dex help` shows command list
- `grep -r "get_cli" lib/` returns zero matches
- `grep -r "GetCli" lib/` returns zero matches (except DexCli)
- `grep -r "package:get/" lib/` returns zero matches
- No GetX-specific files remain

## Risk Assessment
- **Import chain breaks**: Many files cross-reference. Do global replace first, then fix stragglers.
- **Barrel file exports**: `commads_export.dart` exports deleted files — must update.
- **pubspec_utils.dart**: Has GetX detection logic woven in — needs careful extraction.
