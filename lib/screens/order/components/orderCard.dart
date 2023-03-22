import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../constants.dart';
import '../../../constants.dart';
import '../../../constants.dart';
import '../../../models/Order.dart';
import '../../../size_config.dart';
import '../../order_detail/order_detail_screen.dart';

class OrderCard extends StatelessWidget {
  OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: const Image(
                image: AssetImage('assets/images/Order.png'),
                width: 80,
                height: 80,
              ),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.topLeft,
              child: Column(children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    order.store_name,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    order.created_date,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${order.total.toString()}đ",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Status: ${order.status.toString()}",
                        maxLines: 2,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        OrderDetailScreen.routeName,
                        arguments: OrderDetailsArguments(order: order),
                      ),
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(kPrimaryColor)),
                      child: const Text(
                        "detail >",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic,
                          color: Colors.white
                        ),
                      ),
                    )
                  ],
                )
              ]),
            )),
          ],
        ));
  }
}
