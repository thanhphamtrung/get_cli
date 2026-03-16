import 'package:recase/recase.dart';

import '../../../../common/utils/logger/log_utils.dart';
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
    final modelName = name.snakeCase;
    final feature = onCommand.snakeCase;
    if (modelName.isEmpty) {
      LogService.error('Please provide a model name.');
      return;
    }
    if (feature.isEmpty) {
      LogService.error('Please specify target feature with "on" flag.');
      return;
    }

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
