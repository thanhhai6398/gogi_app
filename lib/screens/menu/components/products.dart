import 'package:flutter/material.dart';
import 'package:gogi/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../details/details_screen.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: List.generate(demoProducts.length, (index) {
        return Center(
          child: ProductCardMenu(product: demoProducts[index]),
        );
      }),
    );
  }
}

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
            onTap: () =>
                Navigator.pushNamed(
                  context,
                  DetailsScreen.routeName,
                  arguments: ProductDetailsArguments(product: product),
                ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(5.0),
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    product.image,
                    height: 120,
                    width: 80,
                  ),
                ),
                Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      alignment: Alignment.topCenter,
                      child: Column(children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              product.title,
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
                          alignment:  Alignment.topLeft,
                          child: Text(
                            product.description,
                            textAlign: TextAlign.justify,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Row(children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "35.000đ",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough
                              ),
                            ),
                          ),
                          SizedBox(width: getProportionateScreenWidth(5)),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${product.price}đ",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                              ),
                            ),
                          )
                        ],)
                      ]),
                    )),
              ],
            )
        )
    );
  }
}
