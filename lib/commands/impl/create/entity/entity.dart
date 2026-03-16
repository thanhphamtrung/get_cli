import 'package:recase/recase.dart';

import '../../../../common/utils/logger/log_utils.dart';
import '../../../../common/utils/shell/shel.utils.dart';
import '../../../../core/structure.dart';
import '../../../../samples/impl/riverpod_clean/riverpod_entity.dart';
import '../../../interface/command.dart';

/// Creates a Freezed entity in a feature's domain layer.
///
/// Usage: `dex create entity:user on auth`
class CreateEntityCommand extends Command {
  @override
  String get commandName => 'entity';

  @override
  Future<void> execute() async {
    final entityName = name.snakeCase;
    final feature = onCommand.snakeCase;
    if (entityName.isEmpty) {
      LogService.error('Please provide an entity name.');
      return;
    }
    if (feature.isEmpty) {
      LogService.error('Please specify target feature with "on" flag.');
      return;
    }

    final path =
        '${Structure.featurePath(feature)}/domain/entities/$entityName.dart';
    RiverpodEntitySample(entityName, path: path).create(skipFormatter: true);

    // Run build_runner to generate .freezed.dart files
    if (!flags.contains('--no-build')) {
      await ShellUtils.buildRunner();
    }
  }

  @override
  List<String> get acceptedFlags => ['--no-build'];

  @override
  String? get hint => 'Generate a Freezed entity in a feature';

  @override
  String get codeSample => 'dex create entity:user on auth';

  @override
  int get maxParameters => 0;
}
