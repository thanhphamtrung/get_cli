###### Documentation Languages

| [pt_BR](README-pt_BR.md) | en_US | [zh_CN](README-zh_CN.md) |
|---|---|---|

**Official CLI for the GetX™ framework** — Scaffold Flutter and GetX Server projects in seconds with modern architecture patterns.

## Quick Start

### Installation

```bash
# Via Dart
pub global activate get_cli

# Via Flutter
flutter pub global activate get_cli
```

### Create New Project

```bash
get create project              # Uses folder name
get create project:my_app       # Custom name
get create project:"my cool app" # Name with spaces
```

### Initialize Existing Project

```bash
get init                        # Choose: GetX Pattern or CLEAN
```

### Create Pages/Screens

```bash
# GetX Pattern - Pages with module structure
get create page:home

# CLEAN Architecture - Screens
get create screen:home

# In specific module
get create page:home on modules
```

### Create Components

```bash
get create controller:user on home
get create view:profile on home
get create provider:auth on home
```

### Generate Code

```bash
# Models from JSON (file)
get generate model on home with assets/models/user.json

# Models from JSON (URL)
get generate model on home from "https://api.github.com/users/CpdnCristiano"

# Models without provider
get generate model on home with assets/models/user.json --skipProvider

# Localization from JSON
get generate locales assets/locales
```

### Package Management

```bash
get install http path camera          # Install multiple
get install path:1.6.4                # Specific version
get install flutter_launcher_icons --dev  # Dev dependency
get remove http                       # Remove package
```

### Utilities

```bash
get sort [path]           # Sort imports & format
get sort [path] --relative # Use relative imports
get update                # Update CLI (or 'upgrade')
get -v                    # Show version
get help                  # Show help
```

## Core Features

### 1. Project Creation

Create Flutter or GetX Server projects with automatic structure initialization. Choose between **GetX Pattern** (modular) or **CLEAN Architecture** (layered).

### 2. Code Generation

Generate pages, screens, controllers, views, and providers with automatic route management and dependency injection setup.

### 3. Model Generation

Create Dart models from JSON files or URLs with full `fromJson()` and `toJson()` support. Null-safe with proper type inference.

### 4. Localization

Generate translation classes from JSON files. Support for 8 languages with automatic type-safe constants.

### 5. Package Management

Install/remove pub.dev packages with version control and dependency resolution.

### 6. Code Organization

Sort imports and format Dart files with configurable separators and relative import support.

## Configuration

### File Naming Separator

Default: `_` → `my_controller_controller.dart`

Custom: `.` → `my_controller.controller.dart`

```yaml
get_cli:
  separator: "."
```

### Directory Structure

Default: Create bindings/, controllers/, views/ subfolders

Flat: All files in module root

```yaml
get_cli:
  sub_folder: false
```

## Advanced Features

### Custom Templates

Create controllers, views, or providers from local files or URLs:

```bash
get create controller:auth with examples/auth_controller.dart on your_folder
get create controller:api with 'https://example.com/templates/api_controller.dart' on home
```

Template syntax uses `@variable_name` placeholders:

```dart
@import

class @controller extends GetxController {
  final email = ''.obs;
  final password = ''.obs;

  void login() {}
}
```

### Localization Example

Create JSON files in `assets/locales/`:

**en_US.json**
```json
{
  "buttons": {
    "login": "Login",
    "logout": "Logout"
  }
}
```

**pt_BR.json**
```json
{
  "buttons": {
    "login": "Entrar",
    "logout": "Sair"
  }
}
```

Generate:
```bash
get generate locales assets/locales
```

Output includes type-safe `LocaleKeys` and `Locales` classes.

### Model Generation Example

**assets/models/user.json**
```json
{
  "name": "",
  "age": 0,
  "friends": ["", ""]
}
```

Generate:
```bash
get generate model on home with assets/models/user.json
```

Creates `user_model.dart` with constructors, `fromJson()`, and `toJson()`.

## Contributing

### Adding Translations

1. Create JSON file in `translations/` folder
2. Copy keys from `translations/en.json`
3. Translate values
4. Submit PR

## Documentation

- **[Project Overview](docs/project-overview-pdr.md)** — Vision, features, and requirements
- **[Codebase Summary](docs/codebase-summary.md)** — Architecture and module breakdown
- **[Code Standards](docs/code-standards.md)** — Dart conventions and patterns
- **[System Architecture](docs/system-architecture.md)** — Design and data flow
- **[Project Roadmap](docs/project-roadmap.md)** — Future plans and timeline

## Support

- **Repository:** https://github.com/jonataslaw/get_cli
- **pub.dev:** https://pub.dev/packages/get_cli
- **GetX Framework:** https://github.com/jonataslaw/getx

## Status & Roadmap

**Current Version:** 1.10.0
**Status:** Active maintenance with planned improvements

Next phases:
- Test coverage expansion (Phase 2)
- Custom model support (Phase 3)
- Backup & recovery system (Phase 4)
- Template marketplace (Phase 5)
- IDE plugins (Phase 6)

See [Project Roadmap](docs/project-roadmap.md) for details.
