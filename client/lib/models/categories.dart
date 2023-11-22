class Categories {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Products>? products;

  Categories(
      {this.id, this.name, this.createdAt, this.updatedAt, this.products});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? name;
  int? price;
  String? description;
  int? stock;
  String? image;
  List<String>? colors;
  String? createdAt;
  String? updatedAt;
  Categoryproduct? categoryproduct;

  Products(
      {this.id,
      this.name,
      this.price,
      this.description,
      this.stock,
      this.image,
      this.colors,
      this.createdAt,
      this.updatedAt,
      this.categoryproduct});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    stock = json['stock'];
    image = json['image'];
    colors = json['colors'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    categoryproduct = json['categoryproduct'] != null
        ? Categoryproduct.fromJson(json['categoryproduct'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['stock'] = stock;
    data['image'] = image;
    data['colors'] = colors;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (categoryproduct != null) {
      data['categoryproduct'] = categoryproduct!.toJson();
    }
    return data;
  }
}

class Categoryproduct {
  int? productId;
  int? categoryId;
  String? createdAt;
  String? updatedAt;

  Categoryproduct(
      {this.productId, this.categoryId, this.createdAt, this.updatedAt});

  Categoryproduct.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    categoryId = json['categoryId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['productId'] = productId;
    data['categoryId'] = categoryId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}