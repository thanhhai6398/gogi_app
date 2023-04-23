import 'package:flutter/cupertino.dart';

class CartItem {
  late final int id;
  final int product_id;
  final String name;
  final String image;
  final String size;
  final ValueNotifier<int>? quantity;
  final double price;

  CartItem(
      {
      required this.product_id,
      required this.name,
      required this.image,
      required this.size,
      required this.quantity,
      required this.price});

  CartItem.fromMap(Map<dynamic, dynamic> data)
      : id = data['id'],
        product_id = data['product_id'],
        name = data['name'],
        image = data['image'],
        size = data['size'],
        quantity = data['quantity'],
        price = data['price'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': product_id,
      'name': name,
      'image': image,
      'size': size,
      'quantity': quantity,
      'price': price,
    };
  }
}
