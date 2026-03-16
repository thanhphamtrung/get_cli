# Dex CLI - System Architecture

## High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         User Input                           │
│            dex create feature:auth                           │
└────────────────┬────────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────────┐
│                    Entry Point (bin/dex.dart)                │
│                                                               │
│         - Captures arguments                                  │
│         - Initializes GetCli instance                         │
│         - Delegates to command dispatcher                     │
└────────────────┬────────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────────┐
│              CLI Engine (lib/core/generator.dart)            │
│                                                               │
│    GetCli Class                                               │
│    ├── findCommand()      ← Recursively searches tree        │
│    ├── validate()         ← Validates arguments              │
│    └── execute()          ← Runs command logic               │
└────────────────┬────────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────────┐
│              Command Matching & Validation                   │
│                                                               │
│    Commands Tree:                                             │
│    ├── create (CommandParent)                                │
│    │   ├── project                                           │
│    │   ├── feature                                           │
│    │   ├── entity                                            │
│    │   ├── model                                             │
│    │   ├── usecase                                           │
│    │   ├── provider                                          │
│    │   ├── datasource                                        │
│    │   ├── repository                                        │
│    │   └── page                                              │
│    ├── generate                                              │
│    ├── init                                                  │
│    ├── install                                               │
│    ├── build                                                 │
│    ├── watch                                                 │
│    └── ...                                                   │
└────────────────┬────────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────────┐
│              Command Execution Layer                         │
│                                                               │
│    Implementation Modules:                                    │
│    ├── lib/functions/     (File operations)                  │
│    ├── lib/common/        (Utilities & services)             │
│    ├── lib/samples/       (Riverpod + Clean Arch templates)  │
│    └── lib/models/        (Data models)                      │
└────────────────┬────────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────────┐
│              Output & Feedback                               │
│                                                               │
│    Logger (lib/common/utils/logger/)                         │
│    ├── Success messages                                      │
│    ├── Error reporting                                       │
│    ├── Progress updates                                      │
│    └── Colored terminal output                               │
└─────────────────────────────────────────────────────────────┘
```

## Command Pattern Implementation

### Command Hierarchy

```
Command (abstract base)
├── validate()      ← Pre-execution validation
└── execute()       ← Main logic

CommandParent extends Command
├── Holds subcommands
├── Dispatches to appropriate child
└── Inherits validate/execute pattern

Concrete Commands extend Command
├── CreateProjectCommand
├── CreatePageCommand
├── GenerateModelCommand
└── ... (others)
```

### Command Dispatch Flow

```
Input: "dex create feature:auth"
        │
        ├─ Parse: ["create", "feature:auth"]
        │
        ▼
    GetCli.findCommand()
        │
        ├─ Match "create" → CreateCommandParent
        │
        ├─ Match "feature" → CreateFeatureCommand
        │
        ├─ Extract args: {name: "auth"}
        │
        ▼
    CreateFeatureCommand.validate()
        │
        ├─ Check: Is feature name valid?
        ├─ Check: Is project initialized?
        ├─ Check: lib/features directory exists?
        │
        ▼
    CreateFeatureCommand.execute()
        │
        ├─ Load project structure
        ├─ Generate domain layer (entity, repository interface, usecase)
        ├─ Generate data layer (model, datasource, repository impl)
        ├─ Generate presentation layer (provider, page)
        ├─ Create barrel exports
        ├─ Update main barrel file
        │
        ▼
    Output: "Feature 'auth' created successfully! Run 'dex build' to generate Freezed & @riverpod code."
```

## Module Interactions

### Core Flow: Creating a Feature Module

```
User Command: dex create feature:auth
        │
        ▼
    lib/core/generator.dart
    (GetCli class)
        │
        ├─ findCommand() → locate CreateFeatureCommand
        │
        ▼
    lib/commands/impl/create/feature/feature.dart
    (CreateFeatureCommand)
        │
        ├─ validate()
        │   └─ Checks pubspec.yaml and project structure
        │
        ├─ execute()
        │   ├─ Call lib/samples/impl/riverpod_clean_architecture/
        │   │   ├─ entity.dart (Freezed entity template)
        │   │   ├─ model.dart (Freezed DTO template)
        │   │   ├─ datasource.dart
        │   │   ├─ repository.dart (interface + impl)
        │   │   ├─ usecase.dart
        │   │   └─ provider.dart (@riverpod template)
        │   │
        │   ├─ Call lib/functions/create/
        │   │   ├─ create_single_file.dart
        │   │   ├─ create_list_directory.dart
        │   │   └─ create_navigation.dart
        │   │
        │   ├─ Call lib/functions/exports_files/
        │   │   └─ add_export.dart
        │   │
        │   └─ Call lib/common/utils/logger/
        │       └─ log_utils.dart (success messages)
        │
        ▼
    File System Updates
    ├─ Create: lib/features/auth/
    │   ├─ data/
    │   │   ├─ datasources/
    │   │   ├─ models/
    │   │   └─ repositories/
    │   ├─ domain/
    │   │   ├─ entities/
    │   │   ├─ repositories/
    │   │   └─ usecases/
    │   └─ presentation/
    │       ├─ pages/
    │       └─ providers/
    ├─ Create: barrel exports (auth.dart for each layer)
    └─ Update: main barrel file
