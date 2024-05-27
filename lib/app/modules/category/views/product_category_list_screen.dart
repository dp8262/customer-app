import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/apiServices/common_widget.dart';
import 'package:shopperz/app/controller/category_controller.dart';
import 'package:shopperz/app/modules/category/views/product_view_details_screen.dart';
import 'package:shopperz/app/modules/category/views/sqlite_helper.dart';
import 'package:shopperz/app/modules/home/widgets/appbar.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/utils/images.dart';
import 'package:shopperz/widgets/appbar3.dart';
import 'package:shopperz/widgets/textwidget.dart';

class ProductCategoryListScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const ProductCategoryListScreen({super.key, required this.categoryId, required this.categoryName});

  @override
  State<ProductCategoryListScreen> createState() => _ProductCategoryListScreenState();
}

class _ProductCategoryListScreenState extends State<ProductCategoryListScreen> {
  final CategoryControllers categoryControllers = Get.put(CategoryControllers());
  String selectedFilter = "Name A to Z";
  final List<String> filterList = ["Name A to Z", "Name Z to A", "Created on"];

  // late RxList<Product> productList;
  ContactDatabaseHelper contactDatabaseHelper = ContactDatabaseHelper();

  @override
  void initState() {
    myInit();
    super.initState();
  }

  myInit() async {
    await contactDatabaseHelper.initializeDatabase();
    categoryControllers.productListDetails(context: context, categoryId: widget.categoryId);
  }

