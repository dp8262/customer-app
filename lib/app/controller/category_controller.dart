import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:shopperz/app/apiServices/common_widget.dart';
import 'package:shopperz/app/apiServices/network_call.dart';
import 'package:shopperz/model/category_list_model.dart';
import 'package:shopperz/model/product_details_view_model.dart';
import 'package:shopperz/utils/api_list.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/product_sub_list_model.dart';
import '../modules/category/views/sqlite_helper.dart';

class CategoryControllers extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  RxString error = "".obs;

  // List<dynamic> getAll(String categoryId) {
  //   List<dynamic> items = [];
  //
  //   if (categoryList == null) {
  //     return items;
  //   }
  //
  //   for (int i = 0; i < categoryList.length; i++) {
  //     if (categoryList[i].parentId == categoryId) {
  //       items.add(categoryList[i]);
  //     }
  //   }
  //
  //   return items;
  // }

  RxList<Category> categoryList = <Category>[].obs;
  ContactDatabaseHelper contactDatabaseHelper = ContactDatabaseHelper();

  categoryListDetails({required BuildContext context, String? categoryId}) async {
    isLoading(true);
    isError(false);
    error("");
    categoryList.clear();

    try {
      // final List<Map<String, dynamic>> localCategories = await DatabaseHelper.getCategories();
      //
      // // If local data is available, update categoryList and return
      // if (localCategories.isNotEmpty) {
      //   categoryList.addAll(localCategories.map((category) => Category.fromJson(category)));
      //   isLoading(false);
      //   return;
      // }

      final Future<Database> dbFuture = contactDatabaseHelper.initializeDatabase();
      dbFuture.then((database) async {
        categoryList.value = await contactDatabaseHelper.getAllCategory();
        if (categoryList.isEmpty) {
          getAPI(
              methodName: ApiList.categoryList,
              param: {},
              callback: (value) {
                try {
                  Map<String, dynamic> valueMap = json.decode(value.response);
                  // if (valueMap["statusCode"] == 200) {
                  CategoryListModel categoryListModel = CategoryListModel.fromJson(valueMap);
                  categoryList.addAll(categoryListModel.category);
                  if (categoryList.isNotEmpty) {
                    for (int i = 0; i < categoryList.length; i++) {
                      contactDatabaseHelper.insertCategory(categoryList[i]);
                    }
                    // categoryList.add(Category(
                    //     id: contacts[i].id,
                    //     displayName: contacts[i].displayName,
                    //     photo: "",
                    //     number: contacts[i].phones[0].number.removeAllWhitespace,
                    //     blessUserId: "",
                    //     blessUserName: ""));
                  }
                  isLoading(false);
                  // categoryList.forEach((category) async {
                  //   await DatabaseHelper.insertCategory(category.toJson());
                  // });
                  // }
                } catch (e) {
                  handleError("Error response: $e", context);
                  isLoading(false);
                }
              });
        } else {
          isLoading(false);
        }
      });
    } catch (ex) {
      handleError("Failed to fetch data: $ex", context);
      isLoading(false);
    }
  }

  RxList<Product> productList = <Product>[].obs;
  String sortByID = "5";

  productListDetails({
    required BuildContext context,
    required String categoryId,
    // required String sortBy,
  }) async {
    isLoading(true);
    isError(false);
    error("");
    productList.clear();

    try {
      final Future<Database> dbFuture = contactDatabaseHelper.initializeDatabase();

      dbFuture.then((database) async {
        productList.value = await contactDatabaseHelper.getAllProduct(categoryId);
        if (productList.isEmpty) {
          getAPI(
              methodName: ApiList.productList,
              param: {"id": categoryId, "sort": "5"},
              callback: (value) {
                try {
                  Map<String, dynamic> valueMap = json.decode(value.response);
                  // if (valueMap["statusCode"] == 200) {
                  ProductListModel productListModel = ProductListModel.fromJson(valueMap);
                  productList.addAll(productListModel.product);
                  if (productList.isNotEmpty) {
                    for (int i = 0; i < productList.length; i++) {
                      contactDatabaseHelper.insertProduct(productList[i]);
                    }
                  }
                  isLoading(false);
                  // }
                } catch (e) {
                  handleError("Error response: $e", context);
                  isLoading(false);
                }
              });
        } else {
          isLoading(false);
        }
      });
    } catch (ex) {
      handleError("Failed to fetch data: $ex", context);
      isLoading(false);
    }
  }

  filterProductListDetails({
    required BuildContext context,
    required String categoryId,
    required String sortBy,
  }) async {
    isLoading(true);
    isError(false);
    error("");
    productList.clear();

    try {
      if (productList.isEmpty) {
        if (sortBy == "Name A to Z") {
          sortByID = "5";
        }
        if (sortBy == "Name Z to A") {
          sortByID = "6";
        }
        if (sortBy == "Created on") {
          sortByID = "15";
        }
        print("sort list ${sortByID}");
        getAPI(
            methodName: ApiList.productList,
            param: {"id": categoryId, "sort": sortByID},
            callback: (value) {
              try {
                Map<String, dynamic> valueMap = json.decode(value.response);
                // if (valueMap["statusCode"] == 200) {
                ProductListModel productListModel = ProductListModel.fromJson(valueMap);
                productList.addAll(productListModel.product);

                isLoading(false);
                // }
              } catch (e) {
                handleError("Error response: $e", context);
                isLoading(false);
              }
            });
      } else {
        isLoading(false);
      }
    } catch (ex) {
      handleError("Failed to fetch data: $ex", context);
      isLoading(false);
    }
  }

  RxList<ProductDetails> productDetails = <ProductDetails>[].obs;
  String? color;
  String? material;
  String? style;
  String? weight;
  String? dimensions;
  String? powerSource;
  // String? description;

  productViewDetails({required BuildContext context, required String itemId}) async {
    isLoading(true);
    isError(false);
    error("");
    productDetails.clear();

    try {
      // if (productList.isEmpty) {

      getAPI(
          methodName: ApiList.productViewDetails,
          param: {"id": itemId},
          callback: (value) {
            try {
              Map<String, dynamic> valueMap = json.decode(value.response);
              // if (valueMap["statusCode"] == 200) {
              ProductDetailsModel productDetailsModel = ProductDetailsModel.fromJson(valueMap);
              productDetails.addAll(productDetailsModel.productDetails);

              // if (productDetails.isNotEmpty && productDetails.length > 0) {
              //   final document = htmlParser.parse(productDetails[0].fullDescription);
              //
              //   final colorElement = document.querySelector('.po-color');
              //   color = colorElement?.querySelector('.po-break-word')?.text;
              //
              //   final materialElement = document.querySelector('.po-material');
              //   material = materialElement?.querySelector('.po-break-word')?.text;
              //
              //   final styleElement = document.querySelector('.po-brand');
              //   style = styleElement?.querySelector('.a-span9')?.text;
              //
              //   // final powerSourceElement = document.querySelector('.po-brand'); // Check if this selector is correct
              //   // powerSource = powerSourceElement?.nextElementSibling
              //   //     ?.querySelector('.a-span9')
              //   //     ?.text;
              //   final powerSourceElement = document.querySelector('.po-brand'); // Corrected selector
              //   if (powerSourceElement != null) {
              //     final powerSourceText = powerSourceElement.nextElementSibling?.querySelector('.a-span9')?.text;
              //     if (powerSourceText != null && powerSourceText.isNotEmpty) {
              //       powerSource = powerSourceText;
              //     }
              //   }
              //
              //   final weightElement = document.querySelector('.woocommerce-product-attributes-item--weight');
              //   weight = weightElement?.querySelector('.woocommerce-product-attributes-item__value')?.text;
              //
              //   final dimensionsElement = document.querySelector('.woocommerce-product-attributes-item--dimensions');
              //   dimensions = dimensionsElement?.querySelector('.woocommerce-product-attributes-item__value')?.text;
              //
              //
              //   print("description ${productDetails[0].description}");
              //
              // }
              isLoading(false);
              // }
            } catch (e) {
              handleError("Error response: $e", context);
              isLoading(false);
            }
          });
      // } else {
      //   isLoading(false);
      // }
    } catch (ex) {
      handleError("Failed to fetch data: $ex", context);
      isLoading(false);
    }
  }
}
// class DatabaseHelper {
//   static Database? _database;
//   static const String _tableName = 'category';
//
//   static Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//
//     _database = await initDatabase();
//     return _database!;
//   }
//
//   static Future<Database> initDatabase() async {
//     final databasesPath = await getDatabasesPath();
//     final path = join(databasesPath, 'your_database.db');
//
//     return await openDatabase(path, version: 1, onCreate: (db, version) async {
//       await db.execute('''
//         CREATE TABLE $_tableName (
//           id INTEGER PRIMARY KEY,
//           name TEXT
//         )
//       ''');
//     }, onOpen: (db) async {
//       // Ensure that the table is created when the database is opened
//       await db.execute('''
//         CREATE TABLE IF NOT EXISTS $_tableName (
//           id INTEGER PRIMARY KEY,
//           name TEXT
//         )
//       ''');
//     });
//   }
//
//   static Future<List<Map<String, dynamic>>> getCategories() async {
//     final db = await database;
//     return await db.query(_tableName);
//   }
//
//   static Future<void> insertCategory(Map<String, dynamic> category) async {
//     final db = await database;
//     await db.insert(_tableName, category, conflictAlgorithm: ConflictAlgorithm.replace);
//   }
// }
