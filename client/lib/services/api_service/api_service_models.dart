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
  // ignore: non_constant_identifier_names
  String? access_token;

  LoginResponse();

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class RegisterRequest {
  String? name;
  String? email;
  String? password;
  String? uid;

  RegisterRequest({this.name, this.email, this.password, this.uid});

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

@JsonSerializable()
class BaseResponse<T> {
  BaseResponse();

  bool? isSuccess;

  int? statusCode;

  String? message;

  // ignore: deprecated_member_use
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
