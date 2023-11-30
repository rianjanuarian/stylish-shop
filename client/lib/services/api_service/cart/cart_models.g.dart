// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      productId: json['productId'] as int?,
      qty: json['qty'] as int?,
      total_price: json['total_price'] as int?,
      color: json['color'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    )..status = $enumDecodeNullable(_$StatusEnumMap, json['status']);

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'productId': instance.productId,
      'qty': instance.qty,
      'total_price': instance.total_price,
      'color': instance.color,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'product': instance.product,
      'status': _$StatusEnumMap[instance.status],
    };

const _$StatusEnumMap = {
  Status.active: 'active',
  Status.inactive: 'inactive',
};
