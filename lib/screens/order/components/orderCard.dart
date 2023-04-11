import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../enums.dart';
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
    String status = '';
    for (var e in orderStatus) {
      if(e["id"] == order.status) {
        status = e["name"];
      }
    }
    var formattedDate = "${order.createdDate.day}-${order.createdDate.month}-${order.createdDate.year}";
    return Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Image(
                image: NetworkImage(order.orderDetails[0].img_url),
                fit: BoxFit.contain,
                width: 80,
                height: 100,
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
                    order.store.name,
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
                    formattedDate,
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
                        "Status: $status",
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
                        "Chi tiết",
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
