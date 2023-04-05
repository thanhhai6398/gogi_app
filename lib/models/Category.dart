import 'dart:convert';

import 'package:flutter/material.dart';

class CategoryModel {
  final int id;
  final String name;
  final bool status;

  CategoryModel({
    required this.id,
    required this.name,
    required this.status,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'] as int,
        name: json['name'] as String,
        status: json['status']);
  }
}

List<CategoryModel> parseCategories(String responseBody) {
  final parsed = jsonDecode(responseBody)["data"].cast<Map<String, dynamic>>();
  return parsed
      .map<CategoryModel>((json) => CategoryModel.fromJson(json))
      .toList();
}

List<CategoryModel> demoCategory = [
  CategoryModel(
    id: 1,
    name: "Trà sữa",
    status: true,
  ),
  CategoryModel(
    id: 2,
    name: "Smoothies",
    status: true,
  ),
  CategoryModel(
    id: 3,
    name: "Coffe",
    status: true,
  ),
  CategoryModel(
    id: 4,
    name: "Đá xay",
    status: true,
  ),
  CategoryModel(
    id: 5,
    name: "Sinh tố",
    status: true,
  ),
  CategoryModel(
    id: 4,
    name: "Trà",
    status: true,
  ),
];
