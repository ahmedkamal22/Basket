import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static getInit() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String key,
    Map<String, dynamic>? query,
    String lang = "en",
    String? token,
  }) async {
    dio!.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": token
    };
    return await dio!.get(key, queryParameters: query);
  }

  static Future<Response> postData({
    required String key,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = "en",
    String? token,
  }) async {
    dio!.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": token
    };
    return await dio!.post(key, data: data, queryParameters: query);
  }

  static Future<Response> putData({
    required String key,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = "en",
    String? token,
  }) async {
    dio!.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": token
    };
    return await dio!.put(key, queryParameters: query, data: data);
  }
}
