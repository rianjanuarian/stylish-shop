import 'package:json_annotation/json_annotation.dart';
import '../product/product_model.dart';
part 'category_model.g.dart';

@JsonSerializable()
class CategoryProduct {
  int? productId;
  int? categoryId;
  String? createdAt;
  String? updatedAt;

  CategoryProduct({
    this.productId,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryProduct.fromJson(Map<String, dynamic> json) => _$CategoryProductFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryProductToJson(this);
}

@JsonSerializable()
class Category {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Product>? products;

  Category({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
