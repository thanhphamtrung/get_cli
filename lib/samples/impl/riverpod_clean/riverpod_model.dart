import 'package:recase/recase.dart';

import '../../interface/sample_interface.dart';

/// Template for data/models/{name}_model.dart — Freezed DTO + toEntity()
class RiverpodModelSample extends Sample {
  final String _name;

  RiverpodModelSample(this._name, String featureName, {String? path})
      : super(
            path ??
                'lib/features/$featureName/data/models/${_name.snakeCase}_model.dart',
            overwrite: true);

  @override
  String get content => '''
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/${_name.snakeCase}.dart';

part '${_name.snakeCase}_model.freezed.dart';
part '${_name.snakeCase}_model.g.dart';

@freezed
abstract class ${_name.pascalCase}Model with _\$${_name.pascalCase}Model {
  const ${_name.pascalCase}Model._();

  const factory ${_name.pascalCase}Model({
    required String id,
  }) = _${_name.pascalCase}Model;

  factory ${_name.pascalCase}Model.fromJson(Map<String, dynamic> json) =>
      _\$${_name.pascalCase}ModelFromJson(json);

  ${_name.pascalCase} toEntity() {
    return ${_name.pascalCase}(
      id: id,
    );
  }
}
''';
}
