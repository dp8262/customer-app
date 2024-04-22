class ProductInterestedListModel {
  ProductInterestedListModel({
    required this.customerItems,
  });
  late final List<CustomerItems> customerItems;

  ProductInterestedListModel.fromJson(Map<String, dynamic> json){
    customerItems = List.from(json['customerItems']).map((e)=>CustomerItems.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['customerItems'] = customerItems.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class CustomerItems {
  CustomerItems({
    required this.image,
    required this.thumb,
    required this.id,
    required this.name,
    required this.sku,
    required this.brandName,
    required this.unit,
  });
  late final List<String> image;
  late final String thumb;
  late final String id;
  late final String name;
  late final String sku;
  late final String brandName;
  late final String unit;

  CustomerItems.fromJson(Map<String, dynamic> json){
    image = List.castFrom<dynamic, String>(json['image']);
    thumb = json['thumb'];
    id = json['id'];
    name = json['name'];
    sku = json['sku'];
    brandName = json['brandName'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image'] = image;
    _data['thumb'] = thumb;
    _data['id'] = id;
    _data['name'] = name;
    _data['sku'] = sku;
    _data['brandName'] = brandName;
    _data['unit'] = unit;
    return _data;
  }
}