import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Order_detail.dart';
import '../../../size_config.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(5.0),
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
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              "x ${detail.quantity}",
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(10)),
            decoration: BoxDecoration(
              color: Color(0xFFF5F6F9),
              borderRadius: BorderRadius.circular(15),
            ),
            //product.image
            child: Image.asset(
              'assets/images/1.jpg',
              height: getProportionateScreenHeight(80),
              width: getProportionateScreenWidth(50),
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Expanded(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    //detail.product_id.toString()
                    child: Text(
                      'Trà sữa trân châu',
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(5)),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Size: ${detail.size}",
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(5)),
                  Container(
                    alignment: Alignment.topRight,
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
        ],
      ),
    );
  }
}
