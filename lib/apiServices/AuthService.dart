import 'dart:convert';

import 'package:http/http.dart';

import '../constants.dart';
import '../models/Account.dart';
import '../models/Request/AccountRequest.dart';

class AuthService {
  Client client = Client();

  // Future<bool> login(AccountLogin data) async {
  //   final response = await client.post(
  //     Uri.parse("$url/auth"),
  //     headers: {"content-type": "application/json; charset=UTF-8"},
  //     body: accountLoginToJson(data),
  //   );
  //   var res = json.decode(response.body);
  //   if (res["errCode"] == '200') {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  Future<AccountLoginRes?> login(AccountLogin data) async {
    try {
      final response = await client.post(
        Uri.parse("$url/auth"),
        headers: {"content-type": "application/json; charset=UTF-8"},
        body: accountLoginToJson(data),
      );
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        String errCode = res["errCode"].toString();
        String username = res["data"]["username"].toString();
        String accessToken = res["data"]["accessToken"].toString();
        AccountLoginRes accountLoginRes = AccountLoginRes(errCode: errCode ,username: username, accessToken: accessToken);
        print (username);
        return accountLoginRes;
      } else {
        return null;
      }
    }
    catch(e) {
      print('objectError: $e');
    }
    return null;
  }

  Future<AccountRegisterRes?> register(AccountRegister data) async {
    try {
      final response = await client.post(
        Uri.parse("$url/register"),
        headers: {"content-type": "application/json; charset=UTF-8"},
        body: accountRegisterToJson(data),
      );
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        String errCode = res["errCode"].toString();
        String errMsg = res["errMsg"].toString();
        AccountRegisterRes accountRegisterRes = AccountRegisterRes(errCode: errCode, errMsg: errMsg);
        return accountRegisterRes;
      } else {
        return null;
      }
    } catch(e) {
      print('objectError: $e');
    }
    return null;

  }
}
