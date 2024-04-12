import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/apiServices/common_widget.dart';
import 'package:shopperz/app/apiServices/network_call.dart';
import 'package:shopperz/model/category_list_model.dart';
import 'package:shopperz/utils/api_list.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../model/product_sub_list_model.dart';

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

  categoryListDetails({required BuildContext context
    , String? categoryId
  }) async {
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


      Map<String, dynamic> param = {};
        if ( categoryId !="0") {
          // If categoryId is provided, include it in the API call
          param['catgoryId'] = categoryId;
      }
      getAPI(
          methodName: ApiList.categoryList,
          param: {},
          callback: (value) {
            try {
              Map<String, dynamic> valueMap = json.decode(value.response);
              // if (valueMap["statusCode"] == 200) {
              CategoryListModel categoryListModel = CategoryListModel.fromJson(valueMap);
              categoryList.addAll(categoryListModel.category);
              isLoading(false);
              // categoryList.forEach((category) async {
              //   await DatabaseHelper.insertCategory(category.toJson());
              // });
              // }
            } catch (e) {
              handleError("Error response: $e", context);
              isLoading(false);
            }
          }
      );
    } catch (ex) {
      handleError("Failed to fetch data: $ex", context);
      isLoading(false);
    }
  }

  RxList<Product> productList = <Product>[].obs;
  productListDetails({required BuildContext context
    , required String categoryId,
  }) async {
    isLoading(true);
    isError(false);
    error("");
    productList.clear();

    try {
      getAPI(
          methodName: ApiList.productList,
          param: { "id": categoryId,
            "sort": "5"},
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
          }
      );
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