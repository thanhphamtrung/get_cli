# Dex CLI

Flutter CLI tool for scaffolding projects with **Riverpod + Clean Architecture**. Forked from [get_cli](https://github.com/jonataslaw/get_cli) and rewritten for the Riverpod ecosystem.

## Installation

```bash
# From source (recommended)
dart pub global activate -sgit https://github.com/thanhphamtrung/dex_cli

# Local development
dart pub global activate --source path .

# Native binary (fastest — no pub resolution on each run)
dart compile exe bin/dex.dart -o bin/dex
cp bin/dex /usr/local/bin/dex
```

## Commands

### Project & Init

```bash
dex create project           # Create new Flutter project with Riverpod Clean Architecture
dex init                     # Initialize Riverpod Clean Architecture in existing project
```

### Create Feature Modules

```bash
dex create feature:auth      # Full feature module (all 3 layers: data, domain, presentation)
dex create entity:user on auth       # Freezed entity in a feature's domain layer
dex create model:user on auth        # Freezed DTO model in a feature's data layer
dex create usecase:login on auth     # Use case in a feature's domain layer
dex create provider:auth on auth     # Riverpod provider
dex create datasource:auth on auth   # Remote datasource in a feature's data layer
dex create repository:auth on auth   # Repository interface + implementation
dex create page:home                 # Page (ConsumerWidget)
```

### Scaffold Features

```bash
dex scaffold theme               # Material 3 theme (dark/light mode, design tokens)
```

### Code Generation

```bash
dex build                    # Run build_runner (generates .g.dart, .freezed.dart)
dex watch                    # Run build_runner in watch mode
dex generate model on home with assets/models/user.json   # Freezed model from JSON
dex generate locales assets/locales                        # Translation classes from JSON
```

### Package Management

```bash
dex install http path        # Install packages
dex install path:1.6.4       # Specific version
dex install lints --dev      # Dev dependency
dex remove http              # Remove package
```

### Utilities

```bash
dex sort [path]              # Sort imports & format dart files
dex update                   # Update CLI
dex update --git             # Update from git source
dex --version                # Show version
dex help                     # Show help
```

## Configuration

Add to `pubspec.yaml`:

```yaml
dex_cli:
  separator: "."        # File separator (default: "_") → user.model.dart
  sub_folder: false     # Flat structure (default: true creates subdirectories)
```

## Architecture

Dex CLI generates a **Riverpod Clean Architecture** structure:

```
lib/
├── core/              # Shared utilities, theme, routing
├── features/
│   └── auth/
│       ├── data/      # Models, datasources, repository implementations
│       ├── domain/    # Entities, repository interfaces, use cases
│       └── presentation/  # Pages, providers
└── main.dart
```

## Documentation

- **[Project Overview](docs/project-overview-pdr.md)**
- **[Codebase Summary](docs/codebase-summary.md)**
- **[Code Standards](docs/code-standards.md)**
- **[System Architecture](docs/system-architecture.md)**
- **[Project Roadmap](docs/project-roadmap.md)**

## Support

- **Repository:** https://github.com/thanhphamtrung/dex_cli
- **Forked from:** https://github.com/jonataslaw/get_cli

**Current Version:** 0.0.2
