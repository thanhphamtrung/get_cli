# Dex CLI - Code Standards & Conventions

## Dart Style Guidelines

Dex CLI follows Dart's official style guide with conventions optimized for CLI development with Riverpod + Clean Architecture.

### File Naming

- **Files:** `snake_case.dart`
  - Example: `cli_config.dart`, `log_utils.dart`, `pubspec_utils.dart`
- **Classes/Enums:** `PascalCase`
  - Example: `GetCli`, `CliException`, `FileModel`
- **Functions/Variables:** `camelCase`
  - Example: `findCommand()`, `validateArgs()`, `isValidUrl()`
- **Constants:** `camelCase`
  - Example: `const maxRetries = 3;`

### Directory Structure Conventions

```
lib/
├── commands/              # Command implementations
├── common/               # Shared utilities
├── core/                 # Core CLI engine
├── extensions/           # Utility extensions
├── exception_handler/    # Error handling
├── functions/            # File/project operations
├── models/              # Data models
└── samples/             # Code templates
```

**Principle:** Group by domain, not by type. Don't use `utils/` directly; use domain-specific directories.

### Imports Organization

Imports follow Dart conventions with explicit organization:

```dart
// 1. Dart imports
import 'dart:io';
import 'dart:async';

// 2. Package imports
import 'package:dcli/dcli.dart';
import 'package:yaml/yaml.dart';

// 3. Relative imports
import '../common/utils/logger/log_utils.dart';
import '../models/file_model.dart';
```

**Order:** Dart → packages → relative (alphabetical within each group)

### Class Structure

```dart
class MyCommand extends Command {
  // 1. Static fields/constants
  static const String name = 'my_command';
  static const String description = 'Description here';

  // 2. Instance fields
  final String projectPath;
  late Logger logger;

  // 3. Constructor
  MyCommand({
    required this.projectPath,
  });

  // 4. Lifecycle methods (validate, execute)
  @override
  Future<void> validate() async {
    // Validation logic
  }

  @override
  Future<void> execute() async {
    // Execution logic
  }

  // 5. Helper methods
  Future<void> _helperMethod() async {
    // Implementation
  }
}

### Riverpod Provider Pattern

All generated providers use @riverpod code generation (NOT manual Provider()):

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

// ✓ Correct - Using @riverpod annotation
@riverpod
Future<User> fetchUser(FetchUserRef ref) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getUser();
}

// ✗ Avoid - Manual Provider() instantiation
final userProvider = FutureProvider<User>((ref) async {
  // ...
});
```

All generated models and entities use Freezed:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```
```

## Code Patterns

### 1. Command Implementation Pattern

All commands extend `Command` abstract class:

```dart
class CreatePageCommand extends Command {
  @override
  String get name => 'page';

  @override
  String get description => 'Create a new page';

  @override
  Future<void> validate() async {
    // Check arguments, file system, project setup
    if (!_isValidPageName(arguments.first)) {
      throw CliException('Invalid page name');
    }
  }

  @override
  Future<void> execute() async {
    // Generate files, update configuration
    await _generateController();
    await _generateView();
    await _generateBinding();
    await _addRoute();
  }
}
```

### 2. Mixin Pattern for Shared Behavior

Used for cross-cutting concerns:

```dart
mixin ArgsMixin {
  List<String> get arguments;

  String get commandName => arguments.isNotEmpty ? arguments[0] : '';

  bool hasArgument(String name) => arguments.contains(name);
}
```

### 3. Utility Service Pattern

Stateless utilities in `lib/functions/` and `lib/common/utils/`:

```dart
class PathUtils {
  static String toRelativeImport(String filePath, String fromPath) {
    // Implementation
  }

  static bool isAbsolute(String path) => path.startsWith('/');
}
```

### 4. Template/Sample Pattern

All code generators implement `Sample` interface (generates Riverpod + Clean Architecture):

