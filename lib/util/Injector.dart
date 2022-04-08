import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';

GetIt locator = GetIt.instance;

Future baseDio() async {
  final options = BaseOptions(
    connectTimeout: 300000,
    receiveTimeout: 300000,
  );

  var dio = Dio(options);

  dio.interceptors.add(
    DioLoggingInterceptor(
      level: Level.body,
      compact: false,
    ),
  );

  locator.registerSingleton<Dio>(dio);
}