```

### Core Flow: Generating Freezed Model from JSON

```
User Command: dex generate model on auth with assets/models/user.json
        │
        ▼
    lib/commands/impl/generate/model/model.dart
    (GenerateModelCommand)
        │
        ├─ validate()
        │   ├─ Check: Is JSON file valid?
        │   └─ Check: Does target folder exist?
        │
        ├─ execute()
        │   │
        │   ├─ Read JSON file
        │   │   └─ lib/common/utils/json_serialize/
        │   │
        │   ├─ Parse JSON to AST
        │   │   └─ lib/common/utils/json_serialize/json_ast/parse.dart
        │   │
        │   ├─ Infer Dart types
        │   │   └─ lib/common/utils/json_serialize/model_generator.dart
        │   │
        │   ├─ Generate Freezed class
        │   │   ├─ @freezed annotation
        │   │   ├─ Properties
        │   │   ├─ factory constructor
        │   │   ├─ fromJson() factory
        │   │   └─ toJson() method (via .g.dart)
        │   │
        │   ├─ Create file
        │   │   └─ lib/functions/create/create_single_file.dart
        │   │
        │   └─ Log success
        │       └─ lib/common/utils/logger/log_utils.dart
        │
        ▼
    File System Updates
    ├─ Create: lib/features/auth/data/models/user_model.dart (with @freezed)
    └─ Run: dex build (to generate user_model.freezed.dart and user_model.g.dart)
```

## Data Flow Diagrams

### Configuration Resolution

```
pubspec.yaml
├─ dex_cli:
│  ├─ separator: "."
│  └─ sub_folder: true
│
▼
lib/cli_config/cli_config.dart
├─ CliConfig.read() → parses pubspec.yaml
│
▼
Commands use CliConfig
├─ Determine file naming pattern
├─ Determine directory structure
├─ Generate appropriate layer structure
└─ Apply to all generated files (entities, models, providers, etc.)
```

### JSON to Model Generation

```
assets/models/user.json
│
├─ {
├─   "name": "",        ← String type
├─   "age": 0,          ← int type
├─   "email": "",       ← String type
├─   "roles": [""],     ← List<String> type
├─   "meta": {...}      ← Nested object → class
│ }
│
▼
lib/common/utils/json_serialize/json_ast/tokenize.dart
├─ Tokenize JSON string
│
▼
lib/common/utils/json_serialize/json_ast/parse.dart
├─ Build Abstract Syntax Tree
│
▼
lib/common/utils/json_serialize/model_generator.dart
├─ Infer types from AST
├─ Generate Dart code:
│  ├─ class User { ... }
│  ├─ User.fromJson(Map json) { ... }
│  └─ Map toJson() { ... }
│
▼
Output: lib/modules/home/models/user_model.dart
```

### Package Management Flow

```
User Command: get install http path camera
        │
        ▼
    lib/commands/impl/install/install.dart
    (InstallCommand)
        │
        ├─ Parse package names
        │
        ├─ Validate packages on pub.dev
        │   └─ lib/common/utils/pub_dev/pub_dev_api.dart
        │
        ├─ Update pubspec.yaml
        │   └─ lib/common/utils/pubspec/pubspec_utils.dart
        │
        ├─ Execute: flutter pub get
        │   └─ lib/common/utils/shell/shell.utils.dart
        │
        ▼
    File System Updates
    └─ pubspec.yaml (dependencies added)
    └─ pubspec.lock (generated by pub get)
```

## Architectural Patterns

### 1. Command Pattern
Encapsulates requests as objects. Each command (create, generate, install) is a separate class.

**Benefit:** Easy to add new commands without modifying core logic.

### 2. Template Pattern
`Sample` base class defines contract; concrete implementations (GetX, CLEAN) provide templates.

**Benefit:** Support multiple architecture patterns without code duplication.

### 3. Mixin Pattern
`ArgsMixin` provides shared argument parsing across commands.

**Benefit:** DRY principle for cross-cutting concerns.

### 4. Facade Pattern
`GetCli` class hides complexity of command finding and execution.

**Benefit:** Simple API for entry point; complex dispatch logic hidden.

### 5. Factory Pattern
Implicit: Commands created based on user input in `findCommand()`.

**Benefit:** Loose coupling between command types.

## State Management

Dex CLI is **stateless** within command execution. State is managed through:

1. **Project Configuration** → `pubspec.yaml`
2. **Project Structure** → File system
3. **Command Arguments** → CLI input

No in-memory state persists between commands.

## Error Handling Strategy

```
User Input
    │
    ▼
