
import 'dart:convert';

import '../CartItem.dart';

class OrderRequest {
  final int orderType;
  final double total;
  final String account_username;
  final int customer_id;
  final int store_id;
  final voucher_id;
  final List<CartItem> details;

  @override
  String toString() {
    return 'OrderReq{orderType: $orderType, total: $total, account_username: $account_username, customer_id: $customer_id, store_id: $store_id, voucher_id: $voucher_id, details: $details}';
  }

  OrderRequest(
      {required this.customer_id,
        required this.store_id,
        required this.account_username,
        required this.orderType,
        required this.total,
        required this.details,
        required this.voucher_id});

  Map<String, dynamic> toJson() {
    return {
      "customer": {
        "id": customer_id
      },
      "store_id": store_id,
      "account_username": account_username,
      "orderType": orderType,
      "total": total,
      "details": CartItem.getListMap(details),
      "voucher_id": voucher_id,
    };
  }
}

String orderRequestToJson(OrderRequest data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}