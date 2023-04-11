import 'package:flutter/material.dart';
import 'package:gogi/apiServices/OrderService.dart';
import 'package:gogi/screens/order/components/order_content.dart';

import '../../../SharedPref.dart';
import '../../../models/Order.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  OrderService orderService = OrderService();
  SharedPref sharedPref = SharedPref();
  String username = '';
  _BodyState() {
    sharedPref.read("username").then((value) => setState(() {
      username = value;
    }));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
      FutureBuilder(
          future: orderService.getOrderByAccountId(username),
          builder: (context, AsyncSnapshot<List<Order>> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('An error...'),
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
