
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/Customer.dart';

class CustomerService {
  Client client = Client();

  Future<List<Customer>> getCustomer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");

    final response =
    await client.get(Uri.parse('$url/accounts/customers'), headers: {
      'Authorization': 'Bearer $token',
    });
    return compute(parseCustomers, response.body);
  }
}