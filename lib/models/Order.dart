import 'package:flutter/material.dart';

class Order {
  final int id;
  final String created_date;
  final int status;
  final double total;
  final String account;
  final int customer_id;
  final String store_name;

  Order({
    required this.id,
    required this.created_date,
    required this.status,
    required this.total,
    required this.account,
    required this.customer_id,
    required this.store_name,
  });
}

List<Order> demoOrders = [
  Order(
    id:1,
    created_date: '2022-12-28 20:54:19',
    status: 2,
    total: 98000,
    account: '0914276398',
    customer_id: 1,
    store_name: "Gogi Thu Duc",

  ),
  Order(
    id:2,
    created_date: '2022-12-28 20:54:19',
    status: 1,
    total: 98000,
    account: '0914276398',
    customer_id: 1,
    store_name: "Gogi Thu Duc",
  ),
  Order(
    id:3,
    created_date: '2022-12-28 20:54:19',
    status: 1,
    total: 98000,
    account: '0914276398',
    customer_id: 1,
    store_name: "Gogi Thu Duc",
  ),
  Order(
    id:4,
    created_date: '2022-12-28 20:54:19',
    status: 3,
    total: 98000,
    account: '0914276398',
    customer_id: 1,
    store_name: "Gogi Thu Duc",
  ),
  Order(
    id:5,
    created_date: '2022-12-28 20:54:19',
    status: 1,
    total: 98000,
    account: '0914276398',
    customer_id: 1,
    store_name: "Gogi Thu Duc",
  ),
  Order(
    id:6,
    created_date: '2022-12-28 20:54:19',
    status: 3,
    total: 98000,
    account: '0914276398',
    customer_id: 1,
    store_name: "Gogi Thu Duc",
  ),
];