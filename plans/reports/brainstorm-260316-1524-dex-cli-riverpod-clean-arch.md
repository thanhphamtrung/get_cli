# Brainstorm: `dex` CLI — Flutter Clean Architecture Scaffolding Tool

**Date:** 2026-03-16 | **Status:** Agreed | **Type:** Brainstorm Summary

---

## Problem Statement

Fork `get_cli` into `dex` — a rebranded, opinionated CLI tool for scaffolding Flutter projects with Clean Architecture + Riverpod. Internal team tool. Full scaffolding: project init, feature modules, model generation, route registration.

### Requirements
- **CLI name:** `dex`
- **Architecture:** Reso Coder-style Clean Architecture (feature-first)
- **State management:** Riverpod only (code-generated `@riverpod`)
- **DI:** Riverpod providers (no get_it/injectable)
- **Routing:** GoRouter with Riverpod auth guards
- **Templates:** Hardcoded Dart strings (same approach as get_cli)
- **Audience:** Internal team only (can be opinionated)

---

## Agreed Package Stack

### Dependencies
| Package | Purpose |
|---------|---------|
| `flutter_riverpod` | State management + DI |
| `riverpod_annotation` | `@riverpod` code generation annotations |
| `dio` | HTTP client |
| `go_router` | Declarative routing |
| `freezed_annotation` | Immutable models |
| `json_annotation` | JSON serialization |
| `fpdart` | `Either<Failure, T>` for domain layer |
| `pretty_dio_logger` | HTTP request logging |
| `envied` | Environment variable management |
| `flutter_secure_storage` | Secure token storage |
| `shared_preferences` | Key-value local storage |

### Dev Dependencies
| Package | Purpose |
|---------|---------|
| `build_runner` | Code generation runner |
| `riverpod_generator` | Generates providers from `@riverpod` |
| `freezed` | Generates immutable classes |
| `json_serializable` | Generates fromJson/toJson |
| `envied_generator` | Generates env var access |

---

## Agreed Architecture: Reso Coder Feature-First

### Generated Project Structure

```
lib/
├── core/
│   ├── error/
│   │   ├── failures.dart            # Failure sealed class
│   │   └── exceptions.dart          # Server/Cache exceptions
│   ├── network/
│   │   ├── dio_client.dart          # Dio singleton provider
│   │   └── interceptors/
│   │       ├── auth_interceptor.dart
│   │       └── logging_interceptor.dart
│   ├── router/
│   │   ├── app_router.dart          # GoRouter config + auth guard
│   │   └── route_names.dart         # Route name constants
│   ├── config/
│   │   └── env.dart                 # Envied environment vars
│   ├── usecases/
│   │   └── usecase.dart             # Abstract UseCase<Type, Params>
│   └── providers/
│       └── core_providers.dart      # Shared providers (Dio, storage, etc.)
├── features/
│   └── {feature_name}/
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── {name}_remote_datasource.dart
│       │   │   └── {name}_local_datasource.dart
│       │   ├── models/
│       │   │   └── {name}_model.dart    # Freezed DTO + toEntity()
│       │   └── repositories/
│       │       └── {name}_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── {name}.dart          # Freezed domain entity
│       │   ├── repositories/
│       │   │   └── {name}_repository.dart  # Abstract interface
│       │   └── usecases/
│       │       └── get_{name}.dart       # UseCase implementation
│       └── presentation/
│           ├── providers/
│           │   └── {name}_provider.dart  # @riverpod AsyncNotifier
│           ├── pages/
│           │   └── {name}_page.dart
│           └── widgets/
├── shared/
│   ├── widgets/                     # Reusable UI components
│   └── extensions/                  # Dart extensions
└── main.dart                        # ProviderScope + GoRouter
```

---

## CLI Commands Design

### Project Init
```bash
dex create project              # Uses folder name
dex create project:my_app       # Custom name
dex init                        # Init existing Flutter project
```

### Feature Generation (FULL CRUD)
```bash
dex create feature:auth
# Generates ALL layers:
# features/auth/data/datasources/auth_remote_datasource.dart
# features/auth/data/models/auth_model.dart
# features/auth/data/repositories/auth_repository_impl.dart
# features/auth/domain/entities/auth.dart
# features/auth/domain/repositories/auth_repository.dart
# features/auth/domain/usecases/get_auth.dart
# features/auth/presentation/providers/auth_provider.dart
# features/auth/presentation/pages/auth_page.dart
# + Auto-registers route in app_router.dart
```

