class CategoryListModel {
  CategoryListModel({
    required this.category,
  });
  late final List<Category> category;

  CategoryListModel.fromJson(Map<String, dynamic> json){
    category = List.from(json['category']).map((e)=>Category.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['category'] = category.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Category {
  Category({
    required this.catgoryId,
    required this.name,
    required this.parentId,
    required this.displayOrder,
    required this.image,
    required this.products,
  });
  late final String catgoryId;
  late final String name;
  late final String parentId;
  late final String displayOrder;
  late final String image;
  late final String products;

  Category.fromJson(Map<String, dynamic> json){
    catgoryId = json['catgoryId'];
    name = json['name'];
    parentId = json['parentId'];
    displayOrder = json['displayOrder'];
    image = json['image'];
    products = json['products'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['catgoryId'] = catgoryId;
    _data['name'] = name;
    _data['parentId'] = parentId;
    _data['displayOrder'] = displayOrder;
    _data['image'] = image;
    _data['products'] = products;
    return _data;
  }
}