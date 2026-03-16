import '../../interface/sample_interface.dart';

/// Template for core/network/dio_client.dart — Dio provider with @riverpod
class RiverpodDioClientSample extends Sample {
  RiverpodDioClientSample({String path = 'lib/core/network/dio_client.dart'})
      : super(path, overwrite: true);

  @override
  String get content => '''
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../config/env.dart';
import 'interceptors/auth_interceptor.dart';

part 'dio_client.g.dart';

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Env.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.addAll([
    AuthInterceptor(ref),
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
    ),
  ]);

  return dio;
}
''';
}
