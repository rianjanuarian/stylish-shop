// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as int?,
      name: json['name'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      categoryProduct: json['categoryProduct'] == null
          ? null
          : CategoryProduct.fromJson(
              json['categoryProduct'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'categoryProduct': instance.categoryProduct,
    };

CategoryProduct _$CategoryProductFromJson(Map<String, dynamic> json) =>
    CategoryProduct(
      productId: json['productId'] as int?,
      categoryId: json['categoryId'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$CategoryProductToJson(CategoryProduct instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'categoryId': instance.categoryId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

Brand _$BrandFromJson(Map<String, dynamic> json) => Brand(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      brandProduct: json['brandProduct'] == null
          ? null
          : BrandProduct.fromJson(json['brandProduct'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'brandProduct': instance.brandProduct,
    };

BrandProduct _$BrandProductFromJson(Map<String, dynamic> json) => BrandProduct(
      productId: json['productId'] as int?,
      brandId: json['brandId'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$BrandProductToJson(BrandProduct instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'brandId': instance.brandId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      description: json['description'] as String?,
      stock: json['stock'] as int?,
      image: json['image'] as String?,
      colors:
          (json['colors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      brands: (json['brands'] as List<dynamic>?)
          ?.map((e) => Brand.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'stock': instance.stock,
      'image': instance.image,
      'colors': instance.colors,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'categories': instance.categories,
      'brands': instance.brands,
    };
