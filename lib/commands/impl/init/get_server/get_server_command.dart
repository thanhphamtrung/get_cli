import '../../../../common/utils/logger/log_utils.dart';
import '../../../interface/command.dart';

/// Get Server init — kept as placeholder, may be removed later
class InitGetServer extends Command {
  @override
  String get commandName => 'init';

  @override
  Future<void> execute() async {
    LogService.info('Get Server init is not supported in dex_cli.');
  }

  @override
  String get hint => 'Generate the structure initial for get server';

  @override
  bool validate() {
    super.validate();
    return true;
  }

  @override
  String get codeSample => '';

  @override
  int get maxParameters => 0;
}
