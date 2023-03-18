import 'package:flutter/material.dart';

import '../../screens/order_detail/components/body.dart';
import '../../models/Order.dart';

class OrderDetailScreen extends StatelessWidget {
  static String routeName = "/order_detail";
  @override
  Widget build(BuildContext context) {
    final OrderDetailsArguments args =
    ModalRoute.of(context)!.settings.arguments as OrderDetailsArguments;
    return Scaffold(
      appBar: AppBar(),
      body: Body(order: args.order),
    );
  }
}

class OrderDetailsArguments {
  final Order order;

  OrderDetailsArguments({required this.order});
}