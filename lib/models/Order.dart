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
  final double voucherValue, voucherMax;


  @override
  String toString() {
    return 'Order{id: $id, createdDate: $createdDate, status: $status, orderType: $orderType, pay: $pay, total: $total, account_username: $account_username, customer: $customer, store: $store, orderDetails: $orderDetails, voucherValue: $voucherValue, voucherMax: $voucherMax}';
  }

  Order({
    required this.id,
    required this.createdDate,
    required this.status,
    required this.total,
    required this.account_username,
    required this.orderType,
    required this.pay,
    required this.store,
    required this.customer,
    required this.orderDetails,
    required this.voucherValue,
    required this.voucherMax,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var detailList = json['details'] as List;
    List<OrderDetail> details =
        detailList.map((o) => OrderDetail.fromJson(o)).toList();

    var voucher = json['voucher'];
    double voucherValue = 0.0, voucherMax = 0.0;
    if (voucher != null) {
      Voucher voucherModel = Voucher.fromJson(json['voucher']);
      voucherValue = voucherModel.value;
      voucherMax = voucherModel.maximumDiscountAmount;
    }
    return Order(
      id: json['id'],
      createdDate: DateTime.parse(json['createdDate']),
      status: json['status'],
      total: json['total'],
      account_username: json['account_username'],
      orderType: json['orderType'],
      pay: json['pay'],
      store: Store.fromJson(json['store']),
      customer: Customer.fromJson(json['customer']),
      orderDetails: details,
      voucherValue: voucherValue,
      voucherMax: voucherMax,
    );
  }
}

List<Order> parseOrders(String responseBody) {
  final parsed = jsonDecode(responseBody)["data"].cast<Map<String, dynamic>>();
  return parsed.map<Order>((json) => Order.fromJson(json)).toList();
}