GetCli.findCommand()
    ├─ No match? → CliException("Unknown command")
    │
    ▼
Command.validate()
    ├─ Invalid args? → CliException("Missing required argument")
    ├─ File not found? → CliException("File not found")
    │
    ▼
Command.execute()
    ├─ File I/O error? → CliException("Failed to create file")
    ├─ Shell command failed? → CliException("Flutter command failed")
    │
    ▼
Global Exception Handler (lib/exception_handler/)
    ├─ Log error message
    ├─ Log suggestion (if available)
    ├─ Exit with code 1 (CliException) or 2 (Unexpected)
```

## Internationalization Architecture

```
lib/core/internationalization.dart
├─ Initializes i18n system
├─ Loads translation JSON
│
▼
translations/
├─ en.json
├─ pt_BR.json
├─ de.json
├─ fr.json
├─ it_IT.json
├─ ar.json
├─ tr_TR.json
└─ zh_CN.json
│
▼
lib/core/locales.g.dart (generated)
├─ LocaleKeys class (constants)
│   ├─ static const project_created = "project_created"
│   ├─ static const page_created = "page_created"
│   └─ ...
│
▼
Commands use LocaleKeys
├─ logger.success(translate(LocaleKeys.project_created))
```

## Architecture Pattern: Riverpod + Clean Architecture

### Structure

Dex CLI generates projects following **Riverpod + Clean Architecture**:

**Domain Layer (Business Logic)**
- Entities (Freezed)
- Repository interfaces
- Use cases

**Data Layer (Data Access)**
- Models (Freezed DTOs)
- Datasources (remote/local)
- Repository implementations

**Presentation Layer (UI/State)**
- Pages (ConsumerWidget)
- Providers (Riverpod @riverpod)

### How Pattern Templates Work

```
lib/samples/interface/sample_interface.dart
├─ Sample (abstract base)
│   └─ generate(className, folderPath)
│
├─ FreezedEntitySample
│   └─ Returns: @freezed entity class
│
├─ RiverpodProviderSample
│   └─ Returns: @riverpod provider class
│
├─ UseCaseSample
│   └─ Returns: use case class
│
└─ Concrete implementations
    └─ lib/samples/impl/riverpod_clean_architecture/
        ├─ entity.dart
        ├─ model.dart
        ├─ provider.dart
        ├─ usecase.dart
        ├─ datasource.dart
        ├─ repository.dart
        ├─ page.dart
        └─ locales.dart
```

## System Constraints & Assumptions

### Constraints
- Must run on Windows, macOS, Linux
- Requires Dart SDK >=3.11.0 <4.0.0
- Requires Flutter SDK (for Flutter projects)
- Requires build_runner for code generation
- Single-threaded execution model

### Assumptions
- Project structure follows Riverpod Clean Architecture conventions
- pubspec.yaml exists and is valid YAML
- File system is writable
- Dart/Flutter CLIs are in PATH
- JSON inputs are valid (with error recovery)
- Freezed and riverpod dependencies installed
- build_runner available for code generation

## Performance Characteristics

| Operation | Time | Notes |
|-----------|------|-------|
| Create project | ~20-30s | Includes `flutter pub get` |
| Create page | ~2-5s | File I/O + template generation |
| Generate model | <1s | JSON parsing + code generation |
| Generate locales | <1s | JSON parsing + code generation |
| Install package | ~10-30s | Depends on pub.dev API |

## Security Considerations

1. **Path Validation:** All file paths validated before operations
2. **Command Injection:** Uses Process API, never shell strings
3. **Input Sanitization:** Class names and file names validated
4. **File Permissions:** Checks before write/delete operations
5. **Backup:** No sensitive data stored in configuration

## Extension Points

Future enhancements can extend:

1. **New Commands:** Extend `Command` class
2. **New Patterns:** Implement `Sample` interface (currently Riverpod + Clean Architecture)
3. **New Localizations:** Add translation JSON file
4. **New Templates:** Add sample implementation in riverpod_clean_architecture
5. **New Utilities:** Add function in appropriate module

## Build Runner Integration

Dex CLI generates code that requires build_runner:

```bash
# Run code generation once
dex build

# Watch for changes and regenerate
dex watch

# Manual build_runner (alternative)
dart run build_runner build
dart run build_runner watch
```

Generated files:
- `.freezed.dart` - Freezed entity/model implementations
- `.g.dart` - JSON serialization code
- `.g.dart` - Riverpod provider code (from @riverpod)

---

**Last Updated:** 2026-03-16
**Architecture Version:** 0.0.2 (Riverpod + Clean Architecture)
**Code Generation:** Freezed + Riverpod @riverpod + build_runner
