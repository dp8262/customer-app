import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/apiServices/common_widget.dart';
import 'package:shopperz/app/controller/category_controller.dart';
import 'package:shopperz/app/modules/category/views/product_category_list_screen.dart';
import 'package:shopperz/app/modules/home/widgets/appbar.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/appbar3.dart';
import 'package:shopperz/widgets/textwidget.dart';

// class CategoryScreen extends StatelessWidget {
//   const CategoryScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final categoryTreeController = Get.put(CategoryTreeController());
//
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: const SystemUiOverlayStyle(
//         systemNavigationBarColor: Colors.white,
//         systemNavigationBarIconBrightness: Brightness.dark,
//         statusBarIconBrightness: Brightness.dark,
//         statusBarColor: Colors.transparent,
//         statusBarBrightness: Brightness.dark,
//       ),
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(48.h),
//           child: const AppBarWidget(),
//         ),
//         body: Obx(
//           () => Stack(
//             alignment: Alignment.center,
//             children: [
//               SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
//                   child: Obx(() {
//                     return categoryTreeController.categoryTreeList.isEmpty
//                         ? SizedBox()
//                         : categoryTreeController.categoryTreeList.length < 1
//                             ? Center(
//                                 child: Padding(
//                                 padding: EdgeInsets.only(top: 120.h),
//                                 child: Center(
//                                   child: Image.asset(
//                                     AppImages.emptyIcon,
//                                     height: 300.h,
//                                     width: 300.w,
//                                   ),
//                                 ),
//                               ))
//                             : ListView.builder(
//                                 itemCount: categoryTreeController
//                                     .categoryTreeList.length,
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemBuilder: (context, index) {
//                                   final categoryTree =
//                                       categoryTreeController.categoryTreeList;
//                                   return CategoryList(
//                                     text: categoryTree[index].name.toString(),
//                                     onTapProduct: () {
//                                       Get.to(() => CategoryWiseProductScreen(
//                                           categoryTreeModel:
//                                               categoryTree[index]));
//                                     },
//                                     onTapSubCategory: () {
//                                       Get.to(() => SubCategoryScreen(
//                                           categoryTreeModel:
//                                               categoryTree[index]));
//                                     },
//                                   );
//                                 },
//                               );
//                   }),
//                 ),
//               ),
//               categoryTreeController.isLoading.value
//                   ? const Center(child: LoaderCircle())
//                   : SizedBox()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
class CategoryScreen extends StatefulWidget {
  final String categoryId;
  final String? categoryName;

  const CategoryScreen({
    super.key,
    required this.categoryId,
    this.categoryName,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryControllers categoryControllers = Get.put(CategoryControllers());

  @override
  void initState() {
    // if (widget.categoryId != null && widget.categoryId!.isNotEmpty){
    // //   for (int i = 0; i < categoryControllers.categoryList.length; i++) {
    // //   if (categoryControllers.categoryList[i].parentId == "0") {
    //     categoryControllers.categoryListDetails(
    //       context: context );}
    //   // }
    // // }}
    // for (int i = 0; i < categoryControllers.categoryList.length; i++) {
    super.initState();

    // if (categories.isEmpty) {
    categoryControllers.categoryListDetails(
      context: context,
      // categoryId: widget.categoryId
    );
    // }
  }

  @override
  Widget build(BuildContext context) {
    // final categoryTreeController = Get.put(CategoryTreeController());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(48.h),
            child: widget.categoryId == "0" ? const AppBarWidget() : AppBarWidget3(text: widget.categoryName),
          ),
          body:
              // Obx(() {
              GetX<CategoryControllers>(
                  init: CategoryControllers(),
                  builder: (controller) {
                    if (categoryControllers.isLoading.value) {
                      return const LoadingWidget();
                    } else if (categoryControllers.categoryList.isEmpty) {
                      // If no data is available, display a message
                      return const Center(
                        child: Text('No data available'),
                      );
                    } else {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: ListView.builder(
                            itemCount: categoryControllers.categoryList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (categoryControllers.categoryList[index].parentId == widget.categoryId) {
                                // print("${controller.categoryList[index].parentId}a======");
                                // print("${widget.categoryId}b======");
                                return InkWell(
                                  onTap: () {
                                    // Get.delete<CategoryControllers>();
                                    if (categoryControllers.categoryList[index].products == "0"
// &&                         controller.categoryList[index].catgoryId==   widget.categoryId
                                        ) {
                                      print("category++${categoryControllers.categoryList[index].parentId}");
                                      print("category--${widget.categoryId}");
                                      Get.delete<CategoryControllers>();
                                      print("category${categoryControllers.categoryList[index].catgoryId}");
                                      print("parentId${categoryControllers.categoryList[index].parentId}");
                                      Get.to(() => RedirectCategoryScreen(
                                          categoryId: categoryControllers.categoryList[index].catgoryId,
                                          categoryName: categoryControllers.categoryList[index].name));
                                      // print("secound screen");
                                    } else {
                                      Get.delete<CategoryControllers>();
                                      Get.to(() => ProductCategoryListScreen(
                                          categoryName: categoryControllers.categoryList[index].name,
                                          categoryId: categoryControllers.categoryList[index].catgoryId));
                                    }
                                    print("category${categoryControllers.categoryList[index].catgoryId}");
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
                                                  imageUrl: categoryControllers.categoryList[index].image,
                                                  imageBuilder: (context, imageProvider) => Container(
                                                      height: 80,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          image: DecorationImage(image: imageProvider, fit: BoxFit.cover)))),
                                              const SizedBox(width: 15),
                                              Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: TextWidget(
                                                      text: categoryControllers.categoryList[index].name.toString(),
                                                      color: AppColor.textColor,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600))
                                            ])),
                                        Expanded(
                                            flex: 1,
                                            child: InkWell(
                                                onTap: () {},
                                                child: SvgPicture.asset(
                                                  SvgIcon.forward.isNotEmpty ? SvgIcon.forward : 'assets/placeholder.svg',
                                                )))
                                      ]))),
                                );
                              } else {
                                return const SizedBox();
                              }
                            }),
                        //latest code
