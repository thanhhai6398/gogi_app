import 'package:flutter/material.dart';
import 'package:gogi/components/product_card.dart';
import 'package:gogi/models/Product.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  List<Product> products = [];

  PopularProducts({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenWidth(15)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  products.length,
                      (index) {
                    if (products[index].status == true) {
                      return ProductCard(product: products[index]);
                    }

                    return const SizedBox
                        .shrink(); // here by default width and height is 0
                  },
                ),
                SizedBox(width: getProportionateScreenWidth(20)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
