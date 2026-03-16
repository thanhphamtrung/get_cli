import '../../../../common/utils/logger/log_utils.dart';
import '../../../../core/internationalization.dart';
import '../../../../core/locales.g.dart';
import '../../../interface/command.dart';

/// Creates a controller — will be rewritten in Phase 3 for @riverpod provider
class CreateControllerCommand extends Command {
  @override
  String get commandName => 'controller';

  @override
  String? get hint => LocaleKeys.hint_create_controller.tr;

  @override
  String get codeSample => 'dex create controller:name';

  @override
  Future<void> execute() async {
    // TODO: Phase 3 — rewrite for @riverpod AsyncNotifier
    LogService.info(
        'Controller command will be available after Riverpod templates are set up.');
  }

  @override
  int get maxParameters => 0;
}
