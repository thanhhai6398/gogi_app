import 'dart:math';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

import 'models/CartItem.dart';
import 'models/Topping.dart';

class DBHelper {
  static const _databaseName = "gogi.db";
  static const _tableName = 'cart';
  static const _order_details_toppings = 'order_details_toppings';

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
        'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, product_id INTEGER, name TEXT, image TEXT, size TEXT, sugar TEXT, iced TEXT, quantity INTEGER, price  REAL)');
    await db.execute(
        'CREATE TABLE $_order_details_toppings (detail_id INTEGER, topping_id INTEGER, topping_name TEXT, PRIMARY KEY (detail_id, topping_id) )');
  }

// inserting data into the table
  Future<CartItem> insert(CartItem item) async {
    var dbClient = await database;
    var newDetailId = Random().nextInt(10000);
    await dbClient?.rawInsert(
        "INSERT INTO $_tableName (id, product_id, name, image, size, sugar, iced, quantity, price) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)",
        [
          newDetailId,
          item.product_id,
          item.name,
          item.image,
          item.size,
          item.sugar,
          item.iced,
          item.quantity?.value,
          item.price
        ]);
    if (item.toppings.isNotEmpty) {
      await insertDetailToppings(newDetailId, item.toppings);
    }
    return item;
  }

  Future<void> insertDetailToppings(
      int detailId, List<Topping> toppings) async {
    var dbClient = await database;
    for (final topping in toppings) {
      await dbClient?.rawInsert(
          'INSERT INTO $_order_details_toppings (detail_id, topping_id, topping_name) VALUES (?, ?, ?)',
          [detailId, topping.id, topping.name]);
    }
  }

  Future<List<Topping>> getToppingByDetailId(int detailId) async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult = await dbClient!.rawQuery(
        'SELECT topping_id, topping_name FROM $_order_details_toppings WHERE detail_id = ?',
        [detailId]);
    return queryResult.isNotEmpty ? queryResult.map((result) => Topping.fromMap(result)).toList() : [];
  }

  Future<CartItem?> getCartItem(
      int productId, String size, String sugar, String iced) async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult = await dbClient!.rawQuery(
        'SELECT * FROM $_tableName WHERE product_id=? AND size = ? AND sugar=? AND iced = ?',
        [productId, size, sugar, iced]);
    return queryResult.isNotEmpty ? CartItem.fromMap(queryResult[0]) : null;
  }

// getting all the items in the list from the database
  Future<List<CartItem>> getCartList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query(_tableName);
    List<CartItem> cart =
        queryResult.map((result) => CartItem.fromMap(result)).toList();
    for (final item in cart) {
      List<Topping> toppings = await getToppingByDetailId(item.id);
      item.addTopping(toppings);
    }
    return cart;
  }

  Future<int?> update(int id, CartItem cartItem) async {
    var dbClient = await database;
    return await dbClient?.rawUpdate(
        "UPDATE $_tableName SET quantity = ? WHERE id = ?",
        [cartItem.quantity!.value, id]);
  }

// deleting an item from the cart screen
  Future<int> deleteCartItem(int id) async {
    var dbClient = await database;
    return await dbClient!.delete(_tableName, where: 'id = ?', whereArgs: [id]);

  }

  Future<void> deleteAll() async {
    var dbClient = await database;
    await dbClient?.rawQuery("DELETE FROM $_tableName");
    await dbClient?.rawQuery("DELETE FROM $_order_details_toppings");
  }

  Future<void> initDB() async {
    await database;
  }
}
