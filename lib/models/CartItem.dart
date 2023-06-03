import 'package:flutter/cupertino.dart';

class CartItem {
  late final int id;
  int product_id;
  String name;
  String image;
  String size, sugar, iced;
  ValueNotifier<int>? quantity;
  double price;

  CartItem(
      {required this.product_id,
      required this.name,
      required this.image,
      required this.size,
      required this.sugar,
      required this.iced,
      required this.quantity,
      required this.price});

  CartItem.fromMap(Map<dynamic, dynamic> data)
      : id = data['id'],
        product_id = data['product_id'],
        name = data['name'],
        image = data['image'],
        size = data['size'],
        sugar = data['sugar'],
        iced = data['iced'],
        quantity = ValueNotifier(data['quantity']),
        price = data['price'];

  Map<String, dynamic> toMap() {
    return {
      'product_id': product_id,
      'size': size,
      'sugar': sugar,
      'iced': iced,
      'quantity': quantity?.value,
      'price': price,
    };
  }

  static dynamic getListMap(List<dynamic> items) {
    if (items == null) {
      return null;
    }
    List<Map<String, dynamic>> list = [];
    for (var element in items) {
      list.add(element.toMap());
    }
    return list;
  }

  @override
  String toString() {
    return 'CartItem{product_id: $product_id, size: $size, quantity: $quantity, price: $price}';
  }
}
