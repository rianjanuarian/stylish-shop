import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Category {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  CategoryProduct? categoryProduct;

  Category({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.categoryProduct,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

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
class Brand {
  int? id;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;
  BrandProduct? brandProduct;

  Brand({
    this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.brandProduct,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);
}

@JsonSerializable()
class BrandProduct {
  int? productId;
  int? brandId;
  String? createdAt;
  String? updatedAt;

  BrandProduct({
    this.productId,
    this.brandId,
    this.createdAt,
    this.updatedAt,
  });

  factory BrandProduct.fromJson(Map<String, dynamic> json) => _$BrandProductFromJson(json);

  Map<String, dynamic> toJson() => _$BrandProductToJson(this);
}

@JsonSerializable()
class Product {
  int? id;
  String? name;
  int? price;
  String? description;
  int? stock;
  String? image;
  List<String>? colors;
  String? createdAt;
  String? updatedAt;
  List<Category>? categories;
  List<Brand>? brands;

  Product({
    this.id,
    this.name,
    this.price,
    this.description,
    this.stock,
    this.image,
    this.colors,
    this.createdAt,
    this.updatedAt,
    this.categories,
    this.brands,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
