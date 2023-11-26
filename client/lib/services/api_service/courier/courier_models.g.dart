// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courier_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Courier _$CourierFromJson(Map<String, dynamic> json) => Courier(
      id: json['id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      price: json['price'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$CourierToJson(Courier instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
