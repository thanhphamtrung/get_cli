import '../../../../common/utils/logger/log_utils.dart';
import '../../../../core/internationalization.dart';
import '../../../../core/locales.g.dart';
import '../../../interface/command.dart';

/// Creates a view — will be rewritten in Phase 3 for ConsumerWidget
class CreateViewCommand extends Command {
  @override
  String get commandName => 'view';

  @override
  String? get hint => Translation(LocaleKeys.hint_create_view).tr;

  @override
  bool validate() => true;

  @override
  Future<void> execute() async {
    // TODO: Phase 3 — rewrite for ConsumerWidget page
    LogService.info(
        'View command will be available after Riverpod templates are set up.');
  }

  @override
  String get codeSample => 'dex create view:name';

  @override
  int get maxParameters => 0;
}
