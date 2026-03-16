import 'package:recase/recase.dart';

import '../../../../common/utils/logger/log_utils.dart';
import '../../../../core/structure.dart';
import '../../../../samples/impl/riverpod_clean/riverpod_repository_impl.dart';
import '../../../../samples/impl/riverpod_clean/riverpod_repository_interface.dart';
import '../../../interface/command.dart';

/// Creates both repository interface + implementation in a feature.
///
/// Usage: `dex create repository:auth on auth`
class CreateRepositoryCommand extends Command {
  @override
  String get commandName => 'repository';

  @override
  Future<void> execute() async {
    final repoName = name.snakeCase;
    final feature = onCommand.snakeCase;
    if (repoName.isEmpty) {
      LogService.error('Please provide a repository name.');
      return;
    }
    if (feature.isEmpty) {
      LogService.error('Please specify target feature with "on" flag.');
      return;
    }

    final basePath = Structure.featurePath(feature);

    // Domain layer — abstract interface
    RiverpodRepositoryInterfaceSample(repoName,
            path:
                '$basePath/domain/repositories/${repoName}_repository.dart')
        .create(skipFormatter: true);

    // Data layer — implementation
    RiverpodRepositoryImplSample(repoName,
            path:
                '$basePath/data/repositories/${repoName}_repository_impl.dart')
        .create(skipFormatter: true);
  }

  @override
  String? get hint => 'Generate repository interface + implementation';

  @override
  String get codeSample => 'dex create repository:auth on auth';

  @override
  int get maxParameters => 0;
}
