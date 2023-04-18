import 'package:flutter/material.dart';
import 'package:gogi/format.dart';

import '../../../constants.dart';
import '../../../models/Order_detail.dart';
import '../../../models/Product.dart';
import '../../../size_config.dart';

class Products extends StatelessWidget {
  List<OrderDetail> details = [];

  Products({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(5.0),
      children: List.generate(details.length, (index) {
        return Center(
          child: ProductOrder(detail: details[index]),
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
              "x${detail.quantity}",
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
            child: Image(
              image: NetworkImage(detail.img_url),
              fit: BoxFit.contain,
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
                  detail.product_name,
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
                  formatPrice(detail.price),
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
