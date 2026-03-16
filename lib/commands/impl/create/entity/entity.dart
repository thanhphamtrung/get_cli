import 'package:recase/recase.dart';

import '../../../../common/utils/input/input_prompt_utils.dart';
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
    final entityName = promptName(name.snakeCase, 'entity');
    if (entityName.isEmpty) return;
    final feature = promptFeature(onCommand.snakeCase);
    if (feature.isEmpty) return;

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
