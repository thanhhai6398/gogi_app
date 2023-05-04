import 'package:flutter/material.dart';

class RatingRequest {
  final int point;
  final int product_id;
  final String content;

  RatingRequest({required this.point, required this.product_id, required this.content});
}