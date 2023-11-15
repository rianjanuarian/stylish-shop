// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'api_service_models.g.dart';

@JsonSerializable()
class LoginRequest {
  String? email;
  String? password;

  LoginRequest();

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class LoginResponse {
  String? message;
  String? token;

  LoginResponse();

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class BaseResponse<T> {
  BaseResponse();

  bool? isSuccess;

  int? statusCode;

  String? message;

  @JsonKey(ignore: true)
  T? payload;

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) map,
  ) {
    final tempResponse = _$BaseResponseFromJson(json);
    final response = BaseResponse<T>()
      ..isSuccess = tempResponse.isSuccess
      ..message = tempResponse.message
      ..statusCode = tempResponse.statusCode;
    response.payload = map(json);
    return response;
  }
}
