import 'package:recase/recase.dart';

import '../../../../common/utils/input/input_prompt_utils.dart';
import '../../../../core/structure.dart';
import '../../../../samples/impl/riverpod_clean/riverpod_usecase.dart';
import '../../../interface/command.dart';

/// Creates a use case in a feature's domain layer.
///
/// Usage: `dex create usecase:login on auth`
class CreateUseCaseCommand extends Command {
  @override
  String get commandName => 'usecase';

  @override
  Future<void> execute() async {
    final usecaseName = promptName(name.snakeCase, 'use case');
    if (usecaseName.isEmpty) return;
    final feature = promptFeature(onCommand.snakeCase);
    if (feature.isEmpty) return;

    final path =
        '${Structure.featurePath(feature)}/domain/usecases/get_$usecaseName.dart';
    RiverpodUseCaseSample(usecaseName, path: path)
        .create(skipFormatter: true);
  }

  @override
  String? get hint => 'Generate a use case in a feature';

  @override
  String get codeSample => 'dex create usecase:login on auth';

  @override
  int get maxParameters => 0;
}
