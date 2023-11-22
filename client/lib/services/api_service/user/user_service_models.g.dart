// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_service_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int?,
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      image: json['image'] as String?,
      address: json['address'] as String?,
      role: json['role'] as String?,
      gender: json['gender'],
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      phone_number: json['phone_number'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updateAt: json['updateAt'] == null
          ? null
          : DateTime.parse(json['updateAt'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'image': instance.image,
      'address': instance.address,
      'role': instance.role,
      'gender': instance.gender,
      'birthday': instance.birthday?.toIso8601String(),
      'phone_number': instance.phone_number,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updateAt': instance.updateAt?.toIso8601String(),
    };
