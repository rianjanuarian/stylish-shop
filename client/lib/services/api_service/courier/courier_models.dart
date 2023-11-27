import 'package:json_annotation/json_annotation.dart';

part 'courier_models.g.dart';

@JsonSerializable()
class Courier {
  int? id;
  String? name;
  int? price;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  Courier({
    this.id,
    this.name,
    this.price,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Courier.fromJson(Map<String, dynamic> json) =>
      _$CourierFromJson(json);

  Map<String, dynamic> toJson() => _$CourierToJson(this);
}
