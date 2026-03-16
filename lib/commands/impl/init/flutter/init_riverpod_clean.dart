import 'dart:io';

import '../../../../common/utils/logger/log_utils.dart';
import '../../../../common/utils/shell/shel.utils.dart';
import '../../../../functions/create/create_list_directory.dart';
import '../../../../functions/create/create_single_file.dart';
import '../../../../samples/impl/riverpod_clean/riverpod_clean_samples.dart';

/// Initialize a Riverpod Clean Architecture project structure.
///
/// Creates core infrastructure (error handling, networking, routing, config),
/// an initial 'home' feature module with all 3 layers, and config files.
Future<void> createInitRiverpodClean() async {
  final projectName = _getProjectName();

  LogService.info('Creating Riverpod Clean Architecture structure…');

  // Install required dependencies
  await _installDependencies();

  // Create directory tree
  _createDirectories();

  // Core infrastructure files
  RiverpodMainSample(projectName).create(skipFormatter: true);
  RiverpodFailuresSample().create(skipFormatter: true);
  RiverpodExceptionsSample().create(skipFormatter: true);
  RiverpodUseCaseBaseSample().create(skipFormatter: true);
  RiverpodDioClientSample().create(skipFormatter: true);
  RiverpodAuthInterceptorSample().create(skipFormatter: true);
  RiverpodRouteNamesSample().create(skipFormatter: true);
  RiverpodEnvSample().create(skipFormatter: true);

  // Home feature (all 3 layers)
  RiverpodEntitySample('home').create(skipFormatter: true);
  RiverpodModelSample('home', 'home').create(skipFormatter: true);
  RiverpodRepositoryInterfaceSample('home').create(skipFormatter: true);
  RiverpodRepositoryImplSample('home').create(skipFormatter: true);
  RiverpodRemoteDataSourceSample('home').create(skipFormatter: true);
  RiverpodUseCaseSample('home').create(skipFormatter: true);
  RiverpodProviderSample('home').create(skipFormatter: true);
  RiverpodPageSample('home').create(skipFormatter: true);

  // Router depends on home page — create after home feature
  RiverpodAppRouterSample().create(skipFormatter: true);

  // Config files
  _createEnvFiles();
  _createBuildYaml();
  _updateGitignore();

  LogService.success(
      'Riverpod Clean Architecture structure generated successfully.');
}

String _getProjectName() {
  try {
    final pubspecFile = File('pubspec.yaml');
    if (pubspecFile.existsSync()) {
      final content = pubspecFile.readAsStringSync();
      final nameMatch = RegExp(r'^name:\s*(.+)$', multiLine: true)
          .firstMatch(content);
      if (nameMatch != null) {
        return nameMatch.group(1)!.trim();
      }
    }
  } on Exception catch (_) {}
  return 'my_app';
}

Future<void> _installDependencies() async {
  // Runtime dependencies
  await ShellUtils.addPackages([
    'flutter_riverpod',
    'riverpod_annotation',
    'dio',
    'go_router',
    'freezed_annotation',
    'json_annotation',
    'fpdart',
    'pretty_dio_logger',
    'envied',
    'flutter_secure_storage',
    'shared_preferences',
  ]);

  // Dev dependencies
  await ShellUtils.addPackages([
    'dev:build_runner',
    'dev:riverpod_generator',
    'dev:freezed',
    'dev:json_serializable',
    'dev:envied_generator',
  ]);
}

void _createDirectories() {
  createListDirectory([
    // Core
    Directory('lib/core/error'),
    Directory('lib/core/network/interceptors'),
    Directory('lib/core/router'),
    Directory('lib/core/config'),
    Directory('lib/core/usecases'),
    // Home feature
    Directory('lib/features/home/data/datasources'),
    Directory('lib/features/home/data/models'),
    Directory('lib/features/home/data/repositories'),
    Directory('lib/features/home/domain/entities'),
    Directory('lib/features/home/domain/repositories'),
    Directory('lib/features/home/domain/usecases'),
    Directory('lib/features/home/presentation/providers'),
    Directory('lib/features/home/presentation/pages'),
    Directory('lib/features/home/presentation/widgets'),
    // Shared
    Directory('lib/shared/widgets'),
    Directory('lib/shared/extensions'),
  ]);
}

void _createEnvFiles() {
  final envContent = 'BASE_URL=https://api.example.com\n';
  writeFile('.env', envContent,
      overwrite: false, skipFormatter: true, logger: false);
  writeFile('.env.example', envContent,
      overwrite: false, skipFormatter: true, logger: false);
}

void _createBuildYaml() {
  const buildYaml = '''
targets:
  \$default:
    builders:
      freezed:
        generate_for:
          - lib/**/*.dart
      json_serializable:
        generate_for:
          - lib/**/*.dart
      riverpod_generator:
        generate_for:
          - lib/**/*.dart
''';
  writeFile('build.yaml', buildYaml,
      overwrite: false, skipFormatter: true, logger: false);
}

void _updateGitignore() {
  final gitignoreFile = File('.gitignore');
  final additions = '''

# Generated files
*.g.dart
*.freezed.dart

# Environment
.env
''';

  if (gitignoreFile.existsSync()) {
    final content = gitignoreFile.readAsStringSync();
    if (!content.contains('*.g.dart')) {
      gitignoreFile.writeAsStringSync(content + additions);
    }
  } else {
    gitignoreFile.writeAsStringSync(additions);
  }
}
