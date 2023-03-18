import 'package:flutter/material.dart';

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });
}

List<Category> demoCategory = [
  Category(
    id:1,
    name: "Trà sữa",
  ),
  Category(
    id:2,
    name: "Smoothies",
  ),
  Category(
    id:3,
    name: "Coffe",
  ),
  Category(
    id:4,
    name: "Đá xay",
  ),
  Category(
    id:5,
    name: "Sinh tố",
  ),
  Category(
    id:4,
    name: "Trà",
  ),
];