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
     this.description,

     this.youtubeVideoUrl,
     this.youtubeVideoId,

     // this.youtubeVideoId1,
     // this.youtubeVideoId2,
     // this.youtubeVideoId3,
     // this.youtubeVideoId4,
     // this.youtubeVideoId5,
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
  late final String? description;

  //issue
  late final String? youtubeVideoUrl;
  late final String? youtubeVideoId;
  // late final String? youtubeVideoId1;
  // late final String? youtubeVideoId2;
  // late final String? youtubeVideoId3;
  // late final String? youtubeVideoId4;
  // late final String? youtubeVideoId5;

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
    description = json['discription'];
    youtubeVideoUrl = json['YoutubeVideoUrl'];
    youtubeVideoId = json['YoutubeVideoId'];
    // youtubeVideoId1 = json['YoutubeVideoId1'];
    // youtubeVideoId2 = json['YoutubeVideoId2'];
    // youtubeVideoId3 = json['YoutubeVideoId3'];
    // youtubeVideoId4 = json['YoutubeVideoId4'];
    // youtubeVideoId5 = json['YoutubeVideoId5'];
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
    _data['discription'] = description;
    _data['YoutubeVideoUrl'] = youtubeVideoUrl;
    _data['YoutubeVideoId'] = youtubeVideoId;
    // _data['YoutubeVideoId1'] = youtubeVideoId1;
    // _data['YoutubeVideoId2'] = youtubeVideoId2;
    // _data['YoutubeVideoId3'] = youtubeVideoId3;
    // _data['YoutubeVideoId4'] = youtubeVideoId4;
    // _data['YoutubeVideoId5'] = youtubeVideoId5;
    _data['fullDescription'] = fullDescription;
    return _data;
  }
}