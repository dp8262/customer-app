class ProductListModel {
  ProductListModel({
    required this.product,
  });
  late final List<Product> product;

  ProductListModel.fromJson(Map<String, dynamic> json){
    product = List.from(json['product']).map((e)=>Product.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product'] = product.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Product {
  Product({
    required this.parentCategoryId,
    required this.categoryId,
    required this.productId,
    required this.price,
    required this.brandName,
    required this.name,
    required this.image,
  });
  late final String parentCategoryId;
  late final String categoryId;
  late final String productId;
  late final String price;
  late final String brandName;
  late final String name;
  late final String image;

  Product.fromJson(Map<String, dynamic> json){
    parentCategoryId = json['ParentCategoryId'];
    categoryId = json['categoryId'];
    productId = json['productId'];
    price = json['price'];
    brandName = json['brandName'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ParentCategoryId'] = parentCategoryId;
    _data['categoryId'] = categoryId;
    _data['productId'] = productId;
    _data['price'] = price;
    _data['brandName'] = brandName;
    _data['name'] = name;
    _data['image'] = image;
    return _data;
  }
}