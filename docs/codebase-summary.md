# Dex CLI - Codebase Summary

## Repository Statistics

| Metric | Value |
|--------|-------|
| **Total Dart Files** | 96 |
| **Total LOC (lib only)** | 8,401 |
| **Total LOC (with tests)** | 8,446 |
| **Test Files** | 1 |
| **Translation Files** | 8 |
| **Primary Language** | Dart (SDK >=3.11.0 <4.0.0) |
| **Repository** | https://github.com/thanhphamtrung/dex_cli |
| **Executable** | `dex` (compiled from `bin/dex.dart`) |

## Directory Structure & Breakdown

```
dex_cli/
├── bin/
│   ├── dex                         - Compiled native binary (executable)
│   ├── dex.dart                    - Main entry point (Dart source)
│   └── .dex_cli.yaml               - CLI configuration template
├── lib/
│   ├── get_cli.dart                - Barrel export (3 LOC)
│   ├── extensions.dart             - Extension exports
│   ├── cli_config/                 - CLI configuration (51 LOC)
│   ├── commands/                   - Command implementations (1,594 LOC)
│   ├── common/                     - Utilities & services (4,317 LOC) [LARGEST]
│   ├── core/                       - CLI engine & i18n (809 LOC)
│   ├── exception_handler/          - Error handling (40 LOC)
│   ├── extensions/                 - String/List extensions (86 LOC)
│   ├── functions/                  - File manipulation (880 LOC)
│   ├── models/                     - Data models (11 LOC)
│   └── samples/                    - Code templates (Riverpod) (604 LOC)
├── test/
│   └── path/test.dart              - Path utility tests
├── translations/                   - i18n JSON files (8 languages)
├── repomix-output.xml              - Codebase compaction for analysis
└── pubspec.yaml                    - Project manifest
```

## Module Breakdown

### 1. Commands Module (lib/commands/ - 1,594 LOC)

Implements the Command Pattern for CLI dispatch.

**Structure:**
- `interface/command.dart` - Abstract Command base class
- `impl/args_mixin.dart` - Argument parsing mixin
- `commands_list.dart` - Command registry
- `impl/create/` - Feature/entity/model/usecase/provider/datasource/repository/page creation
- `impl/generate/` - Model & localization generation
- `impl/install/` - Package dependency management
- `impl/remove/` - Package removal
- `impl/sort/` - Import sorting & formatting
- `impl/init/` - Project structure initialization (Riverpod Clean Architecture)
- `impl/update/` - Self-update mechanism
- `impl/version/` - Version display
- `impl/help/` - Help command

**Key Classes:**
- `Command` (abstract) - Base for all commands
- `CommandParent` - Groups subcommands
- `ArgsMixin` - Parses CLI arguments

**Dex-Specific Commands:**
- `CreateFeatureCommand` - Generate complete feature modules
- `CreateEntityCommand` - Freezed domain entities
- `CreateModelCommand` - Freezed DTO models
- `CreateUseCaseCommand` - Use case implementations
- `CreateProviderCommand` - Riverpod providers with @riverpod
- `CreateDatasourceCommand` - Data layer datasources
- `CreateRepositoryCommand` - Repository interfaces & implementations
- `CreatePageCommand` - ConsumerWidget pages

### 2. Common Module (lib/common/ - 4,317 LOC) [LARGEST]

Provides core utilities and services across CLI.

**Submodules:**

#### menu/ (Terminal UI)
- `menu.dart` - Interactive terminal menu selection

#### utils/json_serialize/ (~3,000+ LOC - JSON AST & Model Generation)
- `json_ast/` - JSON Abstract Syntax Tree parser
- `model_generator.dart` - Generates Dart models from JSON
- `helpers.dart` - JSON processing utilities
- Supports: null safety, lists, nested objects, type inference

#### utils/logger/ (Terminal Output)
- `log_utils.dart` - Colored logging (info, success, warn, error)

#### utils/pub_dev/ (Package Management)
- `pub_dev_api.dart` - HTTP client for pub.dev API

#### utils/pubspec/ (Project Configuration)
- `pubspec_utils.dart` - Read/write pubspec.yaml
- `pubspec_lock.dart` - Parse pubspec.lock
- `yaml_to.string.dart` - YAML serialization

#### utils/shell/ (Process Execution)
- `shell.utils.dart` - Execute flutter/dart commands

#### utils/backup/ (File Backup)
- `backup_utils.dart` - File backup utilities

### 3. Core Module (lib/core/ - 809 LOC)

CLI engine and internationalization support.

**Files:**
- `generator.dart` - `GetCli` class (command finder & dispatcher)
- `structure.dart` - Project path management
- `internationalization.dart` - i18n initialization
- `locales.g.dart` - Generated locale keys (8 languages)

**Key Classes:**
- `GetCli` - Main CLI orchestrator
  - `findCommand()` - Recursively searches command tree
  - `validate()` - Validates command arguments
  - `execute()` - Executes command logic

### 4. Functions Module (lib/functions/ - 880 LOC)

File and project manipulation utilities.

**Submodules:**
- `binding/` - Dependency injection binding helpers
- `create/` - Directory/file creation utilities
- `exports_files/` - Export statement management
- `find_file/` - File/folder search by name
- `formatter_dart_file/` - Dart code formatting wrapper
- `is_url/` - URL validation
- `path/` - Relative import conversion
- `replace_vars/` - Template variable replacement
- `routes/` - Route management (GetX & CLEAN patterns)
- `sorter_imports/` - Import sorting
- `version/` - Version checking & updates

