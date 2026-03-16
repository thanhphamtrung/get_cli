import '../../interface/sample_interface.dart';

/// Template for core/error/exceptions.dart
class RiverpodExceptionsSample extends Sample {
  RiverpodExceptionsSample({String path = 'lib/core/error/exceptions.dart'})
      : super(path, overwrite: true);

  @override
  String get content => '''
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException({required this.message, this.statusCode});

  @override
  String toString() => 'ServerException(\$statusCode): \$message';
}

class CacheException implements Exception {
  final String message;

  const CacheException({required this.message});

  @override
  String toString() => 'CacheException: \$message';
}
''';
}
