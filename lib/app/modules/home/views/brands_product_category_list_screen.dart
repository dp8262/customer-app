import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/apiServices/common_widget.dart';
import 'package:shopperz/app/controller/home_controller.dart';
import 'package:shopperz/app/modules/category/views/product_view_details_screen.dart';
import 'package:shopperz/app/modules/category/views/sqlite_helper.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/utils/images.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/appbar3.dart';
import 'package:shopperz/widgets/textwidget.dart';

class BrandsProductCategoryListScreen extends StatefulWidget {
  final String productBrandId;
  final String productBrandName;

  const BrandsProductCategoryListScreen({super.key, required this.productBrandId, required this.productBrandName});

  @override
  State<BrandsProductCategoryListScreen> createState() => _BrandsProductCategoryListScreenState();
}

class _BrandsProductCategoryListScreenState extends State<BrandsProductCategoryListScreen> {
  final HomeControllers homeControllers = Get.put(HomeControllers());
  String selectedFilter = "Name A to Z";
  final List<String> filterList = ["Name A to Z", "Name Z to A", "Created on"];

  // late RxList<Product> productList;
  ContactDatabaseHelper contactDatabaseHelper = ContactDatabaseHelper();
  @override
  void initState() {
    // homeControllers.brandsManufacturerList(context: context, productBrandId: widget.productBrandId);
    myInit();
    super.initState();
  }

  myInit() async {
    await contactDatabaseHelper.initializeDatabase();
    print(widget.productBrandId);
    homeControllers.brandsManufacturerList(context: context, productBrandId: widget.productBrandId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(48.h), child: AppBarWidget3(text: widget.productBrandName)),
        body:
            // Obx(() {
            GetX<HomeControllers>(
                init: HomeControllers(),
                builder: (controller) {
                  if (controller.isLoading.value) {
                    return const LoadingWidget();
                  } else if (controller.brandProductList.isEmpty) {
                    return const Center(child: Text('No data available'));
                  } else {
                    return SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Expanded(child: SizedBox()),
                                const Text("Filter", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColor.primaryColor)),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Container(
                                    height: 38,
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColor.greyColor)),
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
                                            controller.brandProductList.clear();
                                            controller.filterBrandsProductListDetails(
                                                context: context, productBrandId: widget.productBrandId, sortBy: selectedFilter);
                                          });
                                        },
                                        items: filterList.map((String dateList) {
                                          return DropdownMenuItem(value: dateList, child: Text(dateList, textAlign: TextAlign.start, maxLines: 2));
                                        }).toList()),
                                  ),
                                ),
                              ],
                            ),
                            ListView.builder(
                                itemCount: controller.brandProductList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  // if (selectedFilter==controller.productList) {
                                  return InkWell(
                                    onTap: () async {
                                      // await contactDatabaseHelper.insertRecentProduct(controller.brandProductList[index]);
                                      //
                                      //
                                      Get.delete<HomeControllers>();
                                      await Get.to(
                                            () => ProductViewDetailsScreen(itemId: controller.brandProductList[index].productId,
                                          // product: categoryControllers.productList[index].i,
                                        ),
                                      );
                                      // // print("product id${categoryControllers.productList[index].productId}");
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.borderColor, width: 1.sp))),
                                        child: Center(
                                            child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                          Expanded(
                                              flex: 8,
                                              child: Row(children: [
                                                CachedNetworkImage(
                                                    width: 100,
                                                    imageUrl: controller.brandProductList[index].image,
                                                    errorWidget: (context, url, error) => Image.asset(AppImages.errorImages, fit: BoxFit.cover),
                                                    imageBuilder: (context, imageProvider) => Container(
                                                        height: 100,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
                                                            image: DecorationImage(
                                                              image: imageProvider,
                                                              fit: BoxFit.cover,
                                                            )))),
                                                const SizedBox(width: 15),
                                                Expanded(
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                          TextWidget(
                                                              text: controller.brandProductList[index].manufacturerName.toString(),
                                                              color: AppColor.textColor,
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w600),
                                                          const SizedBox(height: 10),
                                                          TextWidget(
                                                              text: controller.brandProductList[index].name.toString(),
                                                              color: AppColor.textColor,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500)
                                                        ])))
                                              ])),
                                          Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                  onTap: () {},
                                                  child: SvgPicture.asset(SvgIcon.forward.isNotEmpty ? SvgIcon.forward : 'assets/placeholder.svg')))
                                        ]))),
                                  );
                                  // } else {
                                  //   return const SizedBox();
                                  // }
                                }),
                          ],
                        ));
                  }
                }));
  }
}
