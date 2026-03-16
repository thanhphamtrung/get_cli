import 'package:recase/recase.dart';

import '../../../../common/utils/logger/log_utils.dart';
import '../../../../core/structure.dart';
import '../../../../samples/impl/riverpod_clean/riverpod_remote_datasource.dart';
import '../../../interface/command.dart';

/// Creates a remote datasource in a feature's data layer.
///
/// Usage: `dex create datasource:auth on auth`
class CreateDataSourceCommand extends Command {
  @override
  String get commandName => 'datasource';

  @override
  Future<void> execute() async {
    final dsName = name.snakeCase;
    final feature = onCommand.snakeCase;
    if (dsName.isEmpty) {
      LogService.error('Please provide a datasource name.');
      return;
    }
    if (feature.isEmpty) {
      LogService.error('Please specify target feature with "on" flag.');
      return;
    }

    final path =
        '${Structure.featurePath(feature)}/data/datasources/${dsName}_remote_datasource.dart';
    RiverpodRemoteDataSourceSample(dsName, path: path)
        .create(skipFormatter: true);
  }

  @override
  String? get hint => 'Generate a remote datasource in a feature';

  @override
  String get codeSample => 'dex create datasource:auth on auth';

  @override
  int get maxParameters => 0;
}
