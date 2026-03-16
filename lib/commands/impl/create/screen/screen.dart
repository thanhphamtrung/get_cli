import '../../../../common/utils/logger/log_utils.dart';
import '../../../../core/internationalization.dart';
import '../../../../core/locales.g.dart';
import '../../../interface/command.dart';

/// Creates a screen — will be rewritten in Phase 3 for Riverpod Clean Arch
class CreateScreenCommand extends Command {
  @override
  String get commandName => 'screen';

  @override
  Future<void> execute() async {
    // TODO: Phase 3 — rewrite for ConsumerWidget + feature path
    LogService.info(
        'Screen command will be available after Riverpod templates are set up.');
  }

  @override
  String? get hint => Translation(LocaleKeys.hint_create_screen).tr;

  @override
  bool validate() => true;

  @override
  String get codeSample => 'dex create screen:name';

  @override
  int get maxParameters => 0;
}
