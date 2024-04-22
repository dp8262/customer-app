import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/category/views/category_screen.dart';
import 'package:shopperz/model/home_banner_model.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';

class CategoryWidget extends StatefulWidget {
  final List<HomePageCategory> homePageCategory;

  const CategoryWidget({super.key, required this.homePageCategory});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    // final categoryController = Get.find<CategoryController>();

    return Container(
        height: 150,
        width: double.infinity,
        color: AppColor.whiteColor, // white hobe
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: widget.homePageCategory.length,
          itemBuilder: (context, index) {
            // final category = categoryController.categoryModel.value.data!;
            return Center(
                child: Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: InkWell(
                        onTap: () {
                          Get.to(() => CategoryScreen(
                              categoryId: widget.homePageCategory[index].categoryId,
                              categoryName: widget.homePageCategory[index].name));
                        },
                        child: Container(
                            height: 130,
                            width: 100,
                            decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(0.04), offset: const Offset(0, 0), blurRadius: 32.r, spreadRadius: 0)
                              ],
                            ),
                            child: Column(children: [
                              CachedNetworkImage(
                                  imageUrl: widget.homePageCategory[index].image,
                                  imageBuilder: (context, imageProvider) => Container(
                                      height: 85,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r), topRight: Radius.circular(8.r)),
                                          image: DecorationImage(image: imageProvider, fit: BoxFit.cover)))),
                              Expanded(
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          color: AppColor.whiteColor,
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
                                      child: Center(
                                          child: TextWidget(
                                              text: widget.homePageCategory[index].name,
                                              textAlign: TextAlign.center,
                                              color: AppColor.titleTextColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600))))
                            ])))));
          },
        ));
  }
}
