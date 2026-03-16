import 'package:recase/recase.dart';

import '../../../../common/utils/logger/log_utils.dart';
import '../../../../core/internationalization.dart';
import '../../../../core/locales.g.dart';
import '../../../../core/structure.dart';
import '../../../../samples/impl/riverpod_clean/riverpod_page.dart';
import '../../../interface/command.dart';

/// Creates a ConsumerWidget page in a feature's presentation layer.
///
/// Usage: `dex create page:login on auth`
class CreatePageCommand extends Command {
  @override
  String get commandName => 'page';

  @override
  List<String> get alias => ['module', '-p', '-m'];

  @override
  Future<void> execute() async {
    final pageName = name.snakeCase;
    final feature = onCommand.snakeCase;
    if (pageName.isEmpty) {
      LogService.error('Please provide a page name.');
      return;
    }
    if (feature.isEmpty) {
      LogService.error('Please specify target feature with "on" flag.');
      return;
    }

    final path =
        '${Structure.featurePath(feature)}/presentation/pages/${pageName}_page.dart';
    RiverpodPageSample(pageName, path: path).create(skipFormatter: true);
  }

  @override
  String? get hint => LocaleKeys.hint_create_page.tr;

  @override
  String get codeSample => 'dex create page:login on auth';

  @override
  int get maxParameters => 0;
}
