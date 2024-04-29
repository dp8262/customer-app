import 'dart:developer';

import 'package:path/path.dart' as p;
import 'package:shopperz/app/apiServices/common_widget.dart';
import 'package:shopperz/model/home_associate_brand_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../model/category_list_model.dart';
import '../../../../model/product_sub_list_model.dart';

class ContactDatabaseHelper {
  static ContactDatabaseHelper? _contactDatabaseHelper;

  ContactDatabaseHelper._createInstance();

  factory ContactDatabaseHelper() {
    _contactDatabaseHelper ??= ContactDatabaseHelper._createInstance();
    return _contactDatabaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  static Database? _database;

  String categoryTable = "category_table";
  String catgoryId = "catgoryId";
  String name = "name";
  String parentId = "parentId";
  String displayOrder = "displayOrder";
  String image = "image";
  String products = "products";

  // //Brand category
  // String brandTable = "brand_table";
  // String id = "id";
  // String brandCategoryName = "name";
  // String brandImage = "image";
  // String noOfProduct = "noOfProduct";

  //Product table
  String productTable = "product_table";
  String parentCategoryId = "ParentCategoryId";
  String categoryId = "categoryId";
  String productId = "productId";
  String price = "price";
  String brandName = "brandName";
  String productName = "name";
  String productImage = "image";

  //RecentView table
  String recentViewTable = "recent_view_table";
  Future<Database> initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'category.db');
    log("Database path ===$path");
    Database contactDB = await openDatabase(path, version: 1, onCreate: _createDB);
    log("contactDB ===${contactDB.isOpen}");
    return contactDB;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $categoryTable($catgoryId PRIMARY KEY, '
        '$name TEXT,'
        '$parentId TEXT,'
        '$displayOrder TEXT,'
        '$image TEXT,'
        '$products TEXT)');
    // await db.execute('CREATE TABLE $brandTable($id PRIMARY KEY, '
    //     '$brandCategoryName TEXT,'
    //     '$brandImage TEXT,'
    //     '$noOfProduct TEXT)');

    await db.execute('CREATE TABLE $productTable($productId PRIMARY KEY, '
        '$categoryId TEXT,'
        '$parentCategoryId TEXT,'
        '$price TEXT,'
        '$brandName TEXT,'
        '$productName TEXT,'
        '$productImage TEXT)');

    await db
        .execute('CREATE TABLE $recentViewTable($productId PRIMARY KEY, '
            '$categoryId TEXT,'
        '$parentCategoryId TEXT,'
        '$price TEXT,'
        '$brandName TEXT,'
        '$productName TEXT,'
        '$productImage TEXT)').catchError((val){
      print("$recentViewTable creating error :- $val");
    });
  }

  Future<int> insertCategory(Category contactModel) async {
    Database db = await database;
    int result = await db.insert(categoryTable, contactModel.toJson());
    return result;
  }

  // Future<int> insertBrandCategory(Manufacturer contactModel) async {
  //   Database db = await database;
  //   int result = await db.insert(brandTable, contactModel.toJson());
  //   return result;
  // }

  Future<int> insertProduct(Product contactModel) async {
    Database db = await database;
    int result = await db.insert(productTable, contactModel.toJson());
    return result;
  }

  Future<List<Category>> getAllCategory() async {
    Database db = await database;
    var result = await db.query(
      categoryTable,
    );
    List<Category> categoryList = [];
    for (int i = 0; i < result.length; i++) {
      categoryList.add(Category.fromJson(result[i]));
    }

    return categoryList;
  }

  // Future<List<Manufacturer>> getAllBrandCategory() async {
  //   Database db = await database;
  //   var result = await db.query(
  //     brandTable,
  //   );
  //   List<Manufacturer> brandsCategoryList = [];
  //   for (int i = 0; i < result.length; i++) {
  //     brandsCategoryList.add(Manufacturer.fromJson(result[i]));
  //   }
  //
  //   return brandsCategoryList;
  // }

  Future<List<Product>> getAllProduct(String categoryId2) async {
    Database db = await database;
    var result = await db.query(productTable, where: '$categoryId = ?', whereArgs: [categoryId2]);
    List<Product> productList = [];

    for (int i = 0; i < result.length; i++) {
      productList.add(Product.fromJson(result[i]));
    }

    return productList;
  }

  deleteAllTable() async {
    Database db = await database;
    var a = await db.delete(
      categoryTable,
    );

    var a1 = await db.delete(
      productTable,
    );
    var a2 = await db.delete(
      recentViewTable,
    );
    // var a3 = await db.delete(
    //   brandTable,
    // );
    toast("All record deleted.$a,$a1,$a2,");
  }

  Future<int> insertRecentProduct(Product model) async {
    Database db = await database;
    var checkData = await db.query(recentViewTable, where: '$productId = ?', whereArgs: [model.productId]);

    if (checkData.isNotEmpty) {
    var data =   await db.delete(recentViewTable, where: '$productId = ?', whereArgs: [model.productId]);

    print(data);
    }
    int result = await db.insert(recentViewTable, model.toJson());
    return result;
  }

  Future<List<Product>> getAllRecentProduct() async {
    Database db = await database;
    var result = await db.query(recentViewTable,);
    List<Product> productList = [];

    for (int i = 0; i < result.length; i++) {
      productList.add(Product.fromJson(result[i]));
    }
    print(productList);
    return productList;
  }


}
