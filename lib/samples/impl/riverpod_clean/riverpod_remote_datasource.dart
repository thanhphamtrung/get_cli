import 'package:recase/recase.dart';

import '../../interface/sample_interface.dart';

/// Template for data/datasources/{name}_remote_datasource.dart
class RiverpodRemoteDataSourceSample extends Sample {
  final String _name;

  RiverpodRemoteDataSourceSample(this._name, {String? path})
      : super(
            path ??
                'lib/features/${_name.snakeCase}/data/datasources/${_name.snakeCase}_remote_datasource.dart',
            overwrite: true);

  @override
  String get content => '''
import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../models/${_name.snakeCase}_model.dart';

abstract class ${_name.pascalCase}RemoteDataSource {
  Future<List<${_name.pascalCase}Model>> getAll();
  Future<${_name.pascalCase}Model> getById(String id);
}

class ${_name.pascalCase}RemoteDataSourceImpl implements ${_name.pascalCase}RemoteDataSource {
  final Dio _dio;

  const ${_name.pascalCase}RemoteDataSourceImpl(this._dio);

  @override
  Future<List<${_name.pascalCase}Model>> getAll() async {
    try {
      final response = await _dio.get('/${_name.snakeCase}s');
      return (response.data as List)
          .map((json) => ${_name.pascalCase}Model.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<${_name.pascalCase}Model> getById(String id) async {
    try {
      final response = await _dio.get('/${_name.snakeCase}s/\$id');
      return ${_name.pascalCase}Model.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
''';
}
