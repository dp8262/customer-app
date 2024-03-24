import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopperz/app/apiServices/common_method.dart';
import 'package:shopperz/app/apiServices/common_widget.dart';
import 'package:shopperz/app/apiServices/network_call.dart';
import 'package:shopperz/model/signIn_model.dart';
import 'package:shopperz/app/modules/navbar/controller/navbar_controller.dart';
import 'package:shopperz/app/modules/navbar/views/navbar_view.dart';
import 'package:shopperz/utils/api_list.dart';

class LoginControllers extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  RxString error = "".obs;
  RxList<Customer> customerList = <Customer>[].obs;

  login({required String email, required String password, required String deviceType, String? deviceID, required BuildContext context}) async {
    isLoading(true);
    isError(false);
    error("");
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = await FirebaseMessaging.instance.getToken();
      deviceID = token.toString();
      print(deviceID);
      getAPI(
          methodName: ApiList.login,
          param: {
            "emailId": email,
            "password": password,
            "DeviceID": deviceID,
            "DeviceType": deviceType,
          },
          callback: (value) {
            try {
              Map<String, dynamic> valueMap = json.decode(value.response);
              print("Response Map: $valueMap");
              if (valueMap.containsKey("customer") && valueMap["customer"] != null) {
                SignInModel signInModel = SignInModel.fromJson(valueMap);
                String userDataString = jsonEncode(signInModel.customer);
                prefs.setString(SharedPrefrenceData.customerData, userDataString);
                setUserData(signInModel.customer);
                isLoading(false);
                // print(AppConstants.userName);
                final navController = Get.put(NavbarController());
                Get.to(() => const NavBarView());
                navController.selectPage(0);
              } else if (valueMap.containsKey("msg") && valueMap["msg"] != null) {
                // String errorMsg = valueMap["msg"];
                if (valueMap["msg"] == "InvalidUser") {
                  toast("Invalid User...!",);
                } else if (valueMap["msg"] == "ActiveFalse") {
                  toast("Your account is not activated...!");
                } else if (valueMap["msg"] == "InValidPassword") {
                  toast("Invalid Password...!",);
                }
                isLoading(false);
              } else {
                toast("Invalid response format");
                isLoading(false);
              }
            } catch (e) {
              handleError("Error decoding response: $e", context);
              isLoading(false);
            }
          }
          // callback: (value) {
          //     Map<String, dynamic> valueMap = json.decode(value.response);
          //     print("123======");
          //     print(valueMap);
          //   if (valueMap["customer"]!="") {
          //     print("a======");
          //     SignInModel signInModel = SignInModel.fromJson(valueMap);
          //     print("b======");
          //     String userDataString = jsonEncode(signInModel.customer);
          //     prefs.setString(SharedPrefrenceData.customerData, userDataString);
          //     setUserData(signInModel.customer) ;
          //     print("a======");
          //     isLoading(false);
          //     final navController = Get.put(NavbarController());
          //     Get.to(() => const NavBarView());
          //     navController.selectPage(0);
          //   } if (valueMap["msg"] == "InvalidUser") {
          //         handleError("Invalid User...!", context);
          //         isLoading(false);
          //       // this.toast.show('Invalid User...!', '1500', 'center').subscribe(toast => { console.log(toast); });
          //     }
          //     if (valueMap["msg"] == "ActiveFalse") {
          //       handleError("Your account is not activeted...!", context);
          //       isLoading(false);
          //       // this.toast.show('Invalid User...!', '1500', 'center').subscribe(toast => { console.log(toast); });
          //     } if (valueMap["msg"] == "InValidPassword") {
          //       handleError("Invalid Password...!", context);
          //       isLoading(false);
          //       // this.toast.show('Invalid User...!', '1500', 'center').subscribe(toast => { console.log(toast); });
          //     }
          //
          //   // else {
          //   //   isError(true);
          //   //   error(valueMap["message"]);
          //   //   handleError(valueMap["message"], context);
          //   //   isLoading(false);
          //   // }
          // },
          );
    } catch (ex) {
      error("something went wrong");
      isLoading(false);
    }
  }
}
