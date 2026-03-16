import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';

import '../../../../common/utils/json_serialize/freezed_generator.dart';
import '../../../../common/utils/logger/log_utils.dart';
import '../../../../core/internationalization.dart';
import '../../../../core/locales.g.dart';
import '../../../../core/structure.dart';
import '../../../../exception_handler/exceptions/cli_exception.dart';
import '../../../../functions/create/create_single_file.dart';
import '../../../interface/command.dart';

/// Generates a Freezed model class from JSON (file or URL).
///
/// Usage: `dex generate model on auth with assets/models/user.json`
class GenerateModelCommand extends Command {
  @override
  String get commandName => 'model';

  @override
  Future<void> execute() async {
    var name = p.basenameWithoutExtension(withArgument).pascalCase;
    if (withArgument.isEmpty && fromArgument.isEmpty) {
      var result = ask(LocaleKeys.ask_model_name.tr);
      name = result.pascalCase;
    }

    final snakeName = name.snakeCase;
    final feature = onCommand.snakeCase;
    final fileName = '${snakeName}_model';

    // Determine output path
    String modelPath;
    if (feature.isNotEmpty) {
      modelPath =
          '${Structure.featurePath(feature)}/data/models/$fileName.dart';
    } else {
      final fileModel =
          Structure.model(name, 'model', false, on: onCommand);
      modelPath = '${fileModel.path}_model.dart';
    }

    // Generate Freezed model from JSON
    final generator = FreezedModelGenerator(name, fileName);
    final dartCode = generator.generateFreezedClasses(await _jsonRawData);

    writeFile(modelPath, dartCode.result, overwrite: true, skipFormatter: true);

    for (var warning in dartCode.warnings) {
      LogService.info('warning: ${warning.path} ${warning.warning}');
    }
  }

  @override
  String? get hint => LocaleKeys.hint_generate_model.tr;

  @override
  bool validate() {
    if ((withArgument.isEmpty || p.extension(withArgument) != '.json') &&
        fromArgument.isEmpty) {
      var codeSample =
          'dex generate model on auth with assets/models/user.json';
      throw CliException(LocaleKeys.error_invalid_json.trArgs([withArgument]),
          codeSample: codeSample);
    }
    return true;
  }

  Future<String> get _jsonRawData async {
    if (withArgument.isNotEmpty) {
      return await File(withArgument).readAsString();
    } else {
      try {
        var result = await get(Uri.parse(fromArgument));
        return result.body;
      } on Exception catch (_) {
        throw CliException(
            LocaleKeys.error_failed_to_connect.trArgs([fromArgument]));
      }
    }
  }

  final String? codeSample1 = LogService.code(
      'dex generate model on auth with assets/models/user.json');
  final String? codeSample2 = LogService.code(
      'dex generate model on auth from "https://api.github.com/users/CpdnCristiano"');

  @override
  String get codeSample => '''
  $codeSample1
  or
  $codeSample2
''';

  @override
  int get maxParameters => 0;
}
