# Phase 4: Route Management

## Overview
- **Priority:** P1
- **Status:** completed
- **Effort:** Medium (~2-3 hours)
- **Description:** Auto-register routes in GoRouter when creating features/pages

## Context
- Depends on: Phase 2 (app_router.dart template exists)
- Replaces GetX's `get_add_route.dart` and `get_app_pages.dart` with GoRouter route insertion

## Requirements

### Functional
- `dex create feature:auth` auto-adds route to `core/router/app_router.dart`
- `dex create page:login on auth` adds nested route under auth
- Route name constant added to `core/router/route_names.dart`
- Import for new page added to router file

### Non-Functional
- Route insertion doesn't corrupt existing routes
- Generated routes follow GoRouter conventions

## Architecture

### app_router.dart Structure (Target Format)
```dart
@riverpod
GoRouter appRouter(ref) {
  return GoRouter(
    initialLocation: RouteNames.home,
    routes: [
      GoRoute(
        path: RouteNames.home,
        builder: (context, state) => const HomePage(),
      ),
      // ← NEW ROUTES INSERTED HERE
    ],
  );
}
```

### route_names.dart Structure
```dart
class RouteNames {
  static const home = '/home';
  static const auth = '/auth';
  // ← NEW CONSTANTS INSERTED HERE
}
```

## Related Code Files

### New Files to Create
- `lib/functions/routes/gorouter_add_route.dart` — insert GoRoute into app_router.dart
- `lib/functions/routes/gorouter_add_route_name.dart` — insert constant into route_names.dart

### Files to Modify
- `lib/commands/impl/create/feature/feature.dart` — call route registration after file generation
- `lib/commands/impl/create/page/page.dart` — call route registration

## Implementation Steps

### Step 1: Implement Route Name Insertion
`gorouter_add_route_name.dart`:
1. Read `lib/core/router/route_names.dart`
2. Find last `static const` line
3. Insert new constant: `static const {name} = '/{name}';`
4. Write file back

### Step 2: Implement GoRoute Insertion
`gorouter_add_route.dart`:
1. Read `lib/core/router/app_router.dart`
2. Find `routes: [` array
3. Find insertion point (before closing `]`)
4. Insert GoRoute block with correct indentation:
```dart
      GoRoute(
        path: RouteNames.{name},
        builder: (context, state) => const {Name}Page(),
      ),
```
5. Add import for page file at top of file
6. Write file back

### Step 3: Handle Nested Routes (Optional)
For `dex create page:login on auth`:
1. Find existing `GoRoute` for auth feature
2. Check if `children: [` exists
3. If not, add `children: []` array
4. Insert child route inside

### Step 4: Integrate with Create Commands
In `feature.dart` and `page.dart`, after file generation:
```dart
await addGoRoute(featureName, pageName);
await addRouteName(featureName);
```

## Todo List
- [x] Create gorouter_add_route.dart
- [x] Create gorouter_add_route_name.dart
- [x] Integrate route registration in feature command
- [x] Integrate route registration in page command
- [x] Handle import insertion in router file
- [x] Test: creating feature adds route
- [x] Test: creating page adds route
- [x] Test: flutter analyze passes after route insertion

## Success Criteria
- New feature → route auto-appears in app_router.dart
- Route name constant auto-added to route_names.dart
- Import for page auto-added to router file
- Existing routes not corrupted
- `flutter analyze` passes

## Risk Assessment
- **Line-based parsing fragility**: Same issue as get_cli's route insertion. Mitigate by generating predictable format and documenting "don't manually reformat app_router.dart".
- **Nested routes complexity**: Keep simple for V1 — flat routes only. Nested routes as V2 enhancement.
