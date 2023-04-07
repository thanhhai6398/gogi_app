import 'dart:convert';

class FeedbackRequest {
  late final String fullName;
  late final String email;
  late final String content;

  FeedbackRequest({required this.fullName, required this.email, required this.content});

  Map<String, dynamic> toJson() {
    return {"fullname": fullName, "email": email, "content":content};
  }
}

String feedbackRequestToJson(FeedbackRequest payload) {
  final jsonData = payload.toJson();
  return json.encode(jsonData);
}
