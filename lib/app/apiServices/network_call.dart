import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shopperz/app/apiServices/common_widget.dart';
import 'package:shopperz/model/responseapi.dart';
import 'package:shopperz/utils/api_list.dart';

Map<String, String> getHeaders() {
  Map<String, String> header = {};
  // if (AppConstants.authToken != "") {
  //   header["Authorization"] = 'Bearer ${AppConstants.authToken}';
  // }
  header["Content-Type"] = "application/json";
  return header;
}

postAPI({required String methodName, required Map<String, dynamic> param, required Function(ResponseAPI) callback}) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    String url = ApiList.baseUrl + methodName;
    Uri uri = Uri.parse(url);
    log("==request== $uri");
    log("==params== $param");
    await http.post(uri, headers: getHeaders(), body: param).then((value) {
      _handleResponse(value, callback);
    }).onError((error, stackTrace) {
      log("onError== $error");
      throw _handleError(error, callback);
    }).catchError((error) {
      log("catchError== $error");
      _handleError(error, callback);
    });
  } else {
    toast("No Internet");
    callback.call(ResponseAPI(
      0,
      "No Internet",
      isError: true,
    ));
  }
}

postAPIWithoutToken({required String methodName, required Map<String, dynamic> param, required Function(ResponseAPI) callback}) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    String url = ApiList.baseUrl + methodName;
    Uri uri = Uri.parse(url);
    log("==request== $uri");
    log("==params== $param");
    await http.post(uri, body: param).then((value) {
      _handleResponse(value, callback);
    }).onError((error, stackTrace) {
      log("onError== $error");
      throw _handleError(error, callback);
    }).catchError((error) {
      log("catchError== $error");
      _handleError(error, callback);
    });
  } else {
    toast("No Internet");
    callback.call(ResponseAPI(
      0,
      "No Internet",
      isError: true,
    ));
  }
}

getAPI({required String methodName, required Function(ResponseAPI) callback,required Map<String, dynamic> param}) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    String url = ApiList.baseUrl + methodName;
    Uri uri = Uri.parse(url);
    uri = uri.replace(queryParameters: param); // Add parameters to the URI
    log("==request== $uri");
    await http.get(uri, headers: getHeaders()).then((value) {
      _handleResponse(value, callback);
    }).onError((error, stackTrace) {
      log("onError== $error");
      _handleError(error, callback);
    }).catchError((error) {
      log("catchError== $error");
      _handleError(error, callback);
    });
  } else {
    toast("No Internet");
    callback.call(ResponseAPI(
      0,
      "No Internet",
      isError: true,
    ));
  }
}

getMapAPI({required String methodName, required Function(ResponseAPI) callback}) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    String url = methodName;
    Uri uri = Uri.parse(url);
    log("==request== $uri");
    await http
        .get(
      uri,
    )
        .then((value) {
      _handleResponse(value, callback);
    }).onError((error, stackTrace) {
      log("onError== $error");
      _handleError(error, callback);
    }).catchError((error) {
      log("catchError== $error");
      _handleError(error, callback);
    });
  } else {
    toast("No Internet");
    callback.call(ResponseAPI(
      0,
      "No Internet",
      isError: true,
    ));
  }
}

multipartPostAPI({
  required String methodName,
  required Map<String, String> param,
  required Function(ResponseAPI) callback,
  required List<XFile> photo,
  required String photoName,
}) async {
  var url = ApiList.baseUrl + methodName;
  var uri = Uri.parse(url);
  log("==request== $uri");
  log("==Params== $param");
  try {
    final imageUploadRequest = http.MultipartRequest('POST', uri);
    List<http.MultipartFile> file = [];
    for (int i = 0; i < photo.length; i++) {
      file.add(await http.MultipartFile.fromPath(
        photoName,
        photo[i].path,
        filename: photo[i].path,
      ));
    }
    imageUploadRequest.files.addAll(file);
    log("==photo== $photo");
    imageUploadRequest.fields.addAll(param);
    imageUploadRequest.headers.addAll(getHeaders());
    final streamedResponse = await imageUploadRequest.send();
    await http.Response.fromStream(streamedResponse).then((value) {
      _handleResponse(value, callback);
    }).onError((error, stackTrace) {
      _handleError(error, callback);
    }).catchError((error) {
      log("catchError== $error");
      _handleError(error, callback);
    });
  } catch (e) {
    _handleError(e, callback);
    // return null;
  }
}

_handleResponse(http.Response value, Function(ResponseAPI) callback) {
  var logger = Logger(
    level: Level.info,
    printer: PrettyPrinter(methodCount: 0, noBoxingByDefault: false),
  );
  logger.i("==response== ${value.body}");
  callback.call(ResponseAPI(value.statusCode, value.body));
}

_handleError(value, Function(ResponseAPI) callback) {
  var logger = Logger(
    level: Level.error,
  );
  logger.e("error:::::::::::::: ${value.body}");
  callback.call(ResponseAPI(
    0,
    "Something went wrong",
    isError: true,
    error: value,
  ));
}
