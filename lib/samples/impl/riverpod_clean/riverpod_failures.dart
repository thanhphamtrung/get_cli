import '../../interface/sample_interface.dart';

/// Template for core/error/failures.dart — sealed Failure class
class RiverpodFailuresSample extends Sample {
  RiverpodFailuresSample({String path = 'lib/core/error/failures.dart'})
      : super(path, overwrite: true);

  @override
  String get content => '''
sealed class Failure {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection'});
}
''';
}
