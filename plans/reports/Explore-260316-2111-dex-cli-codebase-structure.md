# Dex CLI - Codebase Exploration Report

**Date:** 2026-03-16  
**Scope:** Templates/generators, organization, CLI overview, documentation

---

## 1. CLI Tool Overview

**Dex CLI** is a Flutter CLI scaffolding tool for projects using **Riverpod + Clean Architecture**. It's a fork of GetX CLI rewritten to support the Riverpod ecosystem instead of GetX patterns.

**Version:** 0.0.2  
**Repository:** https://github.com/thanhphamtrung/dex_cli  
**Language:** Dart 3.11.0+

### Core Purpose
- Generate new Flutter projects with Riverpod + Clean Architecture preset
- Create feature modules (complete with all 3 layers: data, domain, presentation)
- Scaffold individual components: entities, models, use cases, providers, datasources, repositories, pages
- Manage code generation (build_runner, freezed, riverpod_annotation)
- Generate models from JSON with freezed annotations
- Generate localization classes from JSON

---

## 2. Command Structure (lib/commands/)

All commands follow the **Command Pattern** with hierarchical organization.

### Command Hierarchy

```
create (CommandParent)
  ├── project          → CreateProjectCommand
  ├── feature          → CreateFeatureCommand
  ├── entity           → CreateEntityCommand
  ├── model            → CreateModelCommand
  ├── usecase          → CreateUseCaseCommand
  ├── provider         → CreateProviderCommand
  ├── datasource       → CreateDataSourceCommand
  ├── repository       → CreateRepositoryCommand
  └── page             → CreatePageCommand

generate (CommandParent)
  ├── model            → GenerateModelCommand
  └── locales          → GenerateLocalesCommand

build                  → BuildCommand
watch                  → WatchCommand
init                   → InitCommand
install                → InstallCommand
remove                 → RemoveCommand
sort                   → SortCommand
update                 → UpdateCommand
version                → VersionCommand
help                   → HelpCommand
```

### Command File Organization

```
lib/commands/
├── interface/
│   └── command.dart              # Abstract Command base class
├── impl/
│   ├── args_mixin.dart           # Argument parsing logic
│   ├── commads_export.dart       # Command imports
│   ├── create/
│   │   ├── feature/feature.dart              (123 lines)
│   │   ├── entity/entity.dart                (45 lines)
│   │   ├── model/model.dart                  (42 lines)
│   │   ├── usecase/usecase.dart              (38 lines)
│   │   ├── provider/provider.dart            (47 lines)
│   │   ├── datasource/datasource.dart        (35 lines)
│   │   ├── repository/repository.dart        (45 lines)
│   │   ├── page/page.dart                    (38 lines)
│   │   └── project/project.dart              (76 lines)
│   ├── generate/
│   │   ├── model/
│   │   │   └── model.dart
│   │   └── locales/
│   │       └── locales.dart
│   ├── build/
│   ├── init/
│   ├── install/
│   ├── remove/
│   ├── sort/
│   ├── update/
│   └── version/
└── commands_list.dart            # Command registry + CommandParent class
```

### Command Pattern Details

**Base Class:** `Command` (abstract)
- `commandName`: Unique identifier ("create", "feature", etc.)
- `alias`: Alternative names
- `execute()`: Main logic (async)
- `validate()`: Pre-execution validation
- `maxParameters`: Expected arg count
- `acceptedFlags`: Valid flags
- `codeSample`: Usage example
- `hint`: Help text

**Parent Class:** `CommandParent extends Command`
- Holds subcommands in `childrens` list
- Dispatches to appropriate child command
- Empty `execute()` (delegation only)

---

## 3. Templates/Samples System (lib/samples/)

### Template Architecture

```
lib/samples/
├── interface/
│   └── sample_interface.dart     # Sample base class
└── impl/
    ├── analysis_options.dart
    ├── generate_locales.dart
    └── riverpod_clean/           # Riverpod + Clean Architecture
        ├── riverpod_clean_samples.dart    # Barrel export
        ├── riverpod_entity.dart
        ├── riverpod_model.dart
        ├── riverpod_usecase.dart
        ├── riverpod_usecase_base.dart
        ├── riverpod_provider.dart
        ├── riverpod_remote_datasource.dart
        ├── riverpod_repository_interface.dart
        ├── riverpod_repository_impl.dart
        ├── riverpod_page.dart
        ├── riverpod_main.dart
        ├── riverpod_pubspec.dart
        ├── riverpod_route_names.dart
        ├── riverpod_app_router.dart
        ├── riverpod_dio_client.dart
        ├── riverpod_auth_interceptor.dart
        ├── riverpod_env.dart
        ├── riverpod_exceptions.dart
        ├── riverpod_failures.dart
        └── riverpod_analysis_options.dart
```

### Template System Mechanism

**Base Class:** `Sample` (lib/samples/interface/sample_interface.dart)
```dart
abstract class Sample {
  String path;              // Output file path
  bool overwrite;           // Overwrite existing?
  String get content;       // Template string
  File create({bool skipFormatter});  // Write file
}
```

