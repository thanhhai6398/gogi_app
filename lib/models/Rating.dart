import 'dart:convert';

class Rating {
  final int id;
  final int point;
  final String content;
  final String username;
  final DateTime createdDate;

  Rating({
    required this.id,
    required this.point,
    required this.content,
    required this.username,
    required this.createdDate,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'] as int,
      point: json['point'] as int,
      content: json['content'] as String,
      username: json['username'] as String,
      createdDate: DateTime.parse(json['created_date']),
    );
  }
}

List<Rating> parseRates(String responseBody) {
  final parsed = jsonDecode(responseBody)["data"].cast<Map<String, dynamic>>();
  return parsed.map<Rating>((json) => Rating.fromJson(json)).toList();
}


