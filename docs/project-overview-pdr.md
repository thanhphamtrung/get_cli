# Get CLI - Project Overview & Product Development Requirements

## Executive Summary

**Get CLI** is the official command-line interface (CLI) for the GetX™ framework, enabling developers to rapidly scaffold and manage Flutter and GetX Server applications. It automates project structure initialization, boilerplate code generation, and project management tasks.

**Version:** 1.10.0
**Language:** Dart (SDK >=3.11.0 <4.0.0)
**Repository:** https://github.com/jonataslaw/get_cli
**License:** MIT

## Product Vision

Enable GetX framework developers to focus on business logic rather than boilerplate, reducing project setup time from hours to minutes and maintaining consistency across teams.

## Target Audience

- Flutter developers using GetX framework
- GetX Server developers
- Enterprise teams adopting GetX Pattern or CLEAN architecture
- Development teams requiring standardized project structures

## Key Features

### 1. Project Initialization
- Create new Flutter or GetX Server projects with one command
- Choose between two architecture patterns:
  - **GetX Pattern** (by Kauê) - modular approach with bindings
  - **CLEAN Architecture** (by Arktekko/Ekko) - layered separation of concerns

### 2. Code Generation
- **Pages/Screens:** Auto-generates controller, view, binding, and routes
- **Components:** Create controllers, views, providers independently
- **Models:** Generate Dart model classes from JSON (file or URL)
- **Localization:** Generate i18n files from JSON translations
- **Templates:** Support custom template files or remote templates (via URL)

### 3. Project Management
- **Package Management:** Install/remove dependencies with version control
- **Import Organization:** Sort imports and format Dart files
- **File Naming:** Configurable file separators (default: underscore)
- **Project Updates:** Self-update mechanism for the CLI tool

### 4. Internationalization
- Support for 8 languages: English, Portuguese (BR), Chinese (Simplified), German, French, Italian, Arabic, Turkish
- Extensible translation system for community contributions

## Architecture Overview

### Command Pattern Implementation

Get CLI uses the **Command Pattern** for modular command dispatching:

```
bin/get.dart (entry point)
    ↓
GetCli class (lib/core/generator.dart)
    ↓
findCommand() → recursive search
    ↓
Command.validate() → Command.execute()
```

### Command Hierarchy

```
get
  ├── create
  │   ├── project
  │   ├── page:name
  │   ├── screen:name
  │   ├── controller:name on [folder]
  │   ├── view:name on [folder]
  │   └── provider:name on [folder]
  ├── generate
  │   ├── locales assets/path
  │   └── model on folder with file.json
  ├── init
  ├── install package [--dev] [package:version]
  ├── remove package
  ├── sort path [--skipRename] [--relative]
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
| `lib/samples/` | Template implementations | ~604 |
| `lib/core/` | CLI engine & i18n | ~809 |
| `lib/extensions/` | Utility extensions | ~86 |

## Technical Requirements

### Functional Requirements

1. **FR-001:** CLI must support creating Flutter/GetX Server projects
2. **FR-002:** CLI must generate modular code (pages, screens, controllers, views)
3. **FR-003:** CLI must support two architecture patterns (GetX & CLEAN)
4. **FR-004:** CLI must handle package dependency management
5. **FR-005:** CLI must generate models from JSON schemas
6. **FR-006:** CLI must support project-specific configuration via pubspec.yaml
7. **FR-007:** CLI must provide help and version information

### Non-Functional Requirements

1. **NFR-001:** CLI must execute project creation within 30 seconds
2. **NFR-002:** CLI must support custom templates (local files or URLs)
3. **NFR-003:** CLI must provide clear error messages in 8 languages
4. **NFR-004:** CLI must be cross-platform (Windows, macOS, Linux)
5. **NFR-005:** CLI must maintain backward compatibility with existing projects

## Installation & Usage

### Installation

```bash
pub global activate get_cli
# OR
flutter pub global activate get_cli
```

### Quick Start

```bash
# Create new project
get create project

# Initialize existing project
get init

# Create page (GetX Pattern)
get create page:home

# Create screen (CLEAN)
get create screen:home

# Generate model from JSON
get generate model on home with assets/models/user.json

# Check version
get -v

# Get help
get help
```

## Configuration

Get CLI reads configuration from `pubspec.yaml`:

```yaml
get_cli:
  separator: "."           # File name separator (default: "_")
  sub_folder: false        # Flat hierarchy (default: true)
```

## Architecture Patterns Supported

### 1. GetX Pattern
- Modular structure with clear module boundaries
- Each module: `binding/`, `controller/`, `view/`
- Auto-route management
- Best for: Medium-to-large projects

### 2. CLEAN Architecture (Arktekko/Ekko)
- Layered architecture: presentation, domain, data
- Clear separation of concerns
- Recommended for: Enterprise applications

## Dependencies

- `dcli` - Terminal I/O & shell execution
- `dart_style` - Code formatting
- `http` - HTTP client (API calls)
- `recase` - Case conversion utilities
- `yaml` / `pubspec_parse` - YAML parsing
- `ansicolor` - Colored terminal output
- `process_run` - Process execution
- `intl` - Internationalization

## Success Metrics

- Users can create a project structure in <30 seconds
- Support for 8+ languages
- 96+ Dart files maintained across modules
- Active community contributions (multiple architecture patterns)

## Known Limitations & TODOs

- Only 1 unit test file in repository (test coverage needs improvement)
- Custom models not yet supported
- Generated structure quality could be improved
- No backup system for overwritten files

## Future Roadmap

1. **Phase 1:** Increase test coverage (target: >80%)
2. **Phase 2:** Add custom model support
3. **Phase 3:** Implement backup/recovery system
4. **Phase 4:** Add template marketplace
5. **Phase 5:** IDE plugin support

## Maintenance Notes

- CLI self-updates available via `get update` command
- pub.dev API integration for package management
- Active support for multiple GetX versions
- Community-driven architecture patterns

---

**Last Updated:** 2026-03-16
**Maintainer:** jonataslaw (GitHub)
**License:** MIT