### Individual Component Generation
```bash
dex create entity:user on auth           # Domain entity only
dex create model:user on auth            # Data model (DTO) only
dex create usecase:login on auth         # UseCase only
dex create provider:auth on auth         # Riverpod provider only
dex create page:login on auth            # Page + route registration
dex create datasource:auth on auth       # Remote datasource
dex create repository:auth on auth       # Both abstract + impl
```

### Model from JSON
```bash
dex generate model on auth with assets/models/user.json
dex generate model on auth from "https://api.example.com/user"
```

### Package Management (keep from get_cli)
```bash
dex install dio go_router
dex remove http
```

### Code Generation Runner
```bash
dex build          # Runs build_runner build --delete-conflicting-outputs
dex watch          # Runs build_runner watch
```

### Utilities (keep from get_cli)
```bash
dex sort [path]    # Sort imports
dex update         # Update CLI
dex -v             # Version
dex help           # Help
```

---

## Key Template Samples

### Entity Template (Freezed)
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '{name}.freezed.dart';

@freezed
class {Name} with _${Name} {
  const factory {Name}({
    required String id,
  }) = _{Name};
}
```

### Model/DTO Template (Freezed + JSON)
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/{name}.dart';

part '{name}_model.freezed.dart';
part '{name}_model.g.dart';

@freezed
class {Name}Model with _${Name}Model {
  const {Name}Model._();

  const factory {Name}Model({
    required String id,
  }) = _{Name}Model;

  factory {Name}Model.fromJson(Map<String, dynamic> json) =>
      _${Name}ModelFromJson(json);

  {Name} toEntity() => {Name}(id: id);
}
```

### Repository Interface Template
```dart
import 'package:fpdart/fpdart.dart';
import '../entities/{name}.dart';
import '../../../../core/error/failures.dart';

abstract class {Name}Repository {
  Future<Either<Failure, List<{Name}>>> getAll();
  Future<Either<Failure, {Name}>> getById(String id);
  Future<Either<Failure, Unit>> create({Name} entity);
  Future<Either<Failure, Unit>> update({Name} entity);
  Future<Either<Failure, Unit>> delete(String id);
}
```

### Repository Impl Template
```dart
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/{name}.dart';
import '../../domain/repositories/{name}_repository.dart';
import '../datasources/{name}_remote_datasource.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class {Name}RepositoryImpl implements {Name}Repository {
  final {Name}RemoteDataSource remoteDataSource;

  {Name}RepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<{Name}>>> getAll() async {
    try {
      final result = await remoteDataSource.getAll();
      return Right(result.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
  // ... other CRUD methods
}
```

### Provider Template (@riverpod AsyncNotifier)
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/{name}.dart';
import '../../domain/usecases/get_{name}.dart';

part '{name}_provider.g.dart';

@riverpod
class {Name}Notifier extends _${Name}Notifier {
  @override
  Future<List<{Name}>> build() async {
    final usecase = ref.watch(get{Name}UseCaseProvider);
    final result = await usecase.call();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (data) => data,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }
}
```

### Page Template
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/{name}_provider.dart';

class {Name}Page extends ConsumerWidget {
  const {Name}Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch({name}NotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('{Name}')),
      body: state.when(
        data: (data) => Center(child: Text('${data.length} items')),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
```

### UseCase Template
```dart
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/{name}.dart';
import '../repositories/{name}_repository.dart';

class Get{Name} implements UseCase<List<{Name}>, NoParams> {
  final {Name}Repository repository;

  Get{Name}(this.repository);

  @override
  Future<Either<Failure, List<{Name}>>> call(NoParams params) {
    return repository.getAll();
  }
}
```

### GoRouter Template (with auth guard)
```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'route_names.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(ref) {
  return GoRouter(
    initialLocation: RouteNames.home,
    routes: [
      // Routes auto-registered by dex CLI
    ],
  );
}
```

---

## Evaluated Approaches

### Approach 1: Strip GetX, Rebuild Templates (RECOMMENDED)
**Pros:**
- Reuses proven CLI engine (command parsing, file ops, logging)
- Already supports multi-pattern (GetX + CLEAN); just add Riverpod pattern
- Existing route management, model generation, package installer
- Fast to ship — ~60% of CLI code is reusable

**Cons:**
- Must audit every file for GetX-specific assumptions
- Route insertion logic is fragile (line-based parsing) — inherited tech debt
- Template system is hardcoded strings — works but not elegant

