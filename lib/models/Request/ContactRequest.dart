import 'dart:convert';

class ContactRequest {
  final String fullname;
  final String email;
  final String content;

  ContactRequest({required this.fullname, required this.email, required this.content});

  Map<String, dynamic> toJson() {
    return {"fullname": fullname, "email": email, "content": content};
  }
}
String contactRequestToJson(ContactRequest data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}