import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;

import '../constants.dart';
import '../models/Order.dart';

class OrderService {
  Client client = Client();
  Future<List<Order>> getOrderByAccount(String username) async {
    final response = await client.get(Uri.parse('$url/orders/account/$username'));
    print(response.body);
    return compute(parseOrders, response.body);
  }
}