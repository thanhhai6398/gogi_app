import 'package:flutter/material.dart';
import 'package:gogi/screens/order_detail/components/customer.dart';

import '../../../constants.dart';
import '../../../models/Order.dart';
import '../../order_detail/components/products.dart';

class Body extends StatelessWidget {
  final Order order;

  const Body({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                order.store_name,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                    color: Colors.black),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(order.created_date),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Expanded(child: Products()),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                const Text(
                  "Tổng cộng:",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                      color: Colors.black),
                ),
                const Spacer(),
                Text(
                  "${order.total}đ",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Customer(),
          ],
        ),
      ),
    );
  }
}