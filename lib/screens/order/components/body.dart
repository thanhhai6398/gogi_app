import 'package:flutter/material.dart';
import 'package:gogi/apiServices/OrderService.dart';
import 'package:gogi/screens/order/components/order_content.dart';

import '../../../models/Order.dart';

class Body extends StatelessWidget {
  OrderService orderService = OrderService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: orderService.getOrderByAccount(),
          builder: (context, AsyncSnapshot<List<Order>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('ERROR: ${snapshot.error.toString()}'),
              );
            } else if (snapshot.hasData) {
              return OrderContent(orders: snapshot.data!);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