//                     StaggeredGrid.count(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10, children: [
//                   for (var i = 0; i < categoryControllers.categoryList.length; i++)
//                     if (categoryControllers.categoryList[i].parentId == widget.categoryId)
//                       GestureDetector(
//                           onTap: () {
//                             // Get.delete<CategoryControllers>();
//                             if (categoryControllers.categoryList[i].products == "0"
// // &&                         controller.categoryList[index].catgoryId==   widget.categoryId
//                                 ) {
//                               print("category++${categoryControllers.categoryList[i].parentId}");
//                               print("category--${widget.categoryId}");
//                               Get.delete<CategoryControllers>();
//                               print("category${categoryControllers.categoryList[i].catgoryId}");
//                               print("parentId${categoryControllers.categoryList[i].parentId}");
//                               Get.to(() => CategoryScreen2(
//                                   categoryId: categoryControllers.categoryList[i].catgoryId, categoryName: categoryControllers.categoryList[i].name));
//                               print("secound screen");
//                               //   //   // Navigator.of(context).pushNamed('/categories', arguments: {'id': controller.categoryList[index].categoryId});
//                               // } else {
//                               //   await Get.to(() => SubCategoryListScreen(subCategory: controller.categoryList[index]));
//                             }
//                           },
//                           child: Container(
//                               height: 150,
//                               decoration: BoxDecoration(color: AppColor.whiteColor, borderRadius: BorderRadius.circular(10), boxShadow: [
//                                 BoxShadow(color: Colors.black.withOpacity(0.05), offset: const Offset(0, 0), blurRadius: 7, spreadRadius: 0)
//                               ]),
//                               child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                                   child: Column(
//                                       // mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         CachedNetworkImage(
//                                             imageUrl: categoryControllers.categoryList[i].image,
//                                             imageBuilder: (context, imageProvider) => Container(
//                                                 height: 110,
//                                                 // width: 130,
//                                                 decoration: BoxDecoration(
//                                                     color: AppColor.whiteColor,
//                                                     borderRadius: BorderRadius.circular(5),
//                                                     image: DecorationImage(image: imageProvider, fit: BoxFit.fill)))),
//                                         const SizedBox(height: 5),
//                                         SizedBox(
//                                           height: 30,
//                                           child: TextWidget(
//                                               text: categoryControllers.categoryList[i].name.toString(),
//                                               color: AppColor.textColor,
//                                               textAlign: TextAlign.center,
//                                               fontSize: 13,
//                                               fontWeight: FontWeight.w500,
//                                               maxLines: 2,
//                                               overflow: TextOverflow.ellipsis),
//                                         )
//                                       ]))))
//                 ]),

