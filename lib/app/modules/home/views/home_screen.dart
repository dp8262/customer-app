import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopperz/app/apiServices/common_widget.dart';
import 'package:shopperz/app/controller/home_controller.dart';
import 'package:shopperz/app/modules/auth/controller/auth_controler.dart';
import 'package:shopperz/app/modules/auth/views/sign_in.dart';
import 'package:shopperz/app/modules/category/views/category_wise_product_screen.dart';
import 'package:shopperz/app/modules/filter/controller/filter_controller.dart';
import 'package:shopperz/app/modules/home/controller/brand_controller.dart';
import 'package:shopperz/app/modules/home/controller/category_controller.dart';
import 'package:shopperz/app/modules/home/controller/flash_sale_controller.dart';
import 'package:shopperz/app/modules/home/controller/popular_product_controller.dart';
import 'package:shopperz/app/modules/home/controller/product_section_controller.dart';
import 'package:shopperz/app/modules/home/widgets/appbar.dart';
import 'package:shopperz/app/modules/home/widgets/category.dart';
import 'package:shopperz/app/modules/home/widgets/promotion_banner.dart';
import 'package:shopperz/app/modules/home/widgets/slider.dart';
import 'package:shopperz/app/modules/language/controller/language_controller.dart';
import 'package:shopperz/app/modules/product/widgets/product.dart';
import 'package:shopperz/app/modules/product_details/views/product_details.dart';
import 'package:shopperz/app/modules/profile/controller/profile_controller.dart';
import 'package:shopperz/app/modules/shipping/controller/show_address_controller.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/custom_text.dart';
import 'package:shopperz/widgets/shimmer/categories_shimmer.dart';
import 'package:shopperz/widgets/shimmer/product_shimmer.dart';
import 'package:shopperz/widgets/shimmer/slider_shimmer.dart';
import 'package:shopperz/widgets/title.dart';

