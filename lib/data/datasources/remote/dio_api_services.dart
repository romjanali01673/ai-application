
import 'dart:convert';
import 'package:ai_application/core/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioApiServices {
  final Dio _dio;
  String? _accessToken;
  String? _refreshToken;

  static final DioApiServices instance = DioApiServices._();

  DioApiServices._({String? baseUrl})
      : _dio = Dio(// called after create constractor.
          BaseOptions(
            baseUrl: baseUrl ?? "https://jsonplaceholder.typicode.com",
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {"Content-Type": "application/json"},
          ),
        ) 
          //constractor body
        { 

    // in here there are few interceptor class,
    // for request execute as top-buttom/forword 
    // for responce execute as buttom-top/reverse 
    _dio.interceptors.addAll([
      LoggingInterceptor(), // will print log
      
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 👉 Add Authorization header if token exists
          if (_accessToken != null) {
            options.headers["Authorization"] = "Bearer $_accessToken";
          }
          print("👉 [${options.method}] ${options.uri}");
          handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint("✅ [${response.statusCode}] ${response.data}");
          handler.next(response);
        },
        onError: (DioException err, handler) async {
          debugPrint("❌ Error[${err.response?.statusCode}] ${err.message}");

          // 👉 If Unauthorized (401), try refresh token
          if (err.response?.statusCode == 401 && _refreshToken != null) {
            try {
              final refreshResponse = await _dio.post(
                "/auth/refresh",
                data: {"refresh_token": _refreshToken},
              );

              _accessToken = refreshResponse.data["access_token"];

              // 🔁 Retry original request with new token
              final newRequest = err.requestOptions;
              newRequest.headers["Authorization"] = "Bearer $_accessToken";
              final retryResponse = await _dio.fetch(newRequest);

              return handler.resolve(retryResponse);
            } catch (e) {
              return handler.reject(err);
            }
          }

          handler.next(err);
        },
      ),
    
    ]);
  }

  /// 🔑 Set tokens after login
  void setTokens(String accessToken, String refreshToken) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  /// 🗑️ Clear tokens (logout)
  void clearTokens() {
    _accessToken = null;
    _refreshToken = null;
  }


  // common request function 
  Future<Response> makeRequest(
    String endpoint, 
    {dynamic data, 
    required HTTPMethod method, 
    Map<String, dynamic>? queryParams
  }) async {
    // try {
      switch (method){
        case HTTPMethod.get:
          return await _dio.get(endpoint, queryParameters: queryParams);
        case HTTPMethod.post:
          return await _dio.post(endpoint, data: data);
        case HTTPMethod.put:
          return await _dio.put(endpoint, data: data);
        case HTTPMethod.delete:
          return await _dio.delete(endpoint, data: data);
      }
    // }on DioException catch (e) {
    //   throw DioException(
    //     requestOptions: e.requestOptions,
    //     response: e.response,
    //     type: e.type,
    //     error: e.error,
    //     message: e.message ?? 'Failed to perform DELETE request',
    //   );
    // }catch (e){
    //   print("object");
    //   throw Exception('Unexpected error during DELETE request: $e');
    // }
  }
}




// Custom logging interceptor
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("🚀 Requesting: ${options.method} ${options.uri}");
    debugPrint("Headers: ${json.encode(options.headers)}");

    if (options.data is FormData) {
      final formData = options.data as FormData;
      debugPrint("Payload (FormData): Fields - ${formData.fields}");
      if (formData.files.isNotEmpty) {
        debugPrint("Payload (FormData): Files - ${formData.files.map((file) => file.key).toList()}");
      }
    } else {
      debugPrint("Payload: ${json.encode(options.data)}");
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("✅ StatusCode [${response.statusCode}] from ${response.requestOptions.uri}");
    debugPrint("Response: ${json.encode(response.data)}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint("❌ Error [${err.response?.statusCode}] from ${err.requestOptions.uri}");
    debugPrint("Error Message: ${json.encode(err.message)}");
    debugPrint("Error Data: ${json.encode(err.response?.data)}");
    super.onError(err, handler);
  }
}