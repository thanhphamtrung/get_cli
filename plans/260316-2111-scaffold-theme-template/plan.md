---
title: "Add dex scaffold command with Theme/Settings template"
description: "New scaffold command with interactive wizard, starting with a Theme/Settings feature template"
status: pending
priority: P1
effort: 6h
branch: master
tags: [scaffold, theme, feature-template, cli]
created: 2026-03-16
---

# dex scaffold — Theme/Settings Feature Template

## Goal
Add `dex scaffold` as a new top-level command that generates complete, working feature modules across all Clean Architecture layers. First template: Theme/Settings (dark/light mode with SharedPreferences persistence).

## Architecture Decision
- `scaffold` is a **top-level command** (like `create`, `generate`, `install`) — NOT a subcommand of `create`
- Reason: `create` generates empty structural templates; `scaffold` generates pre-built business logic
- `scaffold` uses `CommandParent` with child commands per template (e.g., `ScaffoldThemeCommand`)
- Extensible: adding auth/FCM later = just add new child command + sample files

## Phases

| # | Phase | Status | Effort | File |
|---|-------|--------|--------|------|
| 1 | Theme/Settings Sample Templates | pending | 2.5h | [phase-01](phase-01-theme-sample-templates.md) |
| 2 | Scaffold Command Infrastructure | pending | 1.5h | [phase-02](phase-02-scaffold-command-infrastructure.md) |
| 3 | Dependency Auto-Install & Post-Gen | pending | 1h | [phase-03](phase-03-dependency-auto-install.md) |
| 4 | Help, Docs & README Update | pending | 1h | [phase-04](phase-04-help-docs-readme.md) |

## Key Dependencies
- dcli (already installed) — interactive prompts
- recase (already installed) — naming conventions
- SharedPreferences — auto-added to user's pubspec.yaml during scaffold

## Generated Output (user's project)
```
lib/features/theme/
  data/
    datasources/theme_local_datasource.dart
    repositories/theme_repository_impl.dart
  domain/
    entities/theme_entity.dart
    repositories/theme_repository.dart
    usecases/get_theme_usecase.dart
    usecases/set_theme_usecase.dart
  presentation/
    providers/theme_provider.dart
    pages/settings_page.dart
```

## Files to Create in Dex CLI
- `lib/samples/impl/scaffold/` — new directory for scaffold templates
- `lib/samples/impl/scaffold/theme/` — theme-specific templates (8 files)
- `lib/samples/impl/scaffold/scaffold_samples.dart` — barrel export
- `lib/commands/impl/scaffold/scaffold.dart` — ScaffoldCommandParent
- `lib/commands/impl/scaffold/theme/theme.dart` — ScaffoldThemeCommand

## Files to Modify in Dex CLI
- `lib/commands/commands_list.dart` — register scaffold command
- `lib/commands/impl/commads_export.dart` — export new commands
- `lib/samples/impl/riverpod_clean/riverpod_clean_samples.dart` — export scaffold barrel
- `README.md` — document new command
