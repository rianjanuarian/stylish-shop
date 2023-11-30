import 'package:json_annotation/json_annotation.dart';
import '../courier/courier_models.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class Transaction {
  int? id;
  String? orderId;
  String? midtranstoken;
  Status? status;
  DateTime? createdAt;
  Courier? courier;

  Transaction({
    this.id,
    this.orderId,
    this.midtranstoken,
    this.status,
    this.createdAt,
    this.courier
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

enum Status { approve, pending, reject }
