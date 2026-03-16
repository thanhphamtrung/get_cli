# Phase 3: Feature Scaffolding

## Overview
- **Priority:** P0
- **Status:** completed
- **Effort:** High (~4-5 hours)
- **Description:** Implement `dex create feature:{name}` and individual component generators

## Context
- Depends on: Phase 2 (core templates exist)
- Templates from Phase 2 are reused here for per-component generation

## Requirements

### Functional
- `dex create feature:auth` generates ALL 11 files across 3 layers
- Individual generators work standalone:
  - `dex create entity:user on auth`
  - `dex create model:user on auth`
  - `dex create usecase:login on auth`
  - `dex create provider:auth on auth`
  - `dex create page:login on auth`
  - `dex create datasource:auth on auth`
  - `dex create repository:auth on auth`
- `on` flag specifies target feature module
- Duplicate detection (warn if file exists, offer overwrite/skip/rename)

### Non-Functional
- Generated files follow naming conventions: snake_case files, PascalCase classes
- Correct import paths between layers
- `part` directives for code generation files

## Related Code Files

### Existing Commands to Modify
- `lib/commands/impl/create/page/page.dart` — rewrite for ConsumerWidget + feature path
- `lib/commands/impl/create/controller/controller.dart` → rewrite as provider creator
- `lib/commands/impl/create/view/view.dart` → rewrite as page creator (or merge with page)
- `lib/commands/impl/create/provider/provider.dart` → rewrite for Riverpod @riverpod provider

### New Commands to Create
- `lib/commands/impl/create/feature/feature.dart` — orchestrates full feature generation
- `lib/commands/impl/create/entity/entity.dart` — domain entity (Freezed)
- `lib/commands/impl/create/model/model.dart` — data model/DTO (Freezed + JSON)
- `lib/commands/impl/create/usecase/usecase.dart` — domain use case
- `lib/commands/impl/create/datasource/datasource.dart` — remote/local datasource
- `lib/commands/impl/create/repository/repository.dart` — interface + impl pair

### Files to Modify
- `lib/commands/impl/commads_export.dart` — register new commands
- `lib/core/generator.dart` — add new commands to command tree
- `lib/core/structure.dart` — feature-first path resolution

## Architecture

### Command Tree (Updated)
```
dex
├── create
│   ├── project      (existing, modified)
│   ├── feature      (NEW — generates all layers)
│   ├── entity       (NEW)
│   ├── model        (NEW)
│   ├── usecase      (NEW)
│   ├── provider     (REWRITE — Riverpod @riverpod)
│   ├── page         (REWRITE — ConsumerWidget)
│   ├── datasource   (NEW)
│   └── repository   (NEW — interface + impl)
├── generate
│   ├── model        (existing, adapt for Freezed)
│   └── locales      (existing, keep)
├── init             (existing, modified)
├── install          (existing, keep)
├── remove           (existing, keep)
├── sort             (existing, keep)
├── build            (NEW — Phase 6)
├── update           (existing, keep)
└── help             (existing, keep)
```

### Feature Generation Flow
```
dex create feature:auth
  ├── Create features/auth/ directory tree
  ├── Generate domain/entities/auth.dart (Freezed entity)
  ├── Generate domain/repositories/auth_repository.dart (abstract)
  ├── Generate domain/usecases/get_auth.dart (UseCase)
  ├── Generate data/models/auth_model.dart (Freezed DTO)
  ├── Generate data/datasources/auth_remote_datasource.dart
  ├── Generate data/repositories/auth_repository_impl.dart
  ├── Generate presentation/providers/auth_provider.dart (@riverpod)
  ├── Generate presentation/pages/auth_page.dart (ConsumerWidget)
  ├── Register route in core/router/app_router.dart (Phase 4)
  └── Log success
```

## Implementation Steps

### Step 1: Create Feature Command
`lib/commands/impl/create/feature/feature.dart`:
- Parse feature name from args
- Create directory tree: `features/{name}/data/{datasources,models,repositories}`, `domain/{entities,repositories,usecases}`, `presentation/{providers,pages,widgets}`
- Call each sub-generator in sequence
- Auto-register route (delegates to Phase 4 logic)