//old code
//                       GridView.builder(
//                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             mainAxisSpacing: 16,
//                             crossAxisSpacing: 16
//                           ),
//                           itemCount: categoryControllers.categoryList.length,
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             if (categoryControllers.categoryList[index].parentId == widget.categoryId) {
//                               return GestureDetector(
//                                 onTap: () {
//                                   // Get.delete<CategoryControllers>();
//                                   if (categoryControllers.categoryList[index].products == "0"
// // &&                         controller.categoryList[index].catgoryId==   widget.categoryId
//                                       ) {
//                                     print("category++${categoryControllers.categoryList[index].parentId}");
//                                     print("category--${widget.categoryId}");
//                                     Get.delete<CategoryControllers>();
//                                     print("category${categoryControllers.categoryList[index].catgoryId}");
//                                     print("parentId${categoryControllers.categoryList[index].parentId}");
//                               Get.to(() => CategoryScreen2(categoryId: categoryControllers.categoryList[index].catgoryId, categoryName: categoryControllers.categoryList[index].name));
//                                     print("secound screen");
//                                     //   //   // Navigator.of(context).pushNamed('/categories', arguments: {'id': controller.categoryList[index].categoryId});
//                                     // } else {
//                                     //   await Get.to(() => SubCategoryListScreen(subCategory: controller.categoryList[index]));
//                                   }
//                                 },
//                                 child: Container(
//                                   width: 155,
//                                   decoration: BoxDecoration(
//                                     color: AppColor.whiteColor,
//                                     borderRadius: BorderRadius.circular(12),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withOpacity(0.05),
//                                         offset: const Offset(0, 0),
//                                         blurRadius: 7,
//                                         spreadRadius: 0,
//                                       )
//                                     ],
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         CachedNetworkImage(
//                                             imageUrl:categoryControllers.categoryList[index].image,
//                                             imageBuilder: (context, imageProvider) => Container(
//                                                 height: 130,
//                                                 width: 130,
//                                                 decoration: BoxDecoration(
//                                                     color: AppColor.whiteColor,
//                                                     borderRadius: BorderRadius.circular(8),
//                                                     image: DecorationImage(image: imageProvider, fit: BoxFit.fill)))),
//                                         const SizedBox(height: 10),
//                                         TextWidget(
//                                           text:  categoryControllers.categoryList[index].name.toString(),
//                                           color: AppColor.textColor,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                           maxLines: 2,
//                                           overflow: TextOverflow.fade,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             } else {
//                               return const SizedBox();
//                             }
//                           })
                      );
                    }
                    // })
                  })),
    );
  }
}

class RedirectCategoryScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const RedirectCategoryScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<RedirectCategoryScreen> createState() => _RedirectCategoryScreenState();
}

class _RedirectCategoryScreenState extends State<RedirectCategoryScreen> {
  final CategoryControllers categoryControllers = Get.put(CategoryControllers()); // Retrieve existing instance
  String myCategoryName = "";
  var categories = [];
  var categoryId = 0;

