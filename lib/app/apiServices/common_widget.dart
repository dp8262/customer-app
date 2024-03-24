import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopperz/app/apiServices/extension_widget.dart';
import 'package:shopperz/config/theme/app_color.dart';

getScreenHeight(context) {
  return MediaQuery.of(context).size.height;
}

getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

Future<bool?> toast(String txt) => Fluttertoast.showToast(
    msg: txt,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColor.primaryColor,
    textColor: AppColor.whiteColor,
    fontSize: 16.0);

handleError(value, BuildContext context) {
  showAnimatedDialog(
    context: context,
    alignment: Alignment.center,
    animationType: DialogTransitionType.slideFromBottomFade,
    curve: Curves.fastOutSlowIn,
    duration: const Duration(milliseconds: 500),
    builder: (BuildContext context) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: getScreenWidth(context) * 0.8,
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColor.whiteColor, fontSize: 15, fontWeight: FontWeight.w600),
        ).alertCard(context),
      );
    },
  );
}
class LoadingStateWidget extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingStateWidget({Key? key, required this.child, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [IgnorePointer(ignoring: isLoading, child: child), Visibility(visible: isLoading, child: const LoadingWidget())],
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: SpinKitCircle(color: AppColor.primaryColor, size: 40));
  }
}