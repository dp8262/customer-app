
class HomeBannerModel {
  HomeBannerModel({
    required this.banner,
    required this.homePageCategory,
    required this.homePageProduct,
    required this.syncTime,
  });
  late final List<BannerList> banner;
  late final List<HomePageCategory> homePageCategory;
  late final List<HomePageProduct> homePageProduct;
  late final List<SyncTime> syncTime;

  HomeBannerModel.fromJson(Map<String, dynamic> json){
    banner = List.from(json['banner']).map((e)=>BannerList.fromJson(e)).toList();
    homePageCategory = List.from(json['HomePageCategory']).map((e)=>HomePageCategory.fromJson(e)).toList();
    homePageProduct = List.from(json['HomePageProduct']).map((e)=>HomePageProduct.fromJson(e)).toList();
    syncTime = List.from(json['SyncTime']).map((e)=>SyncTime.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['banner'] = banner.map((e)=>e.toJson()).toList();
    _data['HomePageCategory'] = homePageCategory.map((e)=>e.toJson()).toList();
    _data['HomePageProduct'] = homePageProduct.map((e)=>e.toJson()).toList();
    _data['SyncTime'] = syncTime.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class BannerList {
  BannerList({
    required this.image,
    required this.link,
  });
  late final String image;
  late final String link;

  BannerList.fromJson(Map<String, dynamic> json){
    image = json['image'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image'] = image;
    _data['link'] = link;
    return _data;
  }
}

class HomePageCategory {
  HomePageCategory({
    required this.image,
    required this.categoryId,
    required this.name,
  });
  late final String image;
  late final String categoryId;
  late final String name;

  HomePageCategory.fromJson(Map<String, dynamic> json){
    image = json['image'];
    categoryId = json['categoryId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image'] = image;
    _data['categoryId'] = categoryId;
    _data['name'] = name;
    return _data;
  }
}

class HomePageProduct {
  HomePageProduct({
    required this.image,
    required this.productId,
    required this.name,
    required this.brandName,
    required this.price,
  });
  late final String image;
  late final String productId;
  late final String name;
  late final String brandName;
  late final String price;

  HomePageProduct.fromJson(Map<String, dynamic> json){
    image = json['image'];
    productId = json['productId'];
    name = json['name'];
    brandName = json['brandName'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image'] = image;
    _data['productId'] = productId;
    _data['name'] = name;
    _data['brandName'] = brandName;
    _data['price'] = price;
    return _data;
  }
}

class SyncTime {
  SyncTime({
    required this.LastSyncTime,
  });
  late final String LastSyncTime;

  SyncTime.fromJson(Map<String, dynamic> json){
    LastSyncTime = json['LastSyncTime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['LastSyncTime'] = LastSyncTime;
    return _data;
  }
}

class PromotionCategoryBanner {
  PromotionCategoryBanner({
    required this.categoryBanner,
  });
  late final List<CategoryBanner> categoryBanner;

  PromotionCategoryBanner.fromJson(Map<String, dynamic> json){
    categoryBanner = List.from(json['CategoryBanner']).map((e)=>CategoryBanner.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['CategoryBanner'] = categoryBanner.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class CategoryBanner {
  CategoryBanner({
    required this.id,
    required this.categoryID,
    required this.categoryName,
    required this.nopCategoryId,
    required this.categoryBanner,
  });
  late final String id;
  late final String categoryID;
  late final String categoryName;
  late final String nopCategoryId;
  late final String categoryBanner;

  CategoryBanner.fromJson(Map<String, dynamic> json){
    id = json['Id'];
    categoryID = json['CategoryID'];
    categoryName = json['CategoryName'];
    nopCategoryId = json['NopCategoryId'];
    categoryBanner = json['CategoryBanner'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Id'] = id;
    _data['CategoryID'] = categoryID;
    _data['CategoryName'] = categoryName;
    _data['NopCategoryId'] = nopCategoryId;
    _data['CategoryBanner'] = categoryBanner;
    return _data;
  }
}