# Dex CLI - Project Overview & Product Development Requirements

## Executive Summary

**Dex CLI** is a powerful command-line interface (CLI) for scaffolding Flutter projects with **Riverpod + Clean Architecture**. Forked from the original Get CLI and completely rewritten, Dex CLI automates project structure initialization, boilerplate code generation, and project management tasks specifically for the Riverpod ecosystem.

**Version:** 0.0.2
**Language:** Dart (SDK >=3.11.0 <4.0.0)
**Repository:** https://github.com/thanhphamtrung/dex_cli
**License:** MIT

## Product Vision

Enable Flutter developers using Riverpod and Clean Architecture to focus on business logic rather than boilerplate, reducing project setup time from hours to minutes and maintaining consistency across teams.

## Target Audience

- Flutter developers adopting Riverpod for state management
- Teams standardizing on Clean Architecture patterns
- Enterprise teams requiring scalable, layered project structures
- Development teams enforcing consistent code generation standards

## Key Features

### 1. Project Initialization
- Create new Flutter projects with Riverpod Clean Architecture in one command
- Initialize Riverpod structure in existing projects
- Generate complete feature modules with all three layers (data, domain, presentation)

### 2. Feature Generation
- **Feature Modules:** Create complete features with data, domain, and presentation layers
- **Entities:** Freezed domain entities for type-safe data models
- **Models:** Freezed DTOs for data layer with JSON serialization
- **Use Cases:** Domain layer business logic templates
- **Riverpod Providers:** Auto-generated providers with @riverpod code generation
- **Datasources:** Remote and local datasource templates
- **Repositories:** Repository interfaces and implementations
- **Pages:** ConsumerWidget pages integrated with Riverpod

### 3. Code Generation
- **Models from JSON:** Generate Freezed models from JSON schemas (file or inline)
- **Localization:** Generate i18n translation classes from JSON
- **Build Runner Integration:** Seamless build_runner support for code generation

### 4. Project Management
- **Package Management:** Install/remove dependencies with version pinning
- **Import Organization:** Sort imports and format Dart files
- **File Naming:** Configurable file separators (default: underscore)
- **CLI Updates:** Self-update mechanism for the CLI tool

### 5. Internationalization
- Support for 8 languages: English, Portuguese (BR), Chinese (Simplified), German, French, Italian, Arabic, Turkish
- Extensible translation system for community contributions

## Architecture Overview

### Command Pattern Implementation

Dex CLI uses the **Command Pattern** for modular command dispatching:

```
bin/dex.dart (entry point)
    ↓
GetCli class (lib/core/generator.dart)
    ↓
findCommand() → recursive search
    ↓
Command.validate() → Command.execute()
```

### Command Hierarchy

```
dex
  ├── create
  │   ├── project
  │   ├── feature:name
  │   ├── entity:name on feature
  │   ├── model:name on feature
  │   ├── usecase:name on feature
  │   ├── provider:name on feature
  │   ├── datasource:name on feature
  │   ├── repository:name on feature
  │   └── page:name
  ├── generate
  │   ├── locales assets/path
  │   └── model on folder with file.json
  ├── init
  ├── install package [--dev] [package:version]
  ├── remove package
  ├── sort path [--skipRename] [--relative]
  ├── build
  ├── watch
  ├── update (or upgrade)
  ├── help
  └── -v (or -version)
```

### Key Components

| Component | Purpose | LOC |
|-----------|---------|-----|
| `lib/commands/` | Command implementations | ~1,594 |
| `lib/common/` | Core utilities & services | ~4,317 |
| `lib/functions/` | File/project manipulation | ~880 |
| `lib/samples/` | Template implementations (Riverpod) | ~604 |
| `lib/core/` | CLI engine & i18n | ~809 |
| `lib/extensions/` | Utility extensions | ~86 |

## Technical Requirements

### Functional Requirements

