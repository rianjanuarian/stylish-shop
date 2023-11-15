import 'dart:async';

import 'package:client/services/api_service/api_service_models.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

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
      dio.options.baseUrl = 'http://192.168.1.12:3000';
    } else {
      dio.options.baseUrl = 'http://192.168.1.12:3000';
    }
  }

  FutureOr<BaseResponse<LoginResponse>> auth(
    LoginRequest request, {
    CancelToken? cancelToken,
  }) async {
    final Response<Map<String, dynamic>> result =
        await dio.request('/users/login_with_email',
            options: Options(
              method: 'POST',
            ),
            data: request.toJson(),
            cancelToken: cancelToken);
    final value = BaseResponse.fromJson(
        result.data!, (json) => LoginResponse.fromJson(json));
    return Future.value(value);
  }
}

class ApiServiceImpl extends ApiService {}
