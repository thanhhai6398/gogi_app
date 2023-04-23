import 'dart:convert';

import 'package:gogi/models/Customer.dart';

import 'Order_detail.dart';
import 'Store.dart';
import 'Voucher.dart';

class Order {
  final int id;
  final DateTime createdDate;
  final int status, orderType;
  final bool pay;
  final double total;
  final String account_username;
  final Customer customer;
  final Store store;
  final List<OrderDetail> orderDetails;
  // final Voucher voucher;

  Order({
    required this.id,
    required this.createdDate,
    required this.status,
    required this.total,
    required this.account_username,
    //required this.employee_name,
    required this.orderType,
    required this.pay,
    required this.store,
    required this.customer,
    required this.orderDetails,
    // required this.voucher,
  });
  factory Order.fromJson(Map<String, dynamic> json) {
    var detailList = json['details'] as List;
    List<OrderDetail> details = detailList.map((o) => OrderDetail.fromJson(o)).toList();
    return Order(
        id: json['id'],
        createdDate: DateTime.parse(json['createdDate']),
        status: json['status'],
        total: json['total'],
        account_username: json['account_username'],
        //employee_name: json['employee_name'],
        orderType: json['orderType'],
        pay: json['pay'],
        store: Store.fromJson(json['store']),
        customer: Customer.fromJson(json['customer']),
        orderDetails: details,
        //voucher: Voucher.fromJson(json['voucher']),
    );
  }
}
List<Order> parseOrders(String responseBody) {
  final parsed =
  jsonDecode(responseBody)["data"].cast<Map<String, dynamic>>();
  return parsed.map<Order>((json) => Order.fromJson(json)).toList();
}

// List<Order> demoOrders = [
//   Order(
//     id: 1,
//     created_date: '2022-12-28 20:54:19',
//     status: 2,
//     total: 98000,
//     account: '0914276398',
//     customer_id: 1,
//     store_name: "Gogi Thu Duc",
//   ),
//   Order(
//     id: 2,
//     created_date: '2022-12-28 20:54:19',
//     status: 1,
//     total: 50000,
//     account: '0914276398',
//     customer_id: 1,
//     store_name: "Gogi Phan Văn Trị",
//   ),
//   Order(
//     id: 3,
//     created_date: '2022-12-28 20:54:19',
//     status: 3,
//     total: 98000,
//     account: '0914276398',
//     customer_id: 1,
//     store_name: "Gogi Bình Tân",
//   ),
//   Order(
//     id: 4,
//     created_date: '2022-12-28 20:54:19',
//     status: 3,
//     total: 98000,
//     account: '0914276398',
//     customer_id: 1,
//     store_name: "Gogi Võ Văn Ngân",
//   ),
//   Order(
//     id: 5,
//     created_date: '2022-12-28 20:54:19',
//     status: 1,
//     total: 98000,
//     account: '0914276398',
//     customer_id: 1,
//     store_name: "Gogi Thu Duc",
//   ),
//   Order(
//     id: 6,
//     created_date: '2022-12-28 20:54:19',
//     status: 3,
//     total: 98000,
//     account: '0914276398',
//     customer_id: 1,
//     store_name: "Gogi Linh Trung",
//   ),
// ];