```dart
abstract class Sample {
  String get name;
  String generate(String className, [String? folderPath]);
}

// Example: Riverpod Provider Sample
class RiverpodProviderSample extends Sample {
  @override
  String get name => 'RiverpodProvider';

  @override
  String generate(String className, [String? folderPath]) {
    return '''
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${className.snakeCase}_provider.g.dart';

@riverpod
class ${className}Notifier extends _\$${className}Notifier {
  @override
  Future<dynamic> build() async {
    // TODO: Implement
    return null;
  }
}
    ''';
  }
}

// Example: Freezed Entity Sample
class FreezedEntitySample extends Sample {
  @override
  String get name => 'FreezedEntity';

  @override
  String generate(String className, [String? folderPath]) {
    return '''
import 'package:freezed_annotation/freezed_annotation.dart';

part '${className.snakeCase}.freezed.dart';

@freezed
class ${className} with _\$${className} {
  const factory ${className}({
    // TODO: Add fields
  }) = _${className};
}
    ''';
  }
}
```

## Error Handling

### Exception Hierarchy

```dart
class CliException implements Exception {
  final String message;
  final String? suggestion;

  CliException(this.message, {this.suggestion});

  @override
  String toString() => message;
}
```

### Usage Pattern

```dart
try {
  await executeCommand();
} on CliException catch (e) {
  logger.error(e.message);
  if (e.suggestion != null) {
    logger.info('Suggestion: ${e.suggestion}');
  }
  exit(1);
} catch (e) {
  logger.error('Unexpected error: $e');
  exit(2);
}
```

## Logging Conventions

Use `LogService` for all output:

```dart
// Success messages
logger.success('Project created successfully!');

// Info messages
logger.info('Generating model from JSON...');

// Warning messages
logger.warn('This will overwrite existing files');

// Error messages
logger.error('Failed to create directory');
```

**Principle:** Use appropriate log level. Don't use `print()` directly.

## String Formatting & Internationalization

### Template Variable Replacement

Templates use `@variable_name` syntax:

```dart
const String template = '''
import 'package:get/get.dart';

class @classNameController extends GetxController {
  // Implementation
}
''';

// Usage
String result = template
    .replaceVar('@className', 'Home')
    .replaceVar('@import', 'package:app/models/user.dart');
```

### Internationalization Keys

Use generated `LocaleKeys` constants:

```dart
import 'package:dex_cli/core/locales.g.dart';

// In code (not UI - this is CLI)
logger.info(translate(LocaleKeys.project_created));
```

## File Operations

### Directory Creation

```dart
import 'package:dcli/dcli.dart';

// Create nested directories
Directory(join(projectPath, 'lib', 'modules', 'home')).createSync(
  recursive: true,
);
```

### File Writing

```dart
// Write content to file
File(filePath).writeAsStringSync(content);

// Append to file
File(filePath).writeAsStringSync(additionalContent, mode: FileMode.append);
```

### File Finding

Use provided utilities:

```dart
// Find folder by name
final homeFolder = findFolderByDirectory(
  initialPath: projectPath,
  folderName: 'home',
);

// Find file by name
final configFile = findFileByName(
  initialPath: projectPath,
  fileName: 'pubspec.yaml',
);
```

## JSON Model Generation

### Type Inference Rules

- Empty string `""` → `String`
- Zero `0` → `int`
- Zero decimal `0.0` → `double`
- `true/false` → `bool`
- `[...]` → `List<T>` (inferred from first element)
- `{...}` → Nested class or `Map<String, dynamic>`

### Generated Model Features

- Null safety support (`Type?` when nullable)
- `fromJson()` constructor
- `toJson()` method
- Proper type conversions
- Nested object support

## Testing Conventions

### Test File Location
```
test/
├── path/test.dart                    # Utility tests
└── commands/
    ├── create_command_test.dart
    └── generate_model_test.dart
```

### Test Naming
```dart
void main() {
  group('CreatePageCommand', () {
    test('should validate page name correctly', () {
      // Arrange
      final command = CreatePageCommand(...);

      // Act & Assert
      expect(command.validate(), completes);
    });

    test('should throw on invalid page name', () {
      // Arrange, Act, Assert
      expect(command.validate(), throwsException);
    });
  });
}
```

## Configuration Management

### pubspec.yaml Configuration

Dex CLI reads from `dex_cli` section:

```yaml
dex_cli:
  separator: "."              # File name separator (default: "_")
  sub_folder: true            # Create subdirectories (default: true)
```