  @override
  void initState() {
    super.initState();

    categoryControllers.categoryListDetails(
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(48.h),
            child: widget.categoryId == "0" ? const AppBarWidget() : AppBarWidget3(text: widget.categoryName),
          ),
          body:
              // Obx(() {
              GetX<CategoryControllers>(
                  init: CategoryControllers(),
                  builder: (controller) {
                    if (categoryControllers.isLoading.value) {
                      return const LoadingWidget();
                    } else if (categoryControllers.categoryList.isEmpty) {
                      // If no data is available, display a message
                      return const Center(
                        child: Text('No data available'),
                      );
                    } else {
                      return SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child:
                              // widget.categoryId.isNotEmpty
                              //     ? GridView.builder(
                              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              //     crossAxisCount: 2,
                              //     mainAxisSpacing: 16,
                              //     crossAxisSpacing: 16,
                              //   ),
                              //   itemCount: 5,
                              //   shrinkWrap: true,
                              //   physics: const NeverScrollableScrollPhysics(),
                              //   itemBuilder: (context, i) {
                              //     return GestureDetector(
                              //       onTap: () {},
                              //       child: Container(
                              //         width: 155,
                              //         decoration: BoxDecoration(
                              //           color: AppColor.whiteColor,
                              //           borderRadius: BorderRadius.circular(12),
                              //           boxShadow: [
                              //             BoxShadow(
                              //               color: Colors.black.withOpacity(0.05),
                              //               offset: const Offset(0, 0),
                              //               blurRadius: 7,
                              //               spreadRadius: 0,
                              //             )
                              //           ],
                              //         ),
                              //         child: Padding(
                              //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              //           child: Column(
                              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //             crossAxisAlignment: CrossAxisAlignment.start,
                              //             children: [
                              //               // Add your grid item content here
                              //               TextWidget(
                              //                 text: "dev",
                              //                 color: AppColor.textColor,
                              //                 fontSize: 16,
                              //                 fontWeight: FontWeight.w600,
                              //                 maxLines: 2,
                              //                 overflow: TextOverflow.fade,
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // ) :
                              ListView.builder(
                                  itemCount: categoryControllers.categoryList.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    if (categoryControllers.categoryList[index].parentId == widget.categoryId) {
                                      // print("${controller.categoryList[index].parentId}a======");
                                      // print("${widget.categoryId}b======");
                                      return InkWell(
                                        onTap: () async {
                                          // Get.delete<CategoryControllers>();
                                          if (categoryControllers.categoryList[index].products == "0") {
                                            // print("category++${categoryControllers.categoryList[index].parentId}");
                                            // print("category--${widget.categoryId}");
                                            Get.delete<CategoryControllers>();
                                            // print("category${categoryControllers.categoryList[index].catgoryId}");
                                            // print("parentId${categoryControllers.categoryList[index].parentId}");
                                            await Get.to(() => CategoryScreen(
                                                categoryId: categoryControllers.categoryList[index].catgoryId,
                                                categoryName: categoryControllers.categoryList[index].name));
                                            print("First screen");
                                          } else {
                                            Get.delete<CategoryControllers>();
                                            Get.to(() => ProductCategoryListScreen(
                                                categoryName: categoryControllers.categoryList[index].name,
                                                categoryId: categoryControllers.categoryList[index].catgoryId));
                                          }
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
                                                        imageUrl: categoryControllers.categoryList[index].image,
                                                        imageBuilder: (context, imageProvider) => Container(
                                                            height: 80,
                                                            width: 80,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(5),
                                                                image: DecorationImage(image: imageProvider, fit: BoxFit.cover)))),
                                                    const SizedBox(width: 15),
                                                    Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: TextWidget(
                                                            text: categoryControllers.categoryList[index].name.toString(),
                                                            color: AppColor.textColor,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600))
                                                  ])),
                                              Expanded(
                                                  flex: 1,
                                                  child: InkWell(
                                                      onTap: () {},
                                                      child: SvgPicture.asset(
                                                        SvgIcon.forward.isNotEmpty ? SvgIcon.forward : 'assets/placeholder.svg',
                                                      )))
                                            ]))),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  }));
                    }
                    // })
                  })),
    );
  }
}
