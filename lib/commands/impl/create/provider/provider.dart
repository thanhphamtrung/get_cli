import 'package:recase/recase.dart';

import '../../../../common/utils/input/input_prompt_utils.dart';
import '../../../../common/utils/shell/shel.utils.dart';
import '../../../../core/internationalization.dart';
import '../../../../core/locales.g.dart';
import '../../../../core/structure.dart';
import '../../../../samples/impl/riverpod_clean/riverpod_provider.dart';
import '../../../interface/command.dart';

/// Creates a @riverpod AsyncNotifier provider in a feature's presentation layer.
///
/// Usage: `dex create provider:auth on auth`
class CreateProviderCommand extends Command {
  @override
  String get commandName => 'provider';

  @override
  Future<void> execute() async {
    final providerName = promptName(name.snakeCase, 'provider');
    if (providerName.isEmpty) return;
    final feature = promptFeature(onCommand.snakeCase);
    if (feature.isEmpty) return;

    final path =
        '${Structure.featurePath(feature)}/presentation/providers/${providerName}_provider.dart';
    RiverpodProviderSample(providerName, path: path)
        .create(skipFormatter: true);

    // Run build_runner to generate .g.dart files
    if (!flags.contains('--no-build')) {
      await ShellUtils.buildRunner();
    }
  }

  @override
  List<String> get acceptedFlags => ['--no-build'];

  @override
  String? get hint => Translation(LocaleKeys.hint_create_provider).tr;

  @override
  String get codeSample => 'dex create provider:auth on auth';

  @override
  int get maxParameters => 0;
}
