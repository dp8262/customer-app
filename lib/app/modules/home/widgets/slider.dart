import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/controller/home_controller.dart';
import 'package:shopperz/model/home_banner_model.dart';

import '../../../../config/theme/app_color.dart';
import '../controller/slider_controller.dart';

class SliderWidget extends StatefulWidget {
 final List<BannerList> bannerList;
  const SliderWidget({super.key, required this.bannerList});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  int dotIndex = 0;

  @override
  Widget build(BuildContext context) {
    // final homeControllers = Get.find<HomeControllers>();

    return Container(
      height: 142.h,
      width: 328.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider.builder(
              itemCount:widget.bannerList.length,
              itemBuilder: (context, index, _) {
                // final data = homeControllers.bannerList;
                return CachedNetworkImage(
                  imageUrl: widget.bannerList[index].image.toString(),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 142.h,
                viewportFraction: 1,
                autoPlay: true,
                enlargeCenterPage: true,
                disableCenter: true,
                onPageChanged: (int index, _) {
                  setState(() {
                    dotIndex = index;
                  });
                  },
              ),
            ),
          Positioned(
            bottom: 10,
            child: DotsIndicator(
                dotsCount: widget.bannerList.length,
                position: dotIndex,
                decorator: DotsDecorator(
                  spacing: EdgeInsets.only(left: 5.w),
                  shape: const CircleBorder(
                      side: BorderSide(color: AppColor.primaryColor),
                      eccentricity: 0.8),
                  color: Colors.transparent,
                  activeColor: AppColor.primaryColor,
                ),
              ),
          )
        ],
      ),
    );
  }
}
