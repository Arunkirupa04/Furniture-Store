import 'package:dio/dio.dart';

class DioClient {
  static Dio createDio() {
    final Dio dio = Dio(BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    // Additional configuration for the web
    dio.options.headers['Access-Control-Allow-Origin'] = '*';
    dio.options.headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS';
    dio.options.headers['Access-Control-Allow-Headers'] = 'Content-Type';

    return dio;
  }
}
