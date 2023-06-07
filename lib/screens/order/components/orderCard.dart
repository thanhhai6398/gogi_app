import 'package:flutter/material.dart';
import 'package:gogi/apiServices/OrderService.dart';
import 'package:gogi/components/toast.dart';
import 'package:gogi/screens/order/order_screen.dart';

import '../../../constants.dart';
import '../../../enums.dart';
import '../../../format.dart';
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
      if (e["id"] == order.status) {
        status = e["name"];
      }
    }
    return Card(
        color: Colors.white,
        child: SizedBox(
          child: GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                OrderDetailScreen.routeName,
                arguments: OrderDetailsArguments(order: order),
              ),
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
                          formatDate(order.createdDate),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(5)),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          formatCurrency(order.total),
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
                          buttonRate(order: order,),
                        ],
                      )
                    ]),
                  )),
                ],
              )),
        ));
  }
}
class buttonRate extends StatelessWidget {
  OrderService orderService = OrderService();
  Order order;

  buttonRate({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    if (order.status == 2) {
      return Align(
        alignment: Alignment.bottomRight,
        child: TextButton(
          onPressed: () => Navigator.pushNamed(
            context,
            OrderDetailScreen.routeName,
            arguments: OrderDetailsArguments(order: order),
          ),
          style: const ButtonStyle(
              backgroundColor:
              MaterialStatePropertyAll<Color>(
                  kPrimaryColor)),
          child: const Text(
            "Đánh giá",
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontStyle: FontStyle.italic,
                color: Colors.white),
          ),
        ),
      );
    } else if (order.status == 0){
      return Align(
        alignment: Alignment.bottomRight,
        child: TextButton(
          onPressed: () => {
            orderService.cancelOrder(order.id).then((value) {
              if(value == true) {
                successToast("Hủy thành công");
                Navigator.pushReplacementNamed(context, OrderScreen.routeName);
              } else {
                print("Error");
              }
            })
          },
          style: const ButtonStyle(
              backgroundColor:
              MaterialStatePropertyAll<Color>(
                  kPrimaryColor)),
          child: const Text(
            "Hủy",
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontStyle: FontStyle.italic,
                color: Colors.white),
          ),
        ),
      );
    }else {
      return const SizedBox.shrink();
    }
  }
}
