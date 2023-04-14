import 'dart:convert';

class AccountLogin {
  final String username;
  final String password;

  AccountLogin({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {"username": username, "password": password};
  }
}

String accountLoginToJson(AccountLogin data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

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

class AccountRegister {
  final String username;
  final String password;
  final String email;

  AccountRegister({
    required this.username,
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {"username": username, "password": password, "email": email};
  }
}

String accountRegisterToJson(AccountRegister data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
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