### Step 2: Create Individual Component Commands
Each command:
1. Parse name + `on` flag (target feature)
2. Resolve file path using `Structure`
3. Check for existing file (duplicate detection)
4. Generate from template (using Sample subclass from Phase 2)
5. Create file via `createSingleFile()`
6. Add exports if needed
7. Log success

**Entity** → `features/{feature}/domain/entities/{name}.dart`
**Model** → `features/{feature}/data/models/{name}_model.dart`
**UseCase** → `features/{feature}/domain/usecases/get_{name}.dart`
**Provider** → `features/{feature}/presentation/providers/{name}_provider.dart`
**Page** → `features/{feature}/presentation/pages/{name}_page.dart`
**DataSource** → `features/{feature}/data/datasources/{name}_remote_datasource.dart`
**Repository** → generates BOTH:
  - `features/{feature}/domain/repositories/{name}_repository.dart` (interface)
  - `features/{feature}/data/repositories/{name}_repository_impl.dart` (implementation)

### Step 3: Update Command Tree
In `generator.dart`, register new commands in the command tree:
```dart
'create': CommandParent([
  'feature': CreateFeatureCommand(),
  'entity': CreateEntityCommand(),
  'model': CreateModelCommand(),
  'usecase': CreateUseCaseCommand(),
  'provider': CreateProviderCommand(),
  'page': CreatePageCommand(),
  'datasource': CreateDataSourceCommand(),
  'repository': CreateRepositoryCommand(),
  'project': CreateProjectCommand(),
]),
```

### Step 4: Update Structure for Feature Paths
Add methods to resolve feature-relative paths:
```dart
static FileModel featureModel(String featureName, String componentType, String name) {
  // Returns correct path within feature directory
}
```

### Step 5: Cross-Layer Import Resolution
Templates must generate correct relative imports:
- Provider imports UseCase: `import '../../domain/usecases/get_{name}.dart';`
- UseCase imports Repository: `import '../repositories/{name}_repository.dart';`
- RepositoryImpl imports DataSource: `import '../datasources/{name}_remote_datasource.dart';`
- RepositoryImpl imports Repository interface: `import '../../domain/repositories/{name}_repository.dart';`
- Model imports Entity: `import '../../domain/entities/{name}.dart';`

### Step 6: Verify
1. `dex create feature:auth` — all 9 files generated
2. `dex create entity:user on auth` — single file in correct location
3. All generated imports resolve correctly
4. `flutter analyze` passes on project with generated feature

## Todo List
- [x] Create feature/feature.dart command
- [x] Create entity/entity.dart command
- [x] Create model/model.dart command (DTO)
- [x] Create usecase/usecase.dart command
- [x] Create provider/provider.dart command (@riverpod AsyncNotifier)
- [x] Create page/page.dart command (ConsumerWidget)
- [x] Create datasource/datasource.dart command
- [x] Create repository/repository.dart command (interface + impl)
- [x] Register all commands in generator.dart command tree
- [x] Update structure.dart for feature-first paths
- [x] Update barrel exports
- [x] Implement cross-layer import resolution
- [x] Implement duplicate detection (exists → overwrite/skip/rename)
- [x] Test: dex create feature:auth generates all files
- [x] Test: individual generators work with `on` flag
- [x] Test: flutter analyze passes on generated code

## Success Criteria
- `dex create feature:auth` creates 9 files in correct directories
- Each individual command creates its file in the correct location
- Generated imports between layers are correct
- `flutter analyze` passes
- Duplicate detection works (prompts user)

## Risk Assessment
- **Import path calculation**: Cross-layer imports must be relative and correct. Test with nested features.
- **Name collision**: `dex create model:auth on auth` — model name same as feature name. Handle gracefully.
- **`on` flag parsing**: Reuse existing ArgsMixin logic from get_cli.
