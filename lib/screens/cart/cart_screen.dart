import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/CartProvider.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: const CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return AppBar(
      title: Column(
        children: [
          const Text(
            "Giỏ hàng",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${cart.getCounter()} Món đã chọn",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
