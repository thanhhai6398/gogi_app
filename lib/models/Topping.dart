import 'dart:convert';

import 'package:flutter/material.dart';

class Topping {
  int id;
  String name;
  double price = 0;
  bool status = false;

  Topping({
    required this.id,
    required this.name,
    required this.price,
    required this.status,
  });

  Topping.fromMap(Map<dynamic, dynamic> data)
      : id = data['topping_id'],
        name = data['topping_name'];

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
  return parsed.map<Topping>((json) => Topping.fromJson(json)).toList();
}
