import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trump/service/save.dart';
import '../models/resp/index.dart';

class ResponseInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["one"] = "two";
    SaveService.readString().then((token) {
      print("这是拦截器得到token:${token}");
      options.headers["X-Token"] = token;
      super.onRequest(options, handler);
    });
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      var resp = Resp.fromJson(response.data);
      response.data = resp;
      return handler.next(response);
    } else if (response.statusCode == 401) {
      SaveService.writeString('');
    } else {
      var resp = Resp.fromJson(response.data);
      // handler.reject(
      //   DioException(
      //     requestOptions: response.requestOptions,
      //     message: resp.msg.toString(),
      //   ),
      // );
      response.data = resp;
      return handler.next(response);
    }
    super.onResponse(response, handler);
  }
}

class PrintLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("\n请求头信息---------------------------------->");
    options.headers.forEach((k, v) {
      debugPrint("path: ${options.uri}");
      debugPrint("method: ${options.method}");
      debugPrint("data: ${options.data}");
      debugPrint("queryParameters: ${options.queryParameters.toString()}");
    });
    debugPrint("<----------------------------------请求头信息\n");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("\n响应信息---------------------------------->");
    debugPrint("path: ${response.realUri}");
    debugPrint("headers: ${response.headers.toString()}");
    debugPrint("statusMessage: ${response.statusMessage}");
    debugPrint("statusCode: ${response.statusCode}");
    debugPrint("extra: ${response.extra}");
    debugPrint("data: ${response.data.toString()}");
    debugPrint("<----------------------------------响应信息\n");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint("\n请求错误----------------------------------->");
    debugPrint("error: ${err.toString()}");
    debugPrint("<-----------------------------------请求错误\n");
    super.onError(err, handler);
  }
}