1. **FR-001:** CLI must support creating Flutter projects with Riverpod Clean Architecture
2. **FR-002:** CLI must generate complete feature modules (all three layers)
3. **FR-003:** CLI must support Riverpod code generation via @riverpod annotation
4. **FR-004:** CLI must handle package dependency management
5. **FR-005:** CLI must generate Freezed entities and models from JSON schemas
6. **FR-006:** CLI must support project-specific configuration via pubspec.yaml
7. **FR-007:** CLI must provide help and version information
8. **FR-008:** CLI must support build_runner integration (build/watch commands)

### Non-Functional Requirements

1. **NFR-001:** CLI must execute project creation within 30 seconds
2. **NFR-002:** CLI must generate code following Dart formatting standards
3. **NFR-003:** CLI must provide clear error messages in 8 languages
4. **NFR-004:** CLI must be cross-platform (Windows, macOS, Linux)
5. **NFR-005:** CLI must maintain backward compatibility within major version

## Installation & Usage

### Installation

```bash
# From source (recommended)
dart pub global activate -sgit https://github.com/thanhphamtrung/dex_cli

# Local development
dart pub global activate --source path .

# Native binary (fastest)
dart compile exe bin/dex.dart -o bin/dex
cp bin/dex /usr/local/bin/dex
```

### Quick Start

```bash
# Create new project
dex create project

# Initialize existing project
dex init

# Create feature module (all 3 layers)
dex create feature:auth

# Create entity (domain layer)
dex create entity:user on auth

# Create Riverpod provider
dex create provider:auth on auth

# Generate model from JSON
dex generate model on auth with assets/models/user.json

# Run code generation
dex build
dex watch

# Check version
dex --version

# Get help
dex help
```

## Configuration

Dex CLI reads configuration from `pubspec.yaml`:

```yaml
dex_cli:
  separator: "."           # File name separator (default: "_")
  sub_folder: true         # Create subdirectories (default: true)
```

## Architecture Pattern: Riverpod + Clean Architecture

Dex CLI generates projects following **Riverpod + Clean Architecture** pattern:

```
lib/
├── core/                      # Shared utilities, themes, routing
├── features/
│   └── auth/
│       ├── data/              # Models, datasources, repository impl
│       │   ├── datasources/
│       │   ├── models/        # Freezed DTOs
│       │   └── repositories/
│       ├── domain/            # Entities, repo interfaces, use cases
│       │   ├── entities/      # Freezed entities
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/      # Pages, providers
│           ├── pages/         # ConsumerWidget pages
│           └── providers/     # @riverpod providers
└── main.dart
```

## Dependencies

- `riverpod` - State management
- `freezed_annotation` / `freezed` - Code generation for models/entities
- `dcli` - Terminal I/O & shell execution
- `dart_style` - Code formatting
- `http` - HTTP client (API calls)
- `recase` - Case conversion utilities
- `yaml` / `pubspec_parse` - YAML parsing
- `ansicolor` - Colored terminal output
- `process_run` - Process execution
- `intl` - Internationalization

## Success Metrics

- Users can create a complete feature in <30 seconds
- Support for 8+ languages
- 96+ Dart files maintained across modules
- Clean Architecture with proper layer separation
- Riverpod code generation best practices enforced

## Known Limitations & TODOs

- Limited test coverage (0.01% - only 1 test file)
- IDE plugin support not yet available
- Template marketplace not yet available
- Backup system for file operations not yet implemented

## Future Roadmap

1. **Phase 1:** Riverpod + Clean Architecture foundation (✓ Complete - v0.0.2)
2. **Phase 2:** Increase test coverage (target: >80%)
3. **Phase 3:** Add custom model support
4. **Phase 4:** Implement backup/recovery system
5. **Phase 5:** Add template marketplace
6. **Phase 6:** IDE plugin support

## Maintenance Notes

- CLI self-updates available via `dex update` command
- pub.dev API integration for package management
- Active support for latest Riverpod version
- Freezed code generation required for entities/models
- Build runner required for @riverpod code generation

---

**Last Updated:** 2026-03-16
**Maintainer:** thanhphamtrung (GitHub)
**Repository Fork:** Forked from jonataslaw/get_cli
**License:** MIT
