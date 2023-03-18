import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Order_detail.dart';
import '../../../size_config.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: List.generate(demoOrderDetails.length, (index) {
        return Center(
          child: ProductOrder(detail: demoOrderDetails[index]),
        );
      }),
    );
  }
}

class ProductOrder extends StatelessWidget {
  const ProductOrder({
    Key? key,
    required this.detail,
  }) : super(key: key);

  final OrderDetail detail;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.topCenter,
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "x ${detail.quantity}",
                          ),
                        ),
                        SizedBox(width: 5.0,),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                detail.product_id.toString(),
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  fontWeight: FontWeight.w400,
                                  color: kPrimaryColor,
                                ),
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(height: getProportionateScreenHeight(5)),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Size: ${detail.size}",
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${detail.price}đ",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor,
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ]
        )
    );
  }
}
