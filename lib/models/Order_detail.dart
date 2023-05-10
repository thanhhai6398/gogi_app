import 'package:flutter/material.dart';

class OrderDetail {
  final int id;
  final double price;
  final int quantity, product_id;
  final String size, product_name, img_url;

  OrderDetail({
    required this.id,
    required this.price,
    required this.quantity,
    required this.size,
    required this.product_id,
    required this.product_name,
    required this.img_url,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['detail_id'] as int,
      price: json['price'],
      quantity: json['quantity'],
      size: json['size'],
      product_id: json['product_id'],
      product_name: json['product_name'],
      img_url: json['img_url'],
    );
  }
}

List<OrderDetail> demoOrderDetails = [
  OrderDetail(
    id: 1,
    price: 25000,
    quantity: 3,
    size: 'M',
    product_id: 1, product_name: 'Yakult xay dâu tây', img_url: 'https://firebasestorage.googleapis.com/v0/b/gogi-images.appspot.com/o/files%2Fas6gs7h?alt=media&token=7b386c21-075e-49f8-9d60-5053dfee23b3',
  ),
  OrderDetail(
    id: 2,
    price: 20000,
    quantity: 1,
    size: 'S',
    product_id: 1, product_name: 'Yakult xay dâu tây', img_url: 'https://firebasestorage.googleapis.com/v0/b/gogi-images.appspot.com/o/files%2Fas6gs7h?alt=media&token=7b386c21-075e-49f8-9d60-5053dfee23b3',

  ),];
//   OrderDetail(
//     id: 3,
//     price: 15000,
//     quantity: 1,
//     size: 'M',
//     order_id: 2,
//     product_id: 3,
//   ),
//   OrderDetail(
//     id: 4,
//     price: 20000,
//     quantity: 2,
//     size: 'S',
//     order_id: 2,
//     product_id: 2,
//   ),
//   OrderDetail(
//     id: 5,
//     price: 15000,
//     quantity: 1,
//     size: 'M',
//     order_id: 2,
//     product_id: 3,
//   ),
//   OrderDetail(
//     id: 6,
//     price: 20000,
//     quantity: 2,
//     size: 'S',
//     order_id: 2,
//     product_id: 2,
//   ),
// ];
