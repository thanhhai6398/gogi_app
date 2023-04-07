class Account {
  final String username;
  final String accessToken;
  final Set<String> roles;

  Account(
      {required this.username, required this.accessToken, required this.roles});

  // factory Account.fromJson(Map<String, dynamic> json) {
  //   Set<String> roles = json["roles"].map((role) => role.authority);
  //   return Account(
  //       username: json["username"],
  //       accessToken: json["accessToken"],
  //       roles: roles);
  // }
}
