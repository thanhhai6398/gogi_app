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
      createdDate: DateTime.parse(json['created_date']),
    );
  }
}

List<Rate> parseRates(String responseBody) {
  final parsed = jsonDecode(responseBody)["data"].cast<Map<String, dynamic>>();
  return parsed.map<Rate>((json) => Rate.fromJson(json)).toList();
}

class RateReq {
  final int id;
  final int point;
  final String content;

  RateReq({
    required this.id,
    required this.point,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      "product_id": id,
      "point": point,
      "content": content,
    };
  }
}
String rateReqToJson( RateReq data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