import '../../../../config/theme/app_color.dart';
import '../../category/views/product_view_details_screen.dart';
import '../../product/views/product_list_screen.dart';
import '../../search/views/search_screen.dart';
import '../../wishlist/controller/wishlist_controller.dart';
import '../widgets/see_all_btn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeControllers homeControllers = Get.put(HomeControllers());

  @override
  void initState() {
    print("a==================");
    homeControllers.homeBannerList(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final categoryController = Get.put(CategoryController());
    // final productSectionController = Get.put(ProductSectionController());
    // AuthController authController = Get.put(AuthController());
    // ProfileController profile = Get.put(ProfileController());
    // LanguageController language = Get.put(LanguageController());
    // final filterController = Get.put(FilterController());
    // final flashSaleController = Get.put(FlashSaleControlelr());
    // final showAddressController = Get.put(ShowAddressController());
    // final wishListController = Get.put(WishlistController());
    // final brandController = Get.put(BrandController());
    // final popularProductController = Get.put(PopularProductController());
    // categoryController.fetchCategory();
    // productSectionController.fetchProductSection();
    //

    // profile.getPages();
    // authController.getCountryCode();
    // language.getLanguageData();
    //
    // if (box.read('isLogedIn') != false) {
    //   profile.getAddress();
    //   profile.getTotalOrdersCount();
    //   profile.getTotalCompleteOrdersCount();
    //   profile.getTotalReturnOrdersCount();
    //   profile.getTotalWalletBalance();
    //   showAddressController.showAdresses();
    // }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColor.primaryBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(48.h),
          child: AppBarWidget(
              svgIcon: SvgIcon.search,
              onTap: () {
                Get.to(() => const SearchScreen());
              }),
        ),
        body: GetX<HomeControllers>(
          init: HomeControllers(),
          builder: (controller) {
            if (controller.isLoading.value) {
              return const LoadingWidget();
            }
            return RefreshIndicator(
              color: AppColor.primaryColor,
              onRefresh: () async {
                homeControllers.homeBannerList(context: context);
                // productSectionController.fetchProductSection();
                // categoryController.fetchCategory();
                // brandController.fetchBrands();
                // // homeControllers.homeBannerList(context: context);
                // profile.getPages();
                // authController.getSetting();
                // authController.getCountryCode();
                // language.getLanguageData();
                // if (box.read('isLogedIn') != false) {
                //   profile.getAddress();
                //   profile.getTotalOrdersCount();
                //   profile.getTotalCompleteOrdersCount();
                //   profile.getTotalReturnOrdersCount();
                //   profile.getTotalWalletBalance();
                // }
              },
              child: Padding(
                padding: EdgeInsets.only(top: 16.h, left: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(right: 16.w),
                              child: controller.bannerList.isEmpty
                                  ? const SliderSectionShimmer()
                                  : controller.bannerList.isNotEmpty
                                      ? SliderWidget(bannerList: controller.bannerList)
                                      : const SizedBox()),
                          SizedBox(height: 24.h),
                          controller.homePageCategoryList.isNotEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(right: 16.w),
                                  child: TitleWidget(
                                    text: 'CATEGORIES'.tr,
                                  ),
                                )
                              : const SizedBox(),
                          controller.homePageCategoryList.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(top: 20.h),
                                  child: const CategoriesSectionShimmer(),
                                )
                              : controller.homePageCategoryList.isNotEmpty
                                  ? CategoryWidget(homePageCategory: controller.homePageCategoryList)
                                  : const SizedBox(),
                          PromotionBanner(promotionCategoryBannerList: controller.promotionCategoryBannerList)
                        ],
                      ),
                      SizedBox(height: 32.h),
                      SizedBox(
                        child: controller.homePageProductList.isEmpty
                            ? const ProductShimmer()
                            : controller.homePageProductList.isNotEmpty
                                ? Padding(
                                    padding: EdgeInsets.only(right: 16.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TitleWidget(text: "Latest Addition"),
                                        const SizedBox(height: 15),
                                        StaggeredGrid.count(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 15,
                                          crossAxisSpacing: 15,
                                          children: [
                                            for (var i = 0; i < controller.homePageProductList.length; i++)
                                              ProductWidget2(
                                                onTap: () async {
                                                 await Get.to(
                                                    () => ProductViewDetailsScreen(itemId: controller.homePageProductList[i].productId));
                                                  homeControllers.homeBannerList(context: context);

                                                },
                                                // favTap: () async {
                                                // if (box.read('isLogedIn') != false) {
                                                //   if (section[index].products![i].wishlist == true) {
                                                //     await wishListController.toggleFavoriteFalse(section[index].products![i].id!);
                                                //     wishListController.showFavorite(section[index].products![i].id!);
                                                //   }
                                                //   if (section[index].products![i].wishlist == false) {
                                                //     await wishListController.toggleFavoriteTrue(section[index].products![i].id!);
                                                //     wishListController.showFavorite(section[index].products![i].id!);
                                                //   }
                                                // } else {
                                                //   Get.to(() => const SignInScreen());
                                                // }
                                                // },
                                                // wishlist:
                                                // wishListController.favList.contains(section[index].products![i].id!) ||
                                                //         productSectionController
                                                //                 .productSection.value.data![index].products![i].wishlist ==
                                                //             true
                                                //     ? true
                                                //     :
                                                // false,
                                                productImage: controller.homePageProductList[i].image,
                                                title: controller.homePageProductList[i].brandName,
                                                titleDesc: controller.homePageProductList[i].name,
                                                  price:controller.homePageProductList[i].price,
                                                // rating: section[index].products![i].ratingStar,
                                                // currentPrice: section[index].products![i].currencyPrice,
                                                // discountPrice: section[index].products![i].discountedPrice,
                                                // textRating: section[index].products![i].ratingStarCount,
                                                // flashSale: section[index].products![i].flashSale!,
                                                // isOffer: section[index].products![i].isOffer!,
                                              )
                                          ]
                                        ),
                                        const SizedBox(height: 30),
                                        // MultiPromotionBanner(
                                        //   pIndex: index,
                                        // ),
                                      ]
                                    )
                                  )
                                : const SizedBox(),
                      ),
                      // Obx(
                      //   () => popularProductController.popularModel.value.data == null
                      //       ? const ProductShimmer()
                      //       : popularProductController.popularModel.value.data!.isNotEmpty
                      //           ? Padding(
                      //               padding: EdgeInsets.only(right: 16.w),
                      //               child: Column(
                      //                 children: [
                      //                   Padding(
                      //                     padding: EdgeInsets.only(right: 16.w),
                      //                     child: Row(
                      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                       children: [
                      //                         TitleWidget(text: "Most Popular".tr),
                      //                         SeeAllButton(
                      //                           onTap: () async {
                      //                             Get.to(
                      //                               () => const ProductlistScreen(
                      //                                 id: 5,
                      //                                 title: "Most Popular",
                      //                               ),
                      //                             );
                      //                           },
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                   SizedBox(height: 16.h),
                      //                   StaggeredGrid.count(
                      //                     crossAxisCount: 2,
                      //                     mainAxisSpacing: 16.h,
                      //                     crossAxisSpacing: 16.w,
                      //                     children: [
                      //                       for (int index = 0; index < popularProductController.popularModel.value.data!.length; index++)
                      //                         ProductWidget(
                      //                           onTap: () {
                      //                             Get.to(() => ProductDetailsScreen(
                      //                                 individualProduct: popularProductController.popularModel.value.data?[index]));
                      //                           },
                      //                           wishlist: wishListController.favList
                      //                                       .contains(popularProductController.popularModel.value.data![index].id!) ||
                      //                                   popularProductController.popularModel.value.data?[index].wishlist == true
                      //                               ? true
                      //                               : false,
                      //                           favTap: () async {
                      //                             if (box.read('isLogedIn') != false) {
                      //                               if (popularProductController.popularModel.value.data?[index].wishlist == true) {
                      //                                 await wishListController
                      //                                     .toggleFavoriteFalse(popularProductController.popularModel.value.data![index].id!);
                      //
                      //                                 wishListController.showFavorite(popularProductController.popularModel.value.data![index].id!);
                      //                               }
                      //                               if (popularProductController.popularModel.value.data?[index].wishlist == false) {
                      //                                 await wishListController
                      //                                     .toggleFavoriteTrue(popularProductController.popularModel.value.data![index].id!);
                      //
                      //                                 wishListController.showFavorite(popularProductController.popularModel.value.data![index].id!);
                      //                               }
                      //                             } else {
                      //                               Get.to(() => const SignInScreen());
                      //                             }
                      //                           },
                      //                           productImage: popularProductController.popularModel.value.data?[index].cover!,
                      //                           title: popularProductController.popularModel.value.data?[index].name,
                      //                           rating: popularProductController.popularModel.value.data?[index].ratingStar.toString(),
                      //                           currentPrice: popularProductController.popularModel.value.data?[index].currencyPrice,
                      //                           discountPrice: popularProductController.popularModel.value.data?[index].discountedPrice,
                      //                           textRating: popularProductController.popularModel.value.data?[index].ratingStarCount,
                      //                           flashSale: popularProductController.popularModel.value.data?[index].flashSale!,
                      //                           isOffer: popularProductController.popularModel.value.data?[index].isOffer!,
                      //                         ),
                      //                     ],
                      //                   ),
                      //                 ],
                      //               ),
                      //             )
                      //           : const SizedBox(),
                      // ),
                      // SizedBox(height: 34.h),
                      // Obx(
                      //   () => flashSaleController.flashSaleModel.value.data == null
                      //       ? const ProductShimmer()
                      //       : flashSaleController.flashSaleModel.value.data!.isNotEmpty
                      //           ? Padding(
                      //               padding: EdgeInsets.only(right: 16.w),
                      //               child: Obx(
                      //                 () => Column(
                      //                   children: [
                      //                     Padding(
                      //                       padding: EdgeInsets.only(right: 16.w),
                      //                       child: Row(
                      //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                         children: [
                      //                           TitleWidget(text: 'Flash Sale'.tr),
                      //                           SeeAllButton(
                      //                             onTap: () {
                      //                               Get.to(
                      //                                 () => const ProductlistScreen(
                      //                                   id: 10,
                      //                                   title: "Flash Sale",
                      //                                 ),
                      //                               );
                      //                             },
                      //                           ),
                      //                         ],
                      //                       ),
                      //                     ),
                      //                     SizedBox(height: 16.h),
                      //                     StaggeredGrid.count(
                      //                       crossAxisCount: 2,
                      //                       mainAxisSpacing: 16.h,
                      //                       crossAxisSpacing: 16.w,
                      //                       children: [
                      //                         for (int index = 0; index < flashSaleController.flashSaleModel.value.data!.length; index++)
                      //                           Obx(() {
                      //                             final flashSale = flashSaleController.flashSaleModel.value.data![index];
                      //
                      //                             return Obx(
                      //                               () => ProductWidget(
                      //                                 onTap: () {
                      //                                   Get.to(
                      //                                     () => ProductDetailsScreen(
                      //                                       individualProduct: flashSaleController.flashSaleModel.value.data?[index],
                      //                                     ),
                      //                                   );
                      //                                 },
                      //                                 wishlist: wishListController.favList.contains(flashSale.id!) || flashSale.wishlist == true
                      //                                     ? true
                      //                                     : false,
                      //                                 favTap: () async {
                      //                                   if (box.read('isLogedIn') != false) {
                      //                                     if (flashSale.wishlist == true) {
                      //                                       await wishListController.toggleFavoriteFalse(flashSale.id!);
                      //                                       wishListController.showFavorite(flashSale.id!);
                      //                                     }
                      //                                     if (flashSale.wishlist == false) {
                      //                                       await wishListController.toggleFavoriteTrue(flashSale.id!);
                      //
                      //                                       wishListController.showFavorite(flashSale.id!);
                      //                                     }
                      //                                   } else {
                      //                                     Get.to(() => const SignInScreen());
                      //                                   }
                      //                                 },
                      //                                 favColor:
                      //                                     wishListController.favList.contains(flashSale.id!) ? SvgIcon.filledHeart : SvgIcon.heart,
                      //                                 productImage: flashSale.cover!,
                      //                                 title: flashSale.name,
                      //                                 rating: flashSale.ratingStar.toString(),
                      //                                 currentPrice: flashSale.currencyPrice,
                      //                                 discountPrice: flashSale.discountedPrice,
                      //                                 textRating: flashSale.ratingStarCount,
                      //                                 flashSale: flashSale.flashSale!,
                      //                                 isOffer: flashSale.isOffer!,
                      //                               ),
                      //                             );
                      //                           }),
                      //                       ],
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             )
                      //           : const SizedBox(),
                      // ),
                      SizedBox(height: 20.h),
                      controller.manufacturerList.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleWidget(text: "Popular Brands".tr),
                                  SizedBox(height: 16.h),
                                  SizedBox(
                                    height: controller.manufacturerList.isEmpty? 0 : 150.h,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: controller.manufacturerList.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          borderRadius: BorderRadius.circular(16.r),
                                          onTap: () {
                                            // filterController.addHomeBrandId(brandController.brandModel.value.data![index].id.toString());

                                            // Get.to(() => CategoryWiseProductScreen(
                                            //       brandName: brandController.brandModel.value.data?[index].name,
                                            //     ));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                                            child:controller.manufacturerList.isEmpty
                                                  ? Shimmer.fromColors(
                                                      baseColor: Colors.grey[200]!,
                                                      highlightColor: Colors.grey[300]!,
                                                      child: Container(
                                                        height: 90.h,
                                                        width: 100.w,
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: Colors.white),
                                                      ),
                                                    )
                                                  : Ink(
                                                      height: 140,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(color: AppColor.borderColor),
                                                        borderRadius: BorderRadius.circular(16.r),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(8.sp),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          children: [
                                                            CachedNetworkImage(
                                                                imageUrl: controller.manufacturerList[index].image.toString(),
                                                                fit: BoxFit.fill,
                                                                imageBuilder: (context, imageProvider) => Container(
                                                                      height: 100.h,
                                                                      width: 140.w,
                                                                      decoration: BoxDecoration(
                                                                        image: DecorationImage(image: imageProvider),
                                                                      ),
                                                                    )),
                                                            const SizedBox(height: 15),
                                                            CustomText(
                                                              text: controller.manufacturerList[index].name,
                                                              color: AppColor.textColor,
                                                              weight: FontWeight.w600,
                                                              size: 12.sp,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: controller.manufacturerList.isEmpty ? 0 : 100.h,
                                  )
                                ],
                              )
                            : const SizedBox(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
