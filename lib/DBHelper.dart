import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

import 'models/CartItem.dart';

class DBHelper {
  static const _databaseName = "gogi.db";
  static const _tableName = 'cart';

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _databaseName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  // creating database table
  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, product_id INTEGER, name TEXT, image TEXT, size TEXT, quantity INTEGER, price  REAL)');
  }

// inserting data into the table
  Future<CartItem> insert(CartItem item) async {
    var dbClient = await database;
    await dbClient?.rawInsert(
        "INSERT INTO $_tableName (product_id, name, image, size, quantity, price) VALUES(?, ?, ?, ?, ?, ?)",
        [
          item.product_id,
          item.name,
          item.image,
          item.size,
          item.quantity?.value,
          item.price
        ]);
    return item;
  }

  Future<CartItem?> getCartItem(int productId, String size) async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult = await dbClient!.rawQuery(
        'SELECT * FROM $_tableName WHERE product_id=? AND size = ?',
        [productId, size]);
    return queryResult.length > 0 ? CartItem.fromMap(queryResult[0]) : null;
  }

// getting all the items in the list from the database
  Future<List<CartItem>> getCartList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query(_tableName);
    return queryResult.map((result) => CartItem.fromMap(result)).toList();
  }

  Future<int?> update(int id, CartItem cartItem) async {
    var dbClient = await database;
    return await dbClient?.rawUpdate("UPDATE $_tableName SET quantity = ? WHERE id = ?",[ cartItem.quantity!.value, id]);
  }

// deleting an item from the cart screen
  Future<int> deleteCartItem(int id) async {
    var dbClient = await database;
    return await dbClient!.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
