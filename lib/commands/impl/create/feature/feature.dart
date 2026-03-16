import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:recase/recase.dart';

import '../../../../common/utils/logger/log_utils.dart';
import '../../../../common/utils/shell/shel.utils.dart';
import '../../../../core/structure.dart';
import '../../../../functions/create/create_list_directory.dart';
import '../../../../functions/routes/gorouter_add_route.dart';
import '../../../../functions/routes/gorouter_add_route_name.dart';
import '../../../../samples/impl/riverpod_clean/riverpod_clean_samples.dart';
import '../../../interface/command.dart';

/// Generates a complete feature module with all 3 Clean Architecture layers.
///
/// Usage: `dex create feature:auth`
///
/// Generates 9 files:
///   domain/entities/{name}.dart
///   domain/repositories/{name}_repository.dart
///   domain/usecases/get_{name}.dart
///   data/models/{name}_model.dart
///   data/datasources/{name}_remote_datasource.dart
///   data/repositories/{name}_repository_impl.dart
///   presentation/providers/{name}_provider.dart
///   presentation/pages/{name}_page.dart
class CreateFeatureCommand extends Command {
  @override
  String get commandName => 'feature';

  @override
  Future<void> execute() async {
    var featureName = name;
    if (featureName.isEmpty) {
      featureName = ask('Enter feature name:');
      if (featureName.isEmpty) return;
    }
    featureName = featureName.snakeCase;

    final basePath = Structure.featurePath(featureName);
    if (Directory(basePath).existsSync()) {
      LogService.error(
          'Feature "$featureName" already exists at $basePath. '
          'Use individual commands to add components.');
      return;
    }

    LogService.info('Creating feature "$featureName"…');

    // Create directory tree
    createListDirectory([
      Directory('$basePath/data/datasources'),
      Directory('$basePath/data/models'),
      Directory('$basePath/data/repositories'),
      Directory('$basePath/domain/entities'),
      Directory('$basePath/domain/repositories'),
      Directory('$basePath/domain/usecases'),
      Directory('$basePath/presentation/providers'),
      Directory('$basePath/presentation/pages'),
      Directory('$basePath/presentation/widgets'),
    ]);

    // Domain layer
    RiverpodEntitySample(featureName,
            path: '$basePath/domain/entities/$featureName.dart')
        .create(skipFormatter: true);
    RiverpodRepositoryInterfaceSample(featureName,
            path:
                '$basePath/domain/repositories/${featureName}_repository.dart')
        .create(skipFormatter: true);
    RiverpodUseCaseSample(featureName,
            path: '$basePath/domain/usecases/get_$featureName.dart')
        .create(skipFormatter: true);

    // Data layer
    RiverpodModelSample(featureName, featureName,
            path: '$basePath/data/models/${featureName}_model.dart')
        .create(skipFormatter: true);
    RiverpodRemoteDataSourceSample(featureName,
            path:
                '$basePath/data/datasources/${featureName}_remote_datasource.dart')
        .create(skipFormatter: true);
    RiverpodRepositoryImplSample(featureName,
            path:
                '$basePath/data/repositories/${featureName}_repository_impl.dart')
        .create(skipFormatter: true);

    // Presentation layer
    RiverpodProviderSample(featureName,
            path:
                '$basePath/presentation/providers/${featureName}_provider.dart')
        .create(skipFormatter: true);
    RiverpodPageSample(featureName,
            path: '$basePath/presentation/pages/${featureName}_page.dart')
        .create(skipFormatter: true);

    // Register route in GoRouter
    addRouteName(featureName);
    addGoRoute(featureName);

    LogService.success(
        'Feature "$featureName" created with 8 files in $basePath');

    // Run build_runner to generate .freezed.dart and .g.dart files
    if (!flags.contains('--no-build')) {
      await ShellUtils.buildRunner();
    }
  }

  @override
  List<String> get acceptedFlags => ['--no-build'];

  @override
  String? get hint => 'Generate a full feature module (all 3 layers)';

  @override
  String get codeSample => 'dex create feature:auth';

  @override
  int get maxParameters => 0;
}
