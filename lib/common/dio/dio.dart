import 'package:codefactory_flutter/common/const/data.dart';
import 'package:codefactory_flutter/common/secure_storage/secure_storage.dart';
import 'package:codefactory_flutter/user/provider/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(
    CustomInterceptor(storage: storage, ref: ref)
  );
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      compact: true,
      maxWidth: 90)
  );
  return dio;
});

class CustomInterceptor extends Interceptor {
  CustomInterceptor({
    required this.storage,
    required this.ref,
  });

  final FlutterSecureStorage storage;
  final Ref ref;

  // 1) 요청을 보낼 때
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }
    return super.onRequest(options, handler);
  }

  // 2) 응답을 받을 때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

  // 3) 에러가 났을 때
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // 401 에러 -> 토큰 재발급 -> 재요청
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    if (refreshToken == null) {
      return handler.reject(err);
    }
    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';
    if (isStatus401 && !isPathRefresh) {
      try {
        final dio = Dio();
        final response = await dio.post(
            'http://$ip/auth/token',
            options: Options(
                headers: {
                  'authrization': 'Bearer $refreshToken',
                }
            )
        );
        final accessToken = response.data['accessToken'];
        final options = err.requestOptions;
        options.headers.addAll({
          'authrization': 'Bearer $accessToken',
        });
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
        final response2 = await dio.fetch(options);
        return handler.resolve(response2);
      } on DioError catch (e) {
        ref.read(authProvier.notifier).logout();
        return handler.reject(err);
      }
    }

    return handler.reject(err);
  }
}