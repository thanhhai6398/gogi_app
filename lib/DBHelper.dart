import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

import 'models/CartItem.dart';

class DBHelper {
  static const _databaseName = "gogi.db";
  static const tableName = 'cart';

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
        'CREATE TABLE cart(id INTEGER PRIMARY KEY AUTOINCREMENT, product_id INTEGER, name TEXT, image TEXT, size TEXT, quantity INTEGER, price  REAL)');
  }
// inserting data into the table
  Future<CartItem> insert(CartItem item) async {
    var dbClient = await database;
    await dbClient!.insert(tableName, item.toMap());
    return item;
  }
// getting all the items in the list from the database
  Future<List<CartItem>> getCartList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
    await dbClient!.query('cart');
    return queryResult.map((result) => CartItem.fromMap(result)).toList();
  }
  Future<int> updateQuantity(CartItem cart) async {
    var dbClient = await database;
    Map<String, dynamic> row = {
      'quantity': cart.quantity
    };
    return await dbClient!.update('cart', row,
        where: "id = ?", whereArgs: [cart.id]);
  }

// deleting an item from the cart screen
  Future<int> deleteCartItem(int id) async {
    var dbClient = await database;
    return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }
}