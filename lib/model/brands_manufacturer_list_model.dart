class BrandManufacturerModel {
  BrandManufacturerModel({
    required this.product,
  });
  late final List<BrandProduct> product;

  BrandManufacturerModel.fromJson(Map<String, dynamic> json){
    product = List.from(json['product']).map((e)=>BrandProduct.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product'] = product.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class BrandProduct {
  BrandProduct({
    required this.productId,
    required this.manufacturerID,
    required this.manufacturerName,
    required this.name,
    required this.image,
  });
  late final String productId;
  late final String manufacturerID;
  late final String manufacturerName;
  late final String name;
  late final String image;

  BrandProduct.fromJson(Map<String, dynamic> json){
    productId = json['productId'];
    manufacturerID = json['manufacturerID'];
    manufacturerName = json['manufacturerName'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['productId'] = productId;
    _data['manufacturerID'] = manufacturerID;
    _data['manufacturerName'] = manufacturerName;
    _data['name'] = name;
    _data['image'] = image;
    return _data;
  }
}