import 'package:shopperz/model/brands_manufacturer_list_model.dart';
import 'package:shopperz/model/product_sub_list_model.dart';

class RecentProduct{
  late final Product? product;
  late final BrandProduct? brandProduct;

  RecentProduct({this.product, this.brandProduct});

  RecentProduct.fromJson(Map<String, dynamic> json) {
    product = (json['product'] != null ? Product.fromJson(json['product']) : null);
    brandProduct = (json['brandProduct'] != null ? BrandProduct.fromJson(json['brandProduct']) : null);
  }
}