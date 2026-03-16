import 'package:recase/recase.dart';

import '../../interface/sample_interface.dart';

/// Template for domain/usecases/get_{name}.dart — concrete UseCase
class RiverpodUseCaseSample extends Sample {
  final String _name;

  RiverpodUseCaseSample(this._name, {String? path})
      : super(
            path ??
                'lib/features/${_name.snakeCase}/domain/usecases/get_${_name.snakeCase}.dart',
            overwrite: true);

  @override
  String get content => '''
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/${_name.snakeCase}.dart';
import '../repositories/${_name.snakeCase}_repository.dart';

class Get${_name.pascalCase} implements UseCase<List<${_name.pascalCase}>, NoParams> {
  final ${_name.pascalCase}Repository _repository;

  const Get${_name.pascalCase}(this._repository);

  @override
  Future<Either<Failure, List<${_name.pascalCase}>>> call(NoParams params) {
    return _repository.getAll();
  }
}
''';
}