### Approach 2: Build from Scratch with Mason
**Pros:**
- Clean slate, no tech debt
- Mason is purpose-built for template generation
- External templates are easier to maintain

**Cons:**
- Rebuilds what already works (command parsing, file ops, etc.)
- Mason is more verbose for complex multi-file generation
- Loses model-from-JSON, package management, import sorting

### Approach 3: Wrap Mason + Custom CLI
**Pros:**
- Best of both: Mason templates + custom command layer
- Template editing doesn't require recompilation

**Cons:**
- Two systems to maintain
- Added dependency (Mason)
- Overengineered for internal team tool

### Decision: **Approach 1** — strip and rebuild on existing get_cli fork.

**Rationale:** 60% of CLI code is framework-agnostic (command engine, file ops, model generation, package management). Rewriting from scratch would waste effort. The line-based route parsing is a known risk but acceptable for an internal tool where generated code follows a predictable format.

---

## Implementation Strategy (High-Level Phases)

### Phase 1: Rebrand + Strip GetX
- Rename binary from `get` to `dex`
- Remove GetX Pattern samples (`lib/samples/impl/getx_pattern/`)
- Remove GetX-specific init (`init_getxpattern.dart`)
- Update pubspec.yaml, README, translations
- Keep: command engine, file operations, model generation, package management, logger

### Phase 2: Core Templates
- Create `lib/samples/impl/riverpod_clean/` directory
- Implement core templates: main.dart, app_router, failures, exceptions, env, dio_client, usecase base
- Implement `dex create project` → generates full project skeleton
- Implement `dex init` → initializes existing project with Clean Arch structure

### Phase 3: Feature Scaffolding
- Implement `dex create feature:{name}` → generates all 3 layers
- Implement individual generators (entity, model, usecase, provider, page, datasource, repository)
- Auto-register routes in app_router.dart
- Auto-register providers

### Phase 4: Code Generation Helpers
- Implement `dex build` → runs build_runner
- Implement `dex watch` → runs build_runner watch
- Adapt JSON model generation for Freezed output (instead of plain Dart classes)

### Phase 5: Polish
- Update translations/localizations
- Update help text and CLI output
- Test all commands end-to-end
- Update documentation

---

## Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Route insertion breaks on reformatted files | Medium | Generate predictable format; document "don't reformat app_router.dart manually" |
| build_runner slow with many providers | Low | Provide `dex watch` for incremental builds |
| Riverpod API changes in future versions | Medium | Pin Riverpod version in generated pubspec; update CLI when needed |
| fpdart Either adds complexity | Low | Optional: make fpdart usage configurable via dex config |
| Hardcoded templates become stale | Medium | Version templates; update with each CLI release |

---

## Success Metrics

- [ ] `dex create project` generates compilable project with `flutter analyze` passing
- [ ] `dex create feature:auth` generates all 11 files across 3 layers
- [ ] Generated code passes `dart format` and `dart analyze` with zero warnings
- [ ] `dex build` successfully runs build_runner on generated project
- [ ] Team can scaffold a new feature in < 30 seconds
- [ ] Generated tests pass out of the box

---

## What to Keep from get_cli

| Component | Keep? | Notes |
|-----------|-------|-------|
| Command engine (`lib/core/generator.dart`) | YES | Framework-agnostic |
| Command pattern (`lib/commands/`) | YES | Restructure for new commands |
| File operations (`lib/functions/create/`) | YES | Reusable |
| Model from JSON (`lib/common/utils/json_serialize/`) | YES | Adapt output to Freezed format |
| Package management (`install/remove`) | YES | Framework-agnostic |
| Import sorter | YES | Useful utility |
| Logger | YES | Reusable |
| CLI config | YES | Extend for dex-specific settings |
| GetX Pattern samples | NO | Remove entirely |
| Arktekko/CLEAN samples | PARTIAL | Keep structure, replace templates |
| GetX-specific routes (`get_add_route.dart`) | REWRITE | Adapt for GoRouter |
| Binding system | NO | Replace with Riverpod providers |
| i18n/translations | YES | Update strings |

---

## Unresolved Questions

1. Should `dex` support multiple architecture variants (feature-first vs layer-first) or just Reso Coder style?
2. Should generated tests be unit tests only, or include widget test scaffolding too?
3. Should `dex create feature` also generate a test directory mirror (test/features/auth/...)?
4. How should shared/cross-feature providers be organized? (core/providers/ vs shared/providers/)
5. Should `dex` generate `.env.example` file during project init?

---

**Report by:** Brainstorm session | **Next:** Create implementation plan if approved
