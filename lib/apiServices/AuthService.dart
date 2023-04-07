import 'dart:convert';

import 'package:http/http.dart';

import '../constants.dart';
import '../models/Request/AccountRequest.dart';

class AuthService {
  Client client = Client();

  Future<bool> login(AccountLogin data) async {
    final response = await client.post(
      Uri.parse("$url/auth"),
        headers: {"content-type": "application/json; charset=UTF-8"},
        body: accountLoginToJson(data),
    );
    var res = json.decode(response.body);
    print(res);
    if (res["errCode"] == '200') {
      return true;
    } else {
      return false;
    }
  }

  Future<AccountRes> register(AccountRegister data) async {
    final response = await client.post(
      Uri.parse("$url/register"),
      headers: {"content-type": "application/json; charset=UTF-8"},
      body: accountRegisterToJson(data),
    );
    var res = json.decode(response.body);
    String errCode = res["errCode"].toString();
    String errMsg = res["errMsg"].toString();
    AccountRes accountRes = AccountRes(errCode: errCode, errMsg: errMsg);
    return accountRes;
  }
}
