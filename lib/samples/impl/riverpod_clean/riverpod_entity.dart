import 'package:recase/recase.dart';

import '../../interface/sample_interface.dart';

/// Template for domain/entities/{name}.dart — Freezed entity
class RiverpodEntitySample extends Sample {
  final String _name;

  RiverpodEntitySample(this._name, {String? path})
      : super(path ?? 'lib/features/home/domain/entities/$_name.dart',
            overwrite: true);

  @override
  String get content => '''
import 'package:freezed_annotation/freezed_annotation.dart';

part '${_name.snakeCase}.freezed.dart';

@freezed
abstract class ${_name.pascalCase} with _\$${_name.pascalCase} {
  const factory ${_name.pascalCase}({
    required String id,
  }) = _${_name.pascalCase};
}
''';
}
