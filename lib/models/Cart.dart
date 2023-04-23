import 'package:flutter/material.dart';

import 'Product.dart';

class Cart {
  final Product product;
  final int numOfItem;
  final String size;

  Cart({required this.product, required this.numOfItem, required this.size});
}

// Demo data for our cart

List<Cart> demoCarts = [
  Cart(product: demoProducts[0], numOfItem: 2, size: 'S'),
  Cart(product: demoProducts[1], numOfItem: 1, size: 'M'),
  Cart(product: demoProducts[2], numOfItem: 1, size: 'L'),
];