### 5. Samples Module (lib/samples/ - 604 LOC)

Template implementations for Riverpod + Clean Architecture code generation.

**Structure:**
- `interface/sample_interface.dart` - Template base class
- `impl/riverpod_clean_architecture/` - Riverpod Clean Architecture templates
- Individual templates: entity, model, usecase, provider, datasource, repository, page, locales

**Dex-Specific Templates:**
- Freezed entity templates (domain layer)
- Freezed model templates (data layer)
- Use case templates (domain layer)
- Riverpod provider templates with @riverpod code generation
- Datasource templates (remote/local)
- Repository interface & implementation templates
- ConsumerWidget page templates
- Build runner integration

### 6. Extensions Module (lib/extensions/ - 86 LOC)

Utility extensions for String, List, and Dart code.

**Files:**
- `string.dart` - String case conversion, formatting
- `list.dart` - List utilities
- `dart_code.dart` - Dart code manipulation

### 7. Exception Handler (lib/exception_handler/ - 40 LOC)

Custom exception and error handling.

**Files:**
- `exception_handler.dart` - Global exception handler
- `exceptions/cli_exception.dart` - CliException class

### 8. Models Module (lib/models/ - 11 LOC)

Data transfer objects.

**Files:**
- `file_model.dart` - FileModel (name, path, commandName)

### 9. CLI Config (lib/cli_config/ - 51 LOC)

Runtime configuration management.

**Files:**
- `cli_config.dart` - Configuration from pubspec.yaml

## Command Flow

```
User Input: dex create feature:auth
    ↓
bin/dex.dart (entry point)
    ↓
GetCli(arguments).findCommand()
    ├── Recursively searches command tree
    ├── Matches: "create" → CommandParent
    ├── Matches: "feature" → CreateFeatureCommand
    ├── Parses args: {name: "auth"}
    ↓
command.validate()
    ├── Validates argument presence
    ├── Checks file system
    ├── Confirms project structure
    ↓
command.execute()
    ├── Creates feature directory structure
    ├── Generates entity (domain layer)
    ├── Generates model (data layer)
    ├── Generates datasource (data layer)
    ├── Generates repository (data + domain layers)
    ├── Generates usecase (domain layer)
    ├── Generates provider (presentation layer)
    ├── Updates exports and barrel files
    ↓
Success/Error Message
```

## Key Patterns & Conventions

### 1. Command Pattern
- All commands extend `Command` abstract class
- `CommandParent` wraps subcommands
- Argument parsing via `ArgsMixin`

### 2. Template Generation
- `Sample` interface defines generation contract
- Concrete implementations for each pattern (GetX, CLEAN)
- Template variable replacement: `@variable_name`

### 3. Configuration
- Project config: `pubspec.yaml` (dex_cli section)
- Separator: File name separator (e.g., `_` or `.`)
- sub_folder: Directory hierarchy flag (true = create subdirectories)

### 4. i18n Architecture
- JSON translation files in `translations/`
- Generated locale keys in `lib/core/locales.g.dart`
- 8 supported languages

## Dependency Graph

```
bin/dex.dart
    ↓
lib/core/generator.dart (GetCli)
    ├── → lib/commands/commands_list.dart
    ├── → lib/core/internationalization.dart
    ├── → lib/exception_handler/exception_handler.dart
    ├── → lib/common/utils/logger/log_utils.dart
    └── → Command implementations
        ├── → lib/functions/* (file manipulation)
        ├── → lib/common/utils/shell/ (process execution)
        ├── → lib/samples/* (Riverpod templates)
        ├── → lib/common/utils/pubspec/ (config)
        └── → lib/common/utils/json_serialize/ (Freezed model generation)
```

## Testing Coverage

- **Test Files:** 1
- **Test Coverage:** ~0.01% (minimal)
- **Location:** `test/path/test.dart`

**Recommendation:** Increase test coverage, focus on:
- Command validation logic
- File generation utilities
- JSON model generation
- Path manipulation functions

## Code Quality Observations

### Strengths
- Clear separation of concerns
- Command pattern enables easy extension
- Modular utilities
- Comprehensive template system
- Multi-language support

### Areas for Improvement
- Limited test coverage
- Some files approaching or exceeding 200 LOC
- Minimal documentation in code
- Error handling could be more granular

## External Dependencies

| Package | Purpose |
|---------|---------|
| `dcli` | Terminal I/O, shell execution |
| `dart_style` | Dart code formatting |
| `http` | HTTP client |
| `recase` | Case conversion |
| `yaml` / `pubspec_parse` | YAML parsing |
| `ansicolor` | Colored terminal output |
| `process_run` | Process execution |
| `intl` | Internationalization |

## Language Support

- **Languages:** 8 (English, Portuguese BR, Chinese Simplified, German, French, Italian, Arabic, Turkish)
- **Format:** JSON translation files
- **Generation:** Dart constants from JSON

## Build & Deployment

- **Executable:** `dex` (compiled from `bin/dex.dart`)
- **Installation Options:**
  - From source: `dart pub global activate -sgit https://github.com/thanhphamtrung/dex_cli`
  - Local dev: `dart pub global activate --source path .`
  - Native binary: `dart compile exe bin/dex.dart -o bin/dex`
- **Distribution:** GitHub releases + pub.dev package

---

**Last Updated:** 2026-03-16
**Codebase Compacted By:** Repomix v1.9.2
**Repomix Output:** `./repomix-output.xml`
**Project Status:** Dex CLI (Riverpod + Clean Architecture fork)
