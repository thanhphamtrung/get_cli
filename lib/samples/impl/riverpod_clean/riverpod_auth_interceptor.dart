import '../../interface/sample_interface.dart';

/// Template for core/network/interceptors/auth_interceptor.dart
class RiverpodAuthInterceptorSample extends Sample {
  RiverpodAuthInterceptorSample(
      {String path = 'lib/core/network/interceptors/auth_interceptor.dart'})
      : super(path, overwrite: true);

  @override
  String get content => '''
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthInterceptor extends Interceptor {
  final Ref _ref;

  AuthInterceptor(this._ref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: Add auth token from secure storage
    // final token = _ref.read(authTokenProvider);
    // if (token != null) {
    //   options.headers['Authorization'] = 'Bearer \$token';
    // }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // TODO: Handle token refresh or logout
    }
    handler.next(err);
  }
}
''';
}
