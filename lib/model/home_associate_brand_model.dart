class ManufacturerBrandsList {
  ManufacturerBrandsList({
    required this.manufacturer,
  });
  late final List<Manufacturer> manufacturer;

  ManufacturerBrandsList.fromJson(Map<String, dynamic> json){
    manufacturer = List.from(json['manufacturer']).map((e)=>Manufacturer.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['manufacturer'] = manufacturer.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Manufacturer {
  Manufacturer({
    required this.id,
    required this.image,
    required this.name,
    required this.noOfProduct,
  });
  late final String id;
  late final String image;
  late final String name;
  late final String noOfProduct;

  Manufacturer.fromJson(Map<String, dynamic> json){
    id = json['Id'];
    image = json['image'];
    name = json['name'];
    noOfProduct = json['noOfProduct'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['noOfProduct'] = noOfProduct;
    return data;
  }
}