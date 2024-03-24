import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/apiServices/common_widget.dart';
import 'package:shopperz/config/theme/app_color.dart';

extension AlertDialogCard on Widget {
  Widget alertCard(context) => GestureDetector(
    onTap: (){
      Get.back();
    },
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
      child: AlertDialog(
        backgroundColor: AppColor.primaryColor,
        alignment: Alignment.center,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        actions: [SizedBox(width: getScreenWidth(context), child: this)],
      ),
    ),
  );
}