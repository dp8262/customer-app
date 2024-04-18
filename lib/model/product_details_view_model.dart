class ProductDetailsModel {
  ProductDetailsModel({
    required this.productDetails,
  });
  late final List<ProductDetails> productDetails;

  ProductDetailsModel.fromJson(Map<String, dynamic> json){
    productDetails = List.from(json['productdetails']).map((e)=>ProductDetails.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['productdetails'] = productDetails.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ProductDetails {
  ProductDetails({
    required this.image,
    required this.my3dImage,
    required this.thumb,
    required this.id,
    required this.name,
    required this.sku,
    required this.slug,
    required this.unit,
    required this.price,
    required this.brandName,
    required this.packing,
    required this.isLock,
    required this.discription,
    required this.youtubeVideoUrl,
    required this.youtubeVideoId,
     this.fullDescription,
  });
  late final List<String> image;
  late final String my3dImage;
  late final String thumb;
  late final String id;
  late final String name;
  late final String sku;
  late final String slug;
  late final String unit;
  late final String price;
  late final String brandName;
  late final String packing;
  late final String isLock;
  late final String discription;
  late final String youtubeVideoUrl;
  late final String youtubeVideoId;
  late final String? fullDescription;

  ProductDetails.fromJson(Map<String, dynamic> json){
    image = List.castFrom<dynamic, String>(json['image']);
    my3dImage = json['my3dImage'];
    thumb = json['thumb'];
    id = json['id'];
    name = json['name'];
    sku = json['sku'];
    slug = json['slug'];
    unit = json['unit'];
    price = json['price'];
    brandName = json['brandName'];
    packing = json['Packing'];
    isLock = json['IsLock'];
    discription = json['discription'];
    youtubeVideoUrl = json['YoutubeVideoUrl'];
    youtubeVideoId = json['YoutubeVideoId'];
    fullDescription = json['fullDescription'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image'] = image;
    _data['my3dImage'] = my3dImage;
    _data['thumb'] = thumb;
    _data['id'] = id;
    _data['name'] = name;
    _data['sku'] = sku;
    _data['slug'] = slug;
    _data['unit'] = unit;
    _data['price'] = price;
    _data['brandName'] = brandName;
    _data['Packing'] = packing;
    _data['IsLock'] = isLock;
    _data['discription'] = discription;
    _data['YoutubeVideoUrl'] = youtubeVideoUrl;
    _data['YoutubeVideoId'] = youtubeVideoId;
    _data['fullDescription'] = fullDescription;
    return _data;
  }
}