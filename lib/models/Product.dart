import 'dart:convert';

import 'package:flutter/material.dart';

import 'Category.dart';
import 'Rate.dart';

class Product {
  final int id;
  final String name, image, description;
  final double price;
  final bool status;
  final CategoryModel category;
  final List<Rate> rates;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.status,
    required this.description,
    required this.category,
    required this.rates,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var rateList = json['rates'] as List;
    List<Rate> rates = rateList.map((r) => Rate.fromJson(r)).toList();
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      category: CategoryModel.fromJson(json["category"]),
      price: json['price'],
      status: json['status'],
      description: json['description'],
      image: json['img_url'],
      rates: rates,
    );
  }
}
List<Product> parseProducts(String responseBody) {
  final parsed =
  jsonDecode(responseBody)["data"].cast<Map<String, dynamic>>();
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
    rates: [],
  ),
  Product(
    id: 2,
    image: "assets/images/1.jpg",
    name: "Trà sữa trân châu",
    price: 30000,
    description: "description",
    status: true,
    category: CategoryModel(id: 1, name: "Coffee", status: true),
    rates: [],
  ),
  Product(
    id: 3,
    image: "assets/images/1.jpg",
    name: "Trà sữa trân châu",
    price: 30000,
    description: "description",
    status: true,
    category: CategoryModel(id: 1, name: "Coffee", status: true),
    rates: [],
  ),
];
//
// const String description =
//     "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