**Concrete Template Pattern:**
```dart
class RiverpodProviderSample extends Sample {
  final String _name;
  
  RiverpodProviderSample(this._name, {String? path})
    : super(path ?? 'lib/features/${_name.snakeCase}/presentation/...');
    
  @override
  String get content => '''
    import 'package:riverpod_annotation/riverpod_annotation.dart';
    
    part '${_name.snakeCase}_provider.g.dart';
    
    @riverpod
    class ${_name.pascalCase}Notifier extends _$${_name.pascalCase}Notifier {
      // Template content
    }
  ''';
}
```

### Available Templates (20 files, 698 lines total)

| Template | Location | Purpose |
|----------|----------|---------|
| **Entity** | `riverpod_entity.dart` (27 lines) | @freezed domain entity |
| **Model** | `riverpod_model.dart` (42 lines) | @freezed DTO + toEntity() |
| **UseCase** | `riverpod_usecase.dart` (34 lines) | Domain layer use case |
| **UseCaseBase** | `riverpod_usecase_base.dart` (37 lines) | Abstract use case base |
| **Provider** | `riverpod_provider.dart` (39 lines) | @riverpod AsyncNotifier |
| **RemoteDataSource** | `riverpod_remote_datasource.dart` (60 lines) | Data layer datasource |
| **RepositoryInterface** | `riverpod_repository_interface.dart` (35 lines) | Domain repo interface |
| **RepositoryImpl** | `riverpod_repository_impl.dart` (50 lines) | Data repo implementation |
| **Page** | `riverpod_page.dart` (45 lines) | ConsumerWidget page |
| **Main** | `riverpod_main.dart` (43 lines) | App entry point setup |
| **PubSpec** | `riverpod_pubspec.dart` (49 lines) | pubspec.yaml setup |
| **DioClient** | `riverpod_dio_client.dart` (44 lines) | HTTP client with Dio |
| **AuthInterceptor** | `riverpod_auth_interceptor.dart` (38 lines) | Auth token handling |
| **RouteNames** | `riverpod_route_names.dart` (28 lines) | Route name constants |
| **AppRouter** | `riverpod_app_router.dart` (36 lines) | GoRouter setup |
| **Env** | `riverpod_env.dart` (31 lines) | Environment constants |
| **Exceptions** | `riverpod_exceptions.dart` (38 lines) | Custom exceptions |
| **Failures** | `riverpod_failures.dart` (35 lines) | Result/Either failures |
| **AnalysisOptions** | `riverpod_analysis_options.dart` (37 lines) | Linting config |

### Template Design Pattern

**Key Conventions:**
- All use **ReCase** library for case conversion:
  - `snakeCase`: file names, imports
  - `pascalCase`: class names
- Template variables: `${_name.snakeCase}`, `${_name.pascalCase}`
- Part files: `part '${_name.snakeCase}_provider.g.dart';` (generated by build_runner)
- Freezed imports: `import 'package:freezed_annotation/freezed_annotation.dart';`
- Riverpod imports: `import 'package:riverpod_annotation/riverpod_annotation.dart';`

---

## 4. How Templates are Organized

### Template Organization Strategy

1. **By Layer (Clean Architecture)**
   - **Domain:** Entity, UseCase, RepositoryInterface
   - **Data:** Model, RemoteDataSource, RepositoryImpl
   - **Presentation:** Provider (Riverpod), Page (ConsumerWidget)
   - **Shared/Core:** Main, DioClient, AuthInterceptor, RouteNames, AppRouter, Env, Exceptions, Failures

2. **By Feature Generation**
   - `create feature:auth` → Generates 8 files at once
   - `create entity:user on auth` → Single entity in existing feature
   - `create provider:login on auth` → Single provider in existing feature
   - All respect the structure defined in `lib/core/structure.dart`

3. **Naming Convention**
   - File separator configurable: `_` (default) or `.` in pubspec.yaml
   - Sub-folder option: `true` (default creates subdirectories) in pubspec.yaml
   - Example: `user_entity.dart` → entity user → snakeCase

### Template Instantiation Flow

```
CreateEntityCommand.execute()
  ↓
RiverpodEntitySample(entityName, path: path)
  ↓
.create(skipFormatter: true)
  ↓
writeFile(path, content, overwrite: true)
  ↓
File(path).writeAsStringSync(content)
  ↓
Optionally format with dart_style
```

---

## 5. Project Structure Template

When `dex create project` is executed:

1. Creates new directory with snake_case project name
2. Prompts for company domain (e.g., `com.yourcompany`)
3. Prompts for linter usage
4. Runs `flutter create` with org
5. Clears test/widget_test.dart
6. Adds lints if chosen
7. Calls `InitCommand` to scaffold Clean Architecture structure

Generated structure:
```
lib/
├── core/                 # Shared utilities, routing, environment
│   ├── router/          # GoRouter setup
│   ├── theme/
│   ├── constants/
│   ├── exceptions/
│   └── failures/
├── features/            # Feature modules (one per major feature)
│   └── {feature_name}/
│       ├── data/
│       │   ├── models/
│       │   ├── datasources/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── pages/
│           ├── widgets/
│           └── providers/
├── shared/              # Shared widgets, utilities
│   └── widgets/
└── main.dart
```

