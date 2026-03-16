import 'package:recase/recase.dart';

import '../../../../common/utils/input/input_prompt_utils.dart';
import '../../../../common/utils/shell/shel.utils.dart';
import '../../../../core/structure.dart';
import '../../../../samples/impl/riverpod_clean/riverpod_model.dart';
import '../../../interface/command.dart';

/// Creates a Freezed DTO model in a feature's data layer.
///
/// Usage: `dex create model:user on auth`
class CreateModelCommand extends Command {
  @override
  String get commandName => 'model';

  @override
  Future<void> execute() async {
    final modelName = promptName(name.snakeCase, 'model');
    if (modelName.isEmpty) return;
    final feature = promptFeature(onCommand.snakeCase);
    if (feature.isEmpty) return;

    final path =
        '${Structure.featurePath(feature)}/data/models/${modelName}_model.dart';
    RiverpodModelSample(modelName, feature, path: path)
        .create(skipFormatter: true);

    // Run build_runner to generate .freezed.dart and .g.dart files
    if (!flags.contains('--no-build')) {
      await ShellUtils.buildRunner();
    }
  }

  @override
  List<String> get acceptedFlags => ['--no-build'];

  @override
  String? get hint => 'Generate a Freezed DTO model in a feature';

  @override
  String get codeSample => 'dex create model:user on auth';

  @override
  int get maxParameters => 0;
}
