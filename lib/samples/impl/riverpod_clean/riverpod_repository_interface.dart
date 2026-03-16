import 'package:recase/recase.dart';

import '../../interface/sample_interface.dart';

/// Template for domain/repositories/{name}_repository.dart — abstract
class RiverpodRepositoryInterfaceSample extends Sample {
  final String _name;

  RiverpodRepositoryInterfaceSample(this._name, {String? path})
      : super(
            path ??
                'lib/features/${_name.snakeCase}/domain/repositories/${_name.snakeCase}_repository.dart',
            overwrite: true);

  @override
  String get content => '''
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/${_name.snakeCase}.dart';

abstract class ${_name.pascalCase}Repository {
  Future<Either<Failure, List<${_name.pascalCase}>>> getAll();
  Future<Either<Failure, ${_name.pascalCase}>> getById(String id);
}
''';
}
