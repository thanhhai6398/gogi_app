import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/Voucher.dart';

class VoucherService {

  Client client = Client();

  Future<List<Voucher>> getVoucher() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");

    final response =
    await client.get(Uri.parse('$url/vouchers/account'), headers: {
      'Authorization': 'Bearer $token',
    });
    return compute(parseVouchers, response.body);
  }

  Future<Voucher> searchVoucher(String code) async {
    final response = await client.get(Uri.parse('$url/vouchers/search?code=$code'));
    print(response.body);
    return compute(parseVoucher, response.body);
  }

  Future<Voucher> getVoucherById(int id) async {
    final response = await client.get(Uri.parse('$url/vouchers/$id'));
    return compute(parseVoucher, response.body);
  }

}
