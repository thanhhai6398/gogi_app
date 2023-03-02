import 'package:flutter/material.dart';
import 'package:gogi/models/Product.dart';

import '../../../components/product_card_menu.dart';

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
