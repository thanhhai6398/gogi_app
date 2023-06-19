import 'package:flutter/material.dart';
import 'package:gogi/format.dart';
import 'package:gogi/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../details/details_screen.dart';

class Products extends StatelessWidget {
  List<Product> products = [];

  Products({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(
        child: Text(
          "Không có sản phẩm",
          style: TextStyle(color: Colors.black),
        ),
      );
    } else {
      return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        children: List.generate(products.length, (index) {
          if (products[index].status == true) {
            return Center(
              child: ProductCardMenu(product: products[index]),
            );
          }
          return const SizedBox.shrink();
        }),
      );
    }
  }
}

class ProductCardMenu extends StatelessWidget {
  const ProductCardMenu({
    Key? key,
    required this.product,
  }) : super(key: key);

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
                  alignment: Alignment.topCenter,
                  child: Image(
                    image: NetworkImage(product.image),
                    height: 120,
                    width: 100,
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
                        totTitle(product.name),
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(16),
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(5)),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        product.description,
                        textAlign: TextAlign.justify,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            formatPrice(product.price / (1 - product.discount)),
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                        SizedBox(width: getProportionateScreenWidth(5)),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            formatPrice(product.price),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor,
                            ),
                          ),
                        )
                      ],
                    )
                  ]),
                )),
              ],
            )));
  }
}
