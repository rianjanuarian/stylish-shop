// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: json['id'] as int?,
      orderId: json['orderId'] as String?,
      midtranstoken: json['midtranstoken'] as String?,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      courier: json['courier'] == null
          ? null
          : Courier.fromJson(json['courier'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'midtranstoken': instance.midtranstoken,
      'status': _$StatusEnumMap[instance.status],
      'createdAt': instance.createdAt?.toIso8601String(),
      'courier': instance.courier,
    };

const _$StatusEnumMap = {
  Status.approve: 'approve',
  Status.pending: 'pending',
  Status.reject: 'reject',
};