  // void loadProduct(String sortBy) async {
  //   await categoryControllers.productListDetails(context: context, categoryId: widget.categoryId, sortBy: sortBy);
  //
  // }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark),
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(48.h),
                child: widget.categoryId == "0" ? const AppBarWidget() : AppBarWidget3(text: widget.categoryName)),
            body:
                // Obx(() {
                GetX<CategoryControllers>(
                    init: CategoryControllers(),
                    builder: (controller) {
                      if (categoryControllers.isLoading.value) {
                        return const LoadingWidget();
                      } else if (categoryControllers.productList.isEmpty) {
                        return const Center(child: Text('No data available'));
                      } else {
                        return SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                  const Expanded(child: SizedBox()),
                                  const Text("Filter", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColor.primaryColor)),
                                  const SizedBox(width: 15),
                                  Expanded(
                                      child: Container(
                                          height: 38,
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          decoration:
                                              BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColor.greyColor)),
                                          child: DropdownButton(
                                              value: selectedFilter,
                                              padding: EdgeInsets.zero,
                                              icon: const Icon(Icons.arrow_drop_down, color: AppColor.deSelectedColor),
                                              style: const TextStyle(color: AppColor.deSelectedColor, fontSize: 16, fontWeight: FontWeight.w500),
                                              underline: Container(color: Colors.white),
                                              isExpanded: true,
                                              onChanged: (dynamic newValue) {
                                                setState(() {
                                                  selectedFilter = newValue!;
                                                  print("abc234 $selectedFilter");
                                                  categoryControllers.productList.clear();
                                                  categoryControllers.filterProductListDetails(
                                                      context: context, categoryId: widget.categoryId, sortBy: selectedFilter);
                                                });
                                              },
                                              items: filterList.map((String dateList) {
                                                return DropdownMenuItem(
                                                    value: dateList, child: Text(dateList, textAlign: TextAlign.start, maxLines: 2));
                                              }).toList())))
                                ]),
                                const SizedBox(height: 15),
                                // ListView.builder(
                                //     itemCount: categoryControllers.productList.length,
                                //     shrinkWrap: true,
                                //     physics: const NeverScrollableScrollPhysics(),
                                //     itemBuilder: (context, index) {
                                //       // if (selectedFilter==controller.productList) {
                                //         return InkWell(
                                //           onTap: ()  async{
                                //           await contactDatabaseHelper.insertRecentProduct(categoryControllers.productList[index]);
                                //
                                //
                                //           Get.delete<CategoryControllers>();
                                //           await Get.to(
                                //                 () => ProductViewDetailsScreen(itemId: categoryControllers.productList[index].productId,
                                //               // product: categoryControllers.productList[index].i,
                                //             ),
                                //           );
                                //           // print("product id${categoryControllers.productList[index].productId}");
                                //         },
                                //         child: Container(
                                //               padding: const EdgeInsets.symmetric(vertical: 5),
                                //               decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.borderColor, width: 1.sp))),
                                //               child: Center(
                                //                   child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                //                 Expanded(
                                //                     flex: 8,
                                //                     child: Row(children: [
                                //                       CachedNetworkImage(
                                //                         width: 100,
                                //                           imageUrl: categoryControllers.productList[index].image,
                                //                           errorWidget: (context, url, error) =>
                                //                               Image.asset(AppImages.errorImages, fit: BoxFit.cover),
                                //                           imageBuilder: (context, imageProvider) => Container(
                                //                               height: 100,
                                //                               width: 100,
                                //                               decoration: BoxDecoration(
                                //                                   borderRadius: BorderRadius.circular(5),
                                //                                   image: DecorationImage(image: imageProvider, fit: BoxFit.cover,)))),
                                //                       const SizedBox(width: 15),
                                //                       Expanded(
                                //                           child: Align(
                                //                               alignment: Alignment.centerLeft,
                                //                               child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                //                                 TextWidget(
                                //                                     text: categoryControllers.productList[index].brandName.toString(),
                                //                                     color: AppColor.textColor,
                                //                                     fontSize: 16,
                                //                                     fontWeight: FontWeight.w600),
                                //                                 const SizedBox(height: 10),
                                //                                 TextWidget(
                                //                                     text: categoryControllers.productList[index].name.toString(),
                                //                                     color: AppColor.textColor,
                                //                                     fontSize: 14,
                                //                                     fontWeight: FontWeight.w500)
                                //                               ])))
                                //                     ])),
                                //                 Expanded(
                                //                     flex: 1,
                                //                     child: InkWell(
                                //                         onTap: () {},
                                //                         child: SvgPicture.asset(
                                //                             SvgIcon.forward.isNotEmpty ? SvgIcon.forward : 'assets/placeholder.svg')))
                                //               ]))),
                                //         );
                                //       // } else {
                                //       //   return const SizedBox();
                                //       // }
                                //     }),
                                GridView.builder(
                                    itemCount: categoryControllers.productList.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15, childAspectRatio: 2 / 2.6),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () async {
                                            await contactDatabaseHelper.insertRecentProduct(categoryControllers.productList[index]);
                                            Get.delete<CategoryControllers>();
                                            await Get.to(() => ProductViewDetailsScreen(
                                                  itemId: categoryControllers.productList[index].productId,
                                                ));
                                          },
                                          child: Container(
                                              // height: 190,
                                              decoration: BoxDecoration(
                                                  color: AppColor.whiteColor,
                                                  borderRadius: BorderRadius.circular(5),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black.withOpacity(0.05),
                                                        offset: const Offset(0, 0),
                                                        blurRadius: 7,
                                                        spreadRadius: 0)
                                                  ]),
                                              child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                    CachedNetworkImage(
                                                        imageUrl: categoryControllers.productList[index].image,
                                                        errorWidget: (context, url, error) => Image.asset(AppImages.errorImages, fit: BoxFit.cover),
                                                        placeholder: (context, url) => const LoadingWidget(),
                                                        imageBuilder: (context, imageProvider) => Container(
                                                            height: 140,
                                                            decoration: BoxDecoration(
                                                                color: AppColor.whiteColor,
                                                                borderRadius: BorderRadius.circular(5),
                                                                image: DecorationImage(image: imageProvider, fit: BoxFit.fill)))),
                                                    const SizedBox(height: 10),
                                                    TextWidget(
                                                        text: categoryControllers.productList[index].brandName.toString(),
                                                        color: AppColor.textColor,
                                                        textAlign: TextAlign.center,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis),
                                                    const SizedBox(height: 7),
                                                    TextWidget(
                                                        text: categoryControllers.productList[index].name.toString(),
                                                        color: AppColor.textColor,
                                                        textAlign: TextAlign.center,
                                                        maxLines: 3,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500)
                                                  ]))));
                                    })
                              ],
                            ));
                      }
                    })));
  }
}
