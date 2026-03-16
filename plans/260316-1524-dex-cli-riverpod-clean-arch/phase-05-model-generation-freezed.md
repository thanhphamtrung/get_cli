# Phase 5: Model Generation (Freezed)

## Overview
- **Priority:** P1
- **Status:** completed
- **Effort:** Medium (~2-3 hours)
- **Description:** Adapt existing JSON-to-model generation to output Freezed classes instead of plain Dart

## Context
- Depends on: Phase 2 (template patterns established)
- Existing `lib/common/utils/json_serialize/` has complete JSON→Dart pipeline (3260+ LOC). Reuse the parsing, change the output format.

## Requirements

### Functional
- `dex generate model on auth with assets/models/user.json` generates Freezed model
- `dex generate model on auth from "https://api.example.com/user"` works with URLs
- Generated model includes: `@freezed`, `part` directives, `fromJson`, `toEntity()` method
- Nested JSON objects → nested Freezed classes
- Optional: also generate domain entity (without JSON)

### Non-Functional
- Output passes `dart analyze`
- Output compiles after `build_runner build`

## Architecture

### Current Pipeline (Keep)
```
JSON input → Tokenizer → AST Parser → Type Inference → Dart Code Output
                                                         ↑ CHANGE THIS
```

### New Output Format
**Before (get_cli):**
```dart
class User {
  String? name;
  int? age;
  User({this.name, this.age});
  User.fromJson(Map<String, dynamic> json) { ... }
  Map<String, dynamic> toJson() { ... }
}
```

**After (dex):**
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String name,
    required int age,
    @Default([]) List<String> tags,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
```

## Related Code Files

### Files to Modify
- `lib/common/utils/json_serialize/model_generator.dart` — change output format to Freezed
- `lib/common/utils/json_serialize/sintaxe.dart` — may need Freezed-specific type handling
- `lib/commands/impl/generate/model/model.dart` — update command to use Freezed output

### Files to Keep Unchanged
- `lib/common/utils/json_serialize/json_ast/` — entire AST parser (unchanged)
- `lib/common/utils/json_serialize/helpers.dart` — type inference helpers (unchanged)

## Implementation Steps

### Step 1: Create Freezed Code Generator
Create `lib/common/utils/json_serialize/freezed_generator.dart`:
1. Takes parsed JSON fields (from existing AST)
2. Outputs Freezed class with:
   - `@freezed` annotation
   - `part` directives (`.freezed.dart` + `.g.dart`)
   - `const factory` constructor with named required params
   - `fromJson` factory
   - `_$ClassName` mixin
3. Handle nullable fields: `String?` for nullable JSON values
4. Handle nested objects: generate separate Freezed classes
5. Handle lists: `List<NestedModel>` with proper type

### Step 2: Update Model Generator
In `model_generator.dart`, swap output from plain Dart class to Freezed format.
Keep: type inference logic, field parsing, nested object detection.
Change: code output template.

### Step 3: Update Generate Model Command
In `model.dart` command:
1. Keep JSON reading (file or URL)
2. Keep AST parsing
3. Route output through new Freezed generator
4. Place output in `features/{on}/data/models/{name}_model.dart`
5. Optionally generate entity in `features/{on}/domain/entities/{name}.dart`

### Step 4: Handle Edge Cases
- Empty arrays `[]` → `List<dynamic>` with TODO comment
- Nested objects → separate Freezed class in same file or separate file
- Numeric inference: `0` → `int`, `0.0` → `double`
- `null` values → `dynamic?` with TODO comment

## Todo List
- [x] Create freezed_generator.dart
- [x] Update model_generator.dart to use Freezed output
- [x] Update generate model command for feature-first paths
- [x] Handle nested objects as nested Freezed classes
- [x] Handle nullable fields
- [x] Test: JSON file → Freezed model
- [x] Test: JSON URL → Freezed model
- [x] Test: nested JSON → multiple Freezed classes
- [x] Test: build_runner generates .freezed.dart and .g.dart

## Success Criteria
- `dex generate model on auth with user.json` produces valid Freezed class
- Nested JSON produces nested Freezed classes
- `build_runner build` generates implementation files
- `flutter analyze` passes on generated + built files

## Risk Assessment
- **Nested object naming**: JSON key `"address"` → `AddressModel` class name. Must handle collisions.
- **Complex JSON arrays**: `[{"mixed": true}, "string"]` — mixed-type arrays hard to infer. Default to `List<dynamic>`.
- **Existing generator coupling**: model_generator.dart may have tight coupling to old output format. May need parallel generator rather than modifying in-place.
