import 'package:recase/recase.dart';

import '../../interface/sample_interface.dart';

/// Template for data/repositories/{name}_repository_impl.dart
class RiverpodRepositoryImplSample extends Sample {
  final String _name;

  RiverpodRepositoryImplSample(this._name, {String? path})
      : super(
            path ??
                'lib/features/${_name.snakeCase}/data/repositories/${_name.snakeCase}_repository_impl.dart',
            overwrite: true);

  @override
  String get content => '''
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/${_name.snakeCase}.dart';
import '../../domain/repositories/${_name.snakeCase}_repository.dart';
import '../datasources/${_name.snakeCase}_remote_datasource.dart';

class ${_name.pascalCase}RepositoryImpl implements ${_name.pascalCase}Repository {
  final ${_name.pascalCase}RemoteDataSource _remoteDataSource;

  const ${_name.pascalCase}RepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<${_name.pascalCase}>>> getAll() async {
    try {
      final models = await _remoteDataSource.getAll();
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ${_name.pascalCase}>> getById(String id) async {
    try {
      final model = await _remoteDataSource.getById(id);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
''';
}
