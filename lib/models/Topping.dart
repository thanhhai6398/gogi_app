import 'dart:convert';

import 'package:flutter/material.dart';

class Topping {
  final int id;
  final String name;
  final double price;
  final bool status;

  Topping({
    required this.id,
    required this.name,
    required this.price,
    required this.status,
  });

  factory Topping.fromJson(Map<String, dynamic> json) {
    return Topping(
        id: json['id'] as int,
        name: json['name'] as String,
        price: json['price'],
        status: json['status']);
  }
}

List<Topping> parseToppings(String responseBody) {
  final parsed = jsonDecode(responseBody)["data"].cast<Map<String, dynamic>>();
  return parsed
      .map<Topping>((json) => Topping.fromJson(json))
      .toList();
}