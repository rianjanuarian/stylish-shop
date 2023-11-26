import 'package:json_annotation/json_annotation.dart';

part 'courier_models.g.dart';

@JsonSerializable()
class Courier {
  final String? id;
  final String? name;
  final String? image;
  final int? price;
  final String? createdAt;
  final String? updatedAt;

  Courier({
    this.id,
    this.name,
    this.image,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory Courier.fromJson(Map<String, dynamic> json) =>
      _$CourierFromJson(json);

  Map<String, dynamic> toJson() => _$CourierToJson(this);
}
