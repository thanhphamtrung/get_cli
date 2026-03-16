import 'package:recase/recase.dart';

import '../../../../common/utils/logger/log_utils.dart';
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
    final providerName = name.snakeCase;
    final feature = onCommand.snakeCase;
    if (providerName.isEmpty) {
      LogService.error('Please provide a provider name.');
      return;
    }
    if (feature.isEmpty) {
      LogService.error('Please specify target feature with "on" flag.');
      return;
    }

    final path =
        '${Structure.featurePath(feature)}/presentation/providers/${providerName}_provider.dart';
    RiverpodProviderSample(providerName, path: path)
        .create(skipFormatter: true);
  }

  @override
  String? get hint => Translation(LocaleKeys.hint_create_provider).tr;

  @override
  String get codeSample => 'dex create provider:auth on auth';

  @override
  int get maxParameters => 0;
}
