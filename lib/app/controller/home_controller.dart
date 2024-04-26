import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/apiServices/common_widget.dart';
import 'package:shopperz/app/apiServices/network_call.dart';
import 'package:shopperz/app/modules/category/views/sqlite_helper.dart';
import 'package:shopperz/model/brands_manufacturer_list_model.dart';
import 'package:shopperz/model/home_associate_brand_model.dart';
import 'package:shopperz/model/home_banner_model.dart';
import 'package:shopperz/utils/api_list.dart';
import '../../model/product_sub_list_model.dart';

class HomeControllers extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  RxString error = "".obs;
  RxInt dotIndex = 0.obs;

  RxList<BannerList> bannerList = <BannerList>[].obs;
  RxList<HomePageCategory> homePageCategoryList = <HomePageCategory>[].obs;
  RxList<HomePageProduct> homePageProductList = <HomePageProduct>[].obs;
  //
  // ContactDatabaseHelper contactDatabaseHelper = ContactDatabaseHelper();
  // RxList<Product> recentProductList = <Product>[].obs;

  // void handleSliderDots(int index) {
  //   dotIndex.value = index;
  // }

  // @override
  // void onInit() {
  //   homeBannerList(context: );
  //   super.onInit();
  // }

  homeBannerList({required BuildContext context}) async {
    isLoading(true);
    isError(false);
    error("");
    bannerList.clear();
    homePageCategoryList.clear();
    homePageProductList.clear();
    // recentProductList.clear();
    try {
      // await contactDatabaseHelper.initializeDatabase();
      // recentProductList.value= await  contactDatabaseHelper.getAllRecentProduct();
      // recentProductList.value=    recentProductList.reversed.toList();
      print("a=======");
      getAPI(
          methodName: ApiList.slider,
          param: {},
          callback: (value) {
            print("123456=======");
            try {
              Map<String, dynamic> valueMap = json.decode(value.response);
              // if (valueMap.containsKey("customer") && valueMap["customer"] != null) {
              print("b=======");

              HomeBannerModel homeBannerModel = HomeBannerModel.fromJson(valueMap);
                bannerList.addAll(homeBannerModel.banner);
                homePageCategoryList.addAll(homeBannerModel.homePageCategory);
                print(homePageCategoryList.length);
              homePageProductList.addAll(homeBannerModel.homePageProduct);
              promotionCategoryBanner(context: context);
              // isLoading(false);
              // }
            } catch (e) {
              handleError("Error decoding response: $e", context);
              isLoading(false);
            }
          }
      );
    } catch (ex) {
      handleError("Failed to fetch data: $ex", context);
      // isLoading(false);
    }
  }

  RxList<CategoryBanner> promotionCategoryBannerList = <CategoryBanner>[].obs;
  promotionCategoryBanner({required BuildContext context}) async {
    isLoading(true);
    isError(false);
    error("");
    promotionCategoryBannerList.clear();
    try {
      getAPI(
          methodName: ApiList.promotionCategoryBanner,
          param: {},
          callback: (value) {
            try {
              Map<String, dynamic> valueMap = json.decode(value.response);
              // if (valueMap.containsKey("customer") && valueMap["customer"] != null) {
              PromotionCategoryBanner promotionCategoryBanner = PromotionCategoryBanner.fromJson(valueMap);
              promotionCategoryBannerList.addAll(promotionCategoryBanner.categoryBanner);
              associateBrandsList(context: context);
                // isLoading(false);
              // }
            } catch (e) {
              handleError("Error response: $e", context);
              isLoading(false);
            }
          }
      );
    } catch (ex) {
      handleError("Failed to fetch data: $ex", context);
      // isLoading(false);
    }
  }

  RxList<Manufacturer> manufacturerList = <Manufacturer>[].obs;
  associateBrandsList({required BuildContext context}) async {
    isLoading(true);
    isError(false);
    error("");
    manufacturerList.clear();
    try {
      getAPI(
          methodName: ApiList.associateBrands,
          param: {},
          callback: (value) {
            try {
              Map<String, dynamic> valueMap = json.decode(value.response);
              ManufacturerBrandsList manufacturerBrandsList = ManufacturerBrandsList.fromJson(valueMap);
              manufacturerList.addAll(manufacturerBrandsList.manufacturer);
                isLoading(false);
              // }
            } catch (e) {
              handleError("Error response: $e", context);
              isLoading(false);
            }
          }
      );
    } catch (ex) {
      handleError("Failed to fetch data: $ex", context);
      isLoading(false);
    }
  }

  RxList<BrandProduct> brandProductList = <BrandProduct>[].obs;
  String sortByID = "5";

  brandsManufacturerList({required BuildContext context,    required String productBrandId,
  }) async {
    isLoading(true);
    isError(false);
    error("");
    brandProductList.clear();
    try {
      getAPI(
          methodName: ApiList.brandsManufacturerList,
          param: {"id": productBrandId, "sort": "5"},
          callback: (value) {
            try {
              Map<String, dynamic> valueMap = json.decode(value.response);
              BrandManufacturerModel brandManufacturerModel = BrandManufacturerModel.fromJson(valueMap);
              brandProductList.addAll(brandManufacturerModel.product);
                isLoading(false);
              // }
            } catch (e) {
              handleError("Error response: $e", context);
              isLoading(false);
            }
          }
      );
    } catch (ex) {
      handleError("Failed to fetch data: $ex", context);
      isLoading(false);
    }
  }
  filterBrandsProductListDetails({
    required BuildContext context,
    required String productBrandId,
    required String sortBy,
  }) async {
    isLoading(true);
    isError(false);
    error("");
    brandProductList.clear();

    try {
      if (brandProductList.isEmpty) {
        if (sortBy == "Name A to Z") {
          sortByID = "5";
        }
        if (sortBy == "Name Z to A") {
          sortByID = "6";
        }
        if (sortBy == "Created on") {
          sortByID = "15";
        }
        getAPI(
            methodName: ApiList.brandsManufacturerList,
            param: {"id": productBrandId, "sort": sortByID},
            callback: (value) {
              try {
                Map<String, dynamic> valueMap = json.decode(value.response);
                // if (valueMap["statusCode"] == 200) {
                BrandManufacturerModel brandManufacturerModel = BrandManufacturerModel.fromJson(valueMap);
                brandProductList.addAll(brandManufacturerModel.product);
                isLoading(false);
                // }
              } catch (e) {
                handleError("Error response: $e", context);
                isLoading(false);
              }
            });
      } else {
        isLoading(false);
      }
    } catch (ex) {
      handleError("Failed to fetch data: $ex", context);
      isLoading(false);
    }
  }

}
