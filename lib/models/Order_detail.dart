import 'package:flutter/material.dart';
class OrderDetail {
  final int id;
  final double price;
  final int quantity;
  final String size;
  final int order_id;
  final int product_id;

  OrderDetail ({
    required this.id,
    required this.price,
    required this.quantity,
    required this.size,
    required this.order_id,
    required this.product_id,
  });
}
List<OrderDetail> demoOrderDetails = [
  OrderDetail(
    id: 1,
    price: 25000,
    quantity: 1,
    size: 'M',
    order_id: 1,
    product_id: 1,
  ),
  OrderDetail(
    id: 2,
    price: 20000,
    quantity: 1,
    size: 'S',
    order_id: 1,
    product_id: 2,
  ),
  OrderDetail(
    id: 3,
    price: 15000,
    quantity: 1,
    size: 'M',
    order_id: 2,
    product_id: 3,
  ),
  OrderDetail(
    id: 4,
    price: 20000,
    quantity: 1,
    size: 'S',
    order_id: 2,
    product_id: 2,
  ),
];