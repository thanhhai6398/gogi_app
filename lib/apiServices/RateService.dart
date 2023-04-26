import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/Rate.dart';

class RateService {
  Client client = Client();

  Future<List<Rate>> getRateByProductId(int id) async {
    final response = await client.get(Uri.parse('$url/rates/product/$id'));
    return compute(parseRates, response.body);
  }

  Future<bool> checkExisted(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");
    final response = await client.get(
      Uri.parse('$url/rates/username/$id'),
      headers: {'Authorization': 'Bearer $token'},);
    var res = json.decode(response.body);
    print(response.body);

    if (res["data"] == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> postRate(RateReq data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");
    final response = await client.post(
        Uri.parse('$url/rates'),
        headers: {"content-type": "application/json; charset=UTF-8",'Authorization': 'Bearer $token'},
        body: rateReqToJson(data));

    var res = json.decode(response.body);
    print(response.body);

    if (res["errCode"] == '200') {
      return true;
    } else {
      return false;
    }
  }
}
