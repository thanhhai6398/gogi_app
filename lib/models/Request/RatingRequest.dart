import 'dart:convert';

class RatingRequest {
  final int id;
  final int point;
  final String content;

  RatingRequest({
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
String rateReqToJson(RatingRequest data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}