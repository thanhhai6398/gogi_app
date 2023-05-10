
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/Customer.dart';
import '../models/Request/CustomerRequest.dart';

class CustomerService {
  Client client = Client();

  Future<List<Customer>> getCustomer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");

    final response =
    await client.get(Uri.parse('$url/accounts/customers'),
        headers: {'Authorization': 'Bearer $token',
    });
    return compute(parseCustomers, response.body);
  }

  Future<Customer> getCustomerDefault() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");

    final response =
    await client.get(Uri.parse('$url/accounts/customers/default'),
        headers: {'Authorization': 'Bearer $token',
        });
    return compute(parseCustomer, response.body);
  }

  Future<Customer> getCustomerById(int id) async {
    final response =
    await client.get(Uri.parse('$url/customers/$id'));
    return compute(parseCustomer, response.body);
  }

  Future<bool> postCustomer(CustomerRequest data) async {
    final response =
    await client.post(Uri.parse('$url/customers'),
      headers: {"content-type": "application/json; charset=UTF-8"},
      body: customerReqToJson(data),);
    var res = json.decode(response.body);
    if (res["errCode"] == '200') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> putCustomer(CustomerRequest data, int id) async {
    final response =
    await client.put(Uri.parse('$url/customers/$id'),
      headers: {"content-type": "application/json; charset=UTF-8"},
      body: customerReqToJson(data),);
    var res = json.decode(response.body);
    if (res["errCode"] == '200') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> putCustomerDefault(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");
    final response =
    await client.put(Uri.parse('$url/accounts/customers/default/$id'),
      headers: {'Authorization': 'Bearer $token'});
    var res = json.decode(response.body);

    if (res["errCode"] == '200') {
      return true;
    } else {
      return false;
    }
  }
}