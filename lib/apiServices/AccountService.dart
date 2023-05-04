import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:gogi/SharedPref.dart';
import 'package:gogi/models/Account.dart';
import 'package:gogi/models/Voucher.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/Product.dart';

class AccountService {
  SharedPref pref = SharedPref();

  Client client = Client();

  Future<bool> forgotPassword(String email) async {
    final response =
        await client.post(Uri.parse('$url/accounts/forgot_password/$email'));
    var res = json.decode(response.body);
    if (res["errCode"] == '200') {
      pref.save("token", res["data"]);
      return true;
    } else {
      return false;
    }
  }

  Future<bool?> resetPassword(Password data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    try {
      final response = await client.put(
        Uri.parse('$url/accounts/reset_password/$token'),
        headers: {"content-type": "application/json; charset=UTF-8"},
        body: passwordToJson(data),
      );
      var res = json.decode(response.body);
      if (res["errCode"] == '200') {
        return true;
      } else {
        return false;
      }
    }
    catch(e) {
      print('objectError: $e');
    }
    return null;
  }

  Future<List<Product>> getProductLiked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");

    final response =
        await client.get(Uri.parse('$url/accounts/productsLiked'), headers: {
      'Authorization': 'Bearer $token',
    });
    return compute(parseProducts, response.body);
  }

  Future<bool> like(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");

    final response = await client.post(
      Uri.parse("$url/like/$id"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    var res = json.decode(response.body);
    if (res["errCode"] == '200') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> unlike(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");

    final response = await client.post(
      Uri.parse("$url/like/unlike/$id"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    var res = json.decode(response.body);
    if (res["errCode"] == '200') {
      return true;
    } else {
      return false;
    }
  }

}
