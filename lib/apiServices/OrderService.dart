import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/Order.dart';

class OrderService {
  Client client = Client();

  Future<List<Order>> getOrderByAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");
    final response =
        await client.get(
            Uri.parse('$url/orders/history'),
            headers: {'Authorization': 'Bearer $token',});
    return compute(parseOrders, response.body);
  }

  Future<bool> cancelOrder(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");
    final response = await client.put(
        Uri.parse('$url/orders/update/cancel/$id'),
        headers: {'Authorization': 'Bearer $token',});

    var res = json.decode(response.body);
    print(response.body);

    if (res["errCode"] == '200') {
      return true;
    } else {
      return false;
    }
  }
}
