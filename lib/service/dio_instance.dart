import 'package:dio/io.dart';
import 'package:trump/service/interceptors.dart';
import 'package:dio/dio.dart';

class DioInstance {
  static DioInstance? _instance;

  DioInstance._();

  static DioInstance instance() {
    return _instance ??= DioInstance._();
  }

  final Dio _dio = Dio();

  final _defaultTime = const Duration(seconds: 30);

  // 在程序运行一开始就initDio.
  void initDio({
    required String baseUrl,
    String? httpMethod = "GET",
    Duration? connectTime,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    ResponseType? responseType = ResponseType.json,
    String? contentType,
  }) {
    _dio.options = BaseOptions(
      method: httpMethod ?? "GET",
      baseUrl: baseUrl,
      connectTimeout: connectTime ?? _defaultTime,
      receiveTimeout: receiveTimeout ?? _defaultTime,
      sendTimeout: sendTimeout ?? _defaultTime,
      responseType: responseType,
      contentType: contentType,
    );
    // 加入拦截器
    //_dio.interceptors.add(RequestInterceptor());
    _dio.interceptors.add(PrintLogInterceptor());
    _dio.interceptors.add(ResponseInterceptor());

    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true;
      };
      return null;
    };
  }

  //  todo:在所有的请求前加上"X-Token"，本应当在拦截器里完成，但是在拦截器里加自定义请求头无效，所以在下面的
  // get,post,put,delete里手动加上自定义请求头。
  // get请求
  Future<Response> get({
    required String path,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    String token = "";
    return await _dio.get(
      path,
      queryParameters: params,
      options: options ??
          Options(
              method: "GET",
              receiveTimeout: _defaultTime,
              sendTimeout: _defaultTime,
              headers: {
                "X-Token": token,
              }),
    );
  }

  //  post请求
  Future<Response> post({
    required String path,
    Map<String, dynamic>? params,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    String token = "";
    return await _dio.post(
      path,
      queryParameters: params,
      data: data,
      cancelToken: cancelToken,
      options: options ??
          Options(
            method: "POST",
            receiveTimeout: _defaultTime,
            sendTimeout: _defaultTime,
            headers: {
              "X-Token": token,
              "Content-Type": "application/json",
            },
          ),
    );
  }

  // delte请求
  Future<Response> delete({
    required String path,
    Map<String, dynamic>? params,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    String token = "";
    return await _dio.delete(
      path,
      queryParameters: params,
      data: data,
      cancelToken: cancelToken,
      options: options ??
          Options(
              method: "POST",
              receiveTimeout: _defaultTime,
              sendTimeout: _defaultTime,
              headers: {
                "X-Token": token,
              }),
    );
  }

  // put 请求
  Future<Response> put({
    required String path,
    Map<String, dynamic>? params,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    //String token = .getInstance().getString("token");
    //String token = cache
    String token = "";
    return await _dio.put(
      path,
      queryParameters: params,
      data: data,
      cancelToken: cancelToken,
      options: options ??
          Options(
              method: "POST",
              receiveTimeout: _defaultTime,
              sendTimeout: _defaultTime,
              headers: {
                "X-Token": token,
                "Content-Type": "application/json",
              }),
    );
  }
}