### Accessing Configuration

```dart
import 'package:dex_cli/cli_config/cli_config.dart';

final config = CliConfig.read();
final separator = config.separator; // "." or "_"
final useFlatHierarchy = !config.subFolder;
```

## Code Documentation

### Class Documentation

```dart
/// Manages project file generation and updates.
///
/// Handles creating directories, generating files from templates,
/// and updating configuration files like pubspec.yaml and routes.
class ProjectGenerator {
  // Implementation
}
```

### Function Documentation

```dart
/// Finds a folder by name starting from [startPath].
///
/// Recursively searches directories for a folder named [folderName].
/// Returns null if not found.
///
/// Example:
/// ```dart
/// final folder = findFolder('/home/project', 'lib');
/// ```
Future<Directory?> findFolder(String startPath, String folderName) {
  // Implementation
}
```

### Complex Logic Comments

```dart
// This uses AST parsing to preserve JSON structure and comments
// rather than simple regex replacement. Allows accurate type inference.
final ast = JsonAST.parse(jsonString);
```

## Null Safety

- Use `required` for mandatory parameters
- Use `late` for variables initialized later
- Use `?` for nullable types
- Avoid `late` without initialization guarantee

```dart
class MyClass {
  // ✓ Good
  final String name;
  late final Logger logger;
  final String? description;

  // ✗ Avoid
  String? name; // If it should never be null
}
```

## Async/Await Conventions

```dart
// ✓ Prefer async/await
Future<void> execute() async {
  final result = await readFile();
  await processResult(result);
}

// ✗ Avoid raw futures
Future<void> execute() {
  return readFile().then((result) => processResult(result));
}
```

## Performance Considerations

1. **Lazy Initialization:** Use `lazy` flag for expensive operations
2. **Caching:** Cache file system queries when possible
3. **Streaming:** Use streams for large file operations
4. **Process Execution:** Batch commands when running shell operations

## Security Conventions

- **Path Validation:** Always validate user-provided paths
- **Command Injection:** Use `dart:io` Process API, not shell strings
- **File Permissions:** Check before writing/deleting
- **Input Sanitization:** Validate file names and class names

```dart
// ✓ Good - Type-safe argument passing
await Process.run('flutter', ['pub', 'add', packageName]);

// ✗ Bad - Vulnerable to injection
await Process.run('sh', ['-c', 'flutter pub add $packageName']);
```

## Generated Code Quality Standards

### Riverpod Providers
- Always use `@riverpod` annotation (NOT manual `Provider()`)
- Run `dex build` or `dex watch` to generate .g.dart files
- Providers must be async when calling repository methods
- Use `ref.watch()` for dependencies between providers

### Freezed Models & Entities
- All domain entities must be Freezed with `@freezed` annotation
- All data models must be Freezed with `@freezed` annotation
- Include `fromJson()` factory for serialization
- Include `toJson()` method for deserialization
- Run `dex build` to generate .freezed.dart and .g.dart files

### Layer Separation
- **Domain:** Only entities, repository interfaces, and use cases
- **Data:** Models, datasources, repository implementations
- **Presentation:** Pages (ConsumerWidget), providers, UI logic

## Code Review Checklist

- [ ] Follows naming conventions (snake_case files, PascalCase classes)
- [ ] Imports organized: dart → packages → relative
- [ ] No direct `print()` calls (use LogService)
- [ ] Error handling with CliException
- [ ] File operations use provided utilities
- [ ] No hardcoded paths (use GetCli.structure)
- [ ] Async operations use async/await
- [ ] Configuration accessed via CliConfig (dex_cli section)
- [ ] Comments for complex logic
- [ ] Tests added for new functionality
- [ ] No breaking changes to command interface
- [ ] Generated code uses @riverpod (NOT manual Provider)
- [ ] Freezed annotations on all entities/models
- [ ] Build runner integration tested (@riverpod, Freezed)

---

**Last Updated:** 2026-03-16
**Dart Version:** >=3.11.0 <4.0.0
**Architecture:** Riverpod + Clean Architecture
**Code Generation:** @riverpod, Freezed, build_runner