---

## 6. Key Code Files (Absolute Paths)

### Core Engine
- `/Users/thanhpham/Documents/1-projects/personal/get_cli_1/lib/core/generator.dart` (94 lines) - DexCli command dispatcher
- `/Users/thanhpham/Documents/1-projects/personal/get_cli_1/lib/core/structure.dart` (142 lines) - Path management
- `/Users/thanhpham/Documents/1-projects/personal/get_cli_1/lib/commands/interface/command.dart` (67 lines) - Command base class

### Command Implementations
- `/Users/thanhpham/Documents/1-projects/personal/get_cli_1/lib/commands/impl/create/feature/feature.dart` (123 lines)
- `/Users/thanhpham/Documents/1-projects/personal/get_cli_1/lib/commands/impl/create/project/project.dart` (76 lines)
- `/Users/thanhpham/Documents/1-projects/personal/get_cli_1/lib/commands/impl/create/provider/provider.dart` (47 lines)

### Template System
- `/Users/thanhpham/Documents/1-projects/personal/get_cli_1/lib/samples/interface/sample_interface.dart` (37 lines)
- `/Users/thanhpham/Documents/1-projects/personal/get_cli_1/lib/samples/impl/riverpod_clean/riverpod_clean_samples.dart` (21 lines, barrel export)
- `/Users/thanhpham/Documents/1-projects/personal/get_cli_1/lib/samples/impl/riverpod_clean/riverpod_provider.dart` (40 lines)
- `/Users/thanhpham/Documents/1-projects/personal/get_cli_1/lib/samples/impl/riverpod_clean/riverpod_entity.dart` (27 lines)

### Entry Point
- `/Users/thanhpham/Documents/1-projects/personal/get_cli_1/bin/dex.dart` (27 lines)

---

## 7. Documentation Status

### Existing Docs (in /docs/)
- `project-overview-pdr.md` - Project requirements
- `codebase-summary.md` - Module breakdown (comprehensive)
- `system-architecture.md` - Architecture diagrams
- `code-standards.md` - Coding conventions
- `project-roadmap.md` - Feature roadmap
- `README.md` - Overview links

### Documentation Quality
✓ Good: Codebase summary is detailed and well-structured
✓ Good: Architecture diagrams explain command flow
✓ Good: README has clear command examples
✗ Limited: Inline code comments minimal
✗ Limited: Template generation pipeline not fully documented

---

## 8. Key Design Patterns & Conventions

### 1. Command Pattern
- Each command is stateless (pure functionality)
- Hierarchical: CommandParent groups subcommands
- Validation happens before execution
- Async execution for I/O operations

### 2. Template Pattern (Sample Interface)
- Single responsibility: each Sample = one file type
- String interpolation for variable substitution
- ReCase library for consistent naming
- Deferred execution (create() method)

### 3. Riverpod @riverpod Code Generation
**CRITICAL MEMORY:** All generated Riverpod templates use `@riverpod` code generation, NEVER manual `Provider()`. Example:
```dart
@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  Future<List<User>> build() async { ... }
}
```

### 4. Freezed Code Generation
- All entities use `@freezed` with immutability
- Models have `.freezed.dart` and `.g.dart` parts
- `toEntity()` method maps models to domain entities

### 5. Structure Management
- Feature-first architecture: `lib/features/{name}/`
- Clean separation: data, domain, presentation
- Path helpers in `Structure` class for consistency
- Platform-aware paths (Windows/Unix)

---

## 9. Naming Conventions

| Context | Format | Example |
|---------|--------|---------|
| File names | snake_case | `user_entity.dart`, `login_provider.dart` |
| Class names | PascalCase | `UserEntity`, `LoginProvider` |
| Feature folders | snake_case | `lib/features/auth/`, `lib/features/user_profile/` |
| Entity classes | PascalCase | `User`, `Post`, `Comment` |
| Provider classes | {Name}Notifier | `UserNotifier`, `LoginNotifier` |
| Model classes | {Name}Model | `UserModel`, `PostModel` |

---

## 10. Codebase Statistics

| Metric | Value |
|--------|-------|
| Total Dart Files | 96 |
| Total LOC (lib) | 8,401 |
| Largest Module | common/ (4,317 LOC) |
| Commands Module | 1,594 LOC |
| Samples Module | 698 LOC |
| Functions Module | 880 LOC |
| Test Coverage | ~0.01% (minimal) |

---

## Summary

**Dex CLI** is a well-structured Flutter scaffolding tool with:
- **Clear command hierarchy** using the Command Pattern
- **Modular template system** via Sample interface with 20 concrete implementations
- **Riverpod + Clean Architecture focus** with @riverpod code generation
- **Good separation of concerns** (commands, functions, templates, utilities)
- **Comprehensive codebase docs** but lacking inline code comments
- **Feature-first project structure** with three-layer architecture

The template system is flexible, extensible, and follows consistent naming conventions across 698 lines of template code covering all major Clean Architecture layers.
