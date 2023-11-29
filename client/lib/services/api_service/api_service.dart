import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:stylish_shop/services/api_service/api_service_models.dart';

const String authorization = 'authorization';

abstract class ApiService {
  final Dio _dio = Dio();
  Dio get dio => _dio;

  var storage = GetStorage();

  ApiService({
    GetStorage? storage,
  }) {
    this.storage = storage ?? (storage = this.storage);

    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));

    if (kDebugMode) {
      dio.options.baseUrl = 'https://stylish-shop.vercel.app';
    } else {
      dio.options.baseUrl = 'https://stylish-shop.vercel.app';
    }
  }

  FutureOr<BaseResponse<LoginResponse>> loginWithEmail(
    LoginRequest request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final Response<Map<String, dynamic>> result = await dio.request(
          '/users/login_with_email',
          options: Options(method: 'POST'),
          data: request.toJson(),
          cancelToken: cancelToken);

      final value = BaseResponse.fromJson(
          result.data!, (json) => LoginResponse.fromJson(json));
      return value;
    } catch (e) {
      rethrow;
    }
  }

  FutureOr<Response> registerWithEmail(
    RegisterRequest request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final Response result = await dio.request(
        '/users/register_with_email',
        options: Options(
          method: 'POST',
        ),
        data: request.toJson(),
        cancelToken: cancelToken,
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }

  FutureOr<Response> loginWithGoogle(
    String? email,
    String? uid,
    String? name, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio
          .post('/users/login_with_google', cancelToken: cancelToken, data: {
        'name': name,
      }, queryParameters: {
        'email': email,
        'uid': uid,
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

class ApiServiceImpl extends ApiService {}
