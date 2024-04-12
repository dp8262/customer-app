import 'dart:developer';

import 'package:path/path.dart' as p;
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


  //Product table
  String productTable = "product_table";
   String parentCategoryId= "ParentCategoryId";
   String categoryId= "categoryId";
  String productId= "productId";
  String price= "price";
  String brandName= "brandName";
   String productName= "name";
   String productImage= "image";

  Future<Database> initializeDatabase() async {
    log("111====");
    //Directory directory = await getApplicationDocumentsDirectory();
    //log("directory ===$directory");
    //String path = "${directory.path}contact.db";
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

    await db.execute('CREATE TABLE $productTable($productId PRIMARY KEY, '
        '$categoryId TEXT,'
        '$parentCategoryId TEXT,'
        '$price TEXT,'
        '$brandName TEXT,'
        '$productName TEXT,'
        '$productImage TEXT)');
  }

  Future<int> insertCategory(Category contactModel) async {
    Database db = await database;
    int result = await db.insert(categoryTable, contactModel.toJson());
    return result;
  }

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
    print(categoryList);
    return categoryList;
  }

  Future<List<Product>> getAllProduct(String categoryId2) async {
    print("categoryId2=="+categoryId2);
    Database db = await database;
    var result = await db.query(
      productTable,where: '$categoryId = ?', whereArgs: [categoryId2]
    );
    List<Product> productList = [];
    print("result=="+result.toString());
    for (int i = 0; i < result.length; i++) {
      productList.add(Product.fromJson(result[i]));
    }
    print(productList);
    return productList;
  }

}
