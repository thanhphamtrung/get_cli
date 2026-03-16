import 'package:recase/recase.dart';

import '../../../../common/utils/input/input_prompt_utils.dart';
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
    final pageName = promptName(name.snakeCase, 'page');
    if (pageName.isEmpty) return;
    final feature = promptFeature(onCommand.snakeCase);
    if (feature.isEmpty) return;

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
