import 'dart:convert';

class Rate {
  final int id;
  final int point;
  final String content;
  final String username;
  final DateTime createdDate;

  Rate({
    required this.id,
    required this.point,
    required this.content,
    required this.username,
    required this.createdDate,
  });

  factory Rate.fromJson(Map<String, dynamic> json) {
    return Rate(
      id: json['id'] as int,
      point: json['point'] as int,
      content: json['content'] as String,
      username: json['username'] as String,
      createdDate:  DateTime.parse(json['created_date']) ,
    );
  }
}
List<Rate> parseRates(String responseBody) {
  final parsed = jsonDecode(responseBody)["data"].cast<Map<String, dynamic>>();
  return parsed.map<Rate>((json) => Rate.fromJson(json)).toList();
}
List<Rate> demoRates = [
  Rate(
    id: 1,
    point: 5,
    content: "Very good!!!",
    username: "0914276399",
    createdDate: DateTime.parse('2023-03-20'),
  ),
  Rate(
    id: 2,
    point: 4,
    content: "Great!!!",
    username: "0914276399",
    createdDate: DateTime.parse('2023-02-20'),
  ),
  Rate(
    id: 3,
    point: 4,
    content: "Good!!!",
    username: "0914276399",
    createdDate: DateTime.parse('2023-03-25'),
  ),
];