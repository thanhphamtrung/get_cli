import '../../interface/sample_interface.dart';

/// Template for core/usecases/usecase.dart — abstract UseCase
class RiverpodUseCaseBaseSample extends Sample {
  RiverpodUseCaseBaseSample({String path = 'lib/core/usecases/usecase.dart'})
      : super(path, overwrite: true);

  @override
  String get content => '''
import 'package:fpdart/fpdart.dart';
import '../error/failures.dart';

/// Base use case interface.
///
/// [Type] is the return type on success.
/// [Params] is the input parameter type.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Use when no parameters are needed.
class NoParams {
  const NoParams();
}
''';
}
