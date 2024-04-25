// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/apiServices/common_widget.dart';
import 'package:shopperz/app/modules/category/views/category_screen.dart';
import 'package:shopperz/app/modules/home/controller/promotion_controller.dart';
import 'package:shopperz/model/home_banner_model.dart';
import 'package:shopperz/widgets/shimmer/promotion_banner_shimmer.dart';

class PromotionBanner extends StatefulWidget {
  const PromotionBanner({
    super.key,
    // this.image,
    // this.width,
    // this.pIndex,
    required this.promotionCategoryBannerList,
  });
 final List<CategoryBanner> promotionCategoryBannerList;

  @override
  State<PromotionBanner> createState() => _PromotionBannerState();
}

class _PromotionBannerState extends State<PromotionBanner> {
  // final String? image;
  @override
  Widget build(BuildContext context) {
    // final promotionController = Get.put(PromotionalController());

    return
        // promotionController.isLoading.value
        //   ? Padding(
        //       padding: EdgeInsets.only(top: 24.h),
        //       child: SizedBox(
        //           height: 142.h,
        //           child: PromotionBannerShimmer(
        //             width: 280.w,
        //           )),
        //     )
        //   :
        widget.promotionCategoryBannerList.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: SizedBox(
                    height: 160,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal, // Set scroll direction to vertical
                      itemCount:
                          widget.promotionCategoryBannerList.length,
                      itemBuilder: (context, index) {
                        // final promotion =
                        //     promotionController.promotionModel.value.data;
                        return Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: InkWell(
                            onTap: ()  {
                               Get.to(() => CategoryScreen(
                                  categoryId: widget.promotionCategoryBannerList[index].nopCategoryId,
                                  categoryName:  widget.promotionCategoryBannerList[index].categoryName));
                              },
                            child: Container(
                              width:
                                  // promotion![index].status == 10 ?
                                  // 280.w :
                                  250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child:
                                cachedNetWorkImageForCircle(widget.promotionCategoryBannerList[index].categoryBanner,5)
                                // Image.network(
                                //   widget.promotionCategoryBannerList[index].categoryBanner,
                                //   fit: BoxFit.fill,
                                // ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : const SizedBox();
  }
}
