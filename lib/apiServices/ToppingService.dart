import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/Topping.dart';

class ToppingService {
  Client client = Client();

  Future<List<Topping>> getAllTopping() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");

    final response = await client.get(Uri.parse('$url/toppings/available'), headers: {
      'Authorization': 'Bearer $token',
    });
    return compute(parseToppings, response.body);
  }
}
