import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<String> read(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  save(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<bool> containsKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  saveInt(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  Future<int?> readInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  saveDouble(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  Future<double?> readDouble(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  removeMultiple() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs
        .getKeys()
        .where((key) =>
            key != "username" &&
            key != "accessToken" &&
            key != "cart_items" &&
            key != "item_quantity" &&
            key != "total_price")
        .toList()
        .forEach((element) => remove(element));
    print('delete');
    // for(String key in prefs.getKeys()) {
    //   if( key != "username" && key != "accessToken" ) {
    //     remove(key);
    //   }
    // }
  }
}
