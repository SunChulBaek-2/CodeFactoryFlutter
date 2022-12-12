import 'package:codefactory_flutter/common/const/data.dart';
import 'package:codefactory_flutter/common/dio/dio.dart';
import 'package:codefactory_flutter/common/provider/go_router.dart';
import 'package:codefactory_flutter/common/view/splash_screen.dart';
import 'package:codefactory_flutter/restaurant/view/restaurant_detail_screen.dart';
import 'package:codefactory_flutter/user/provider/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final logger = PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseHeader: false,
    responseBody: true,
    error: true,
    compact: true,
    maxWidth: 90
);
//final dio = Dio()..interceptors.add(logger)..interceptors.add(CustomInterceptor(storage: storage));

void main() {
  runApp(
    const ProviderScope(
      child: MyApp()
    )
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'NotoSans'
      ),
      routerConfig: router,
    );
  }
}