import 'dart:convert';

import 'package:flutter/material.dart';

import 'Category.dart';

class Product {
  final int id;
  final String name, image, description;
  final double price;
  final bool status;
  final CategoryModel category;


  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.status,
    required this.description,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      category: CategoryModel.fromJson(json["category"]),
      price: json['price'],
      status: json['status'],
      description: json['description'],
      image: json['img_url'],
    );
  }
}
List<Product> parseProducts(String responseBody) {
  final parsed =
  jsonDecode(responseBody)["data"].cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}
List<Product> parseOtherProducts(String responseBody) {
  final parsed =
  jsonDecode(responseBody)["data"]["content"].cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}
// Our demo Products

List<Product> demoProducts = [
  Product(
    id: 1,
    image: "assets/images/1.jpg",
    name: "Trà sữa trân châu",
    price: 30000,
    description: "description",
    status: true,
    category: CategoryModel(id: 1, name: "Coffee", status: true),
  ),
  Product(
    id: 2,
    image: "assets/images/1.jpg",
    name: "Trà sữa trân châu",
    price: 30000,
    description: "description",
    status: true,
    category: CategoryModel(id: 1, name: "Coffee", status: true),
  ),
  Product(
    id: 3,
    image: "assets/images/1.jpg",
    name: "Trà sữa trân châu",
    price: 30000,
    description: "description",
    status: true,
    category: CategoryModel(id: 1, name: "Coffee", status: true),
  ),
];
//
// const String description =
//     "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
