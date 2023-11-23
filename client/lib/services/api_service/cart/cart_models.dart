import 'package:client/models/products.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_models.g.dart';

@JsonSerializable()
class Cart {
    int? id;
    int? userId;
    int? productId;
    int? qty;
    int? totalPrice;
    String? color;
    DateTime? createdAt;
    DateTime? updatedAt;
    Products? product;

    Cart({
        this.id,
        this.userId,
        this.productId,
        this.qty,
        this.totalPrice,
        this.color,
        this.createdAt,
        this.updatedAt,
        this.product,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

    Map<String, dynamic> toJson() => _$CartToJson(this);

}