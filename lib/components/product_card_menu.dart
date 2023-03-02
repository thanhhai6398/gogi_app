import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/Product.dart';
import '../screens/details/details_screen.dart';
import '../size_config.dart';

class ProductCardMenu extends StatelessWidget {
  const ProductCardMenu({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              DetailsScreen.routeName,
              arguments: ProductDetailsArguments(product: product),
            ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.topLeft,
              child: Image.asset(
                product.images[0],
                height: 100,
                width: 80,
              ),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.topLeft,
              child: Column(children: [
                Text(
                  product.title,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Text(
                  product.description,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  "\$${product.price}",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
              ]),
            )),
          ],
        )
        )
    );
  }
}
