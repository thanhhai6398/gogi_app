import 'dart:convert';

class AccountLoginRes {
  final String errCode;
  final String username;
  final String accessToken;

  AccountLoginRes({
    required this.errCode,
    required this.username,
    required this.accessToken,
  });
}


class AccountRegisterRes {
  final String errCode;
  final String errMsg;

  AccountRegisterRes({
    required this.errCode,
    required this.errMsg,
  });
}

class Password {
  final String password;

  Password({
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {"password": password,};
  }
}

String passwordToJson(Password data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
