import 'package:json_annotation/json_annotation.dart';

part 'user_service_models.g.dart';

@JsonSerializable()
class UserModel {
  final int? id;
  final String? uid;
  final String? name;
  final String? email;
  final String? password;
  final String? image;
  final String? address;
  final String? role;
  final dynamic gender;
  final DateTime? birthday;
  final String? phone_number;
  final DateTime? createdAt;
  final DateTime? updateAt;

  UserModel({this.id, this.uid, this.name, this.email, this.password, this.image, this.address, this.role, this.gender, this.birthday, this.phone_number, this.createdAt, this.updateAt});
  

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}