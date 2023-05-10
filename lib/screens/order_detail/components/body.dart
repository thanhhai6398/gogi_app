import 'package:flutter/material.dart';
import 'package:gogi/screens/order_detail/components/customer_inf.dart';

import '../../../constants.dart';
import '../../../format.dart';
import '../../../models/Order.dart';
import '../../order_detail/components/products.dart';

class Body extends StatelessWidget {
  final Order order;

  Body({Key? key, required this.order}) : super(key: key);

  double fee = 0.0;

  @override
  Widget build(BuildContext context) {
    if (order.orderType == 1) {
      fee = 20000.0;
    }
    double origin = (order.total - fee) / (1 - order.voucherValue);
    double discount = order.voucherValue * origin;

    if( discount > order.voucherValue) {
      origin = order.total - fee +  order.voucherMax;
      discount = order.voucherMax ;
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 5, left: 5),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                order.store.name,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                    color: Colors.black),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                  '${formatDate(order.createdDate)} ${formatTime(order.createdDate)}'),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Expanded(
                child: Products(
              details: order.orderDetails,
              state: order.status,
            )),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Tổng tiền hàng:",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const Spacer(),
                      Text(
                        formatPrice(origin),
                        style: const TextStyle(
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Voucher áp dụng:",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const Spacer(),
                      Text(
                        "-${formatPrice(discount)}",
                        style: const TextStyle(
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Thành tiền:",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0,
                            color: Colors.black),
                      ),
                      const Spacer(),
                      Text(
                        formatPrice(order.total),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 5.0),
            CustomerInf(customer: order.customer),
          ],
        ),
      ),
    );
  }
}
