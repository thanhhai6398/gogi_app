import 'package:gogi/screens/menu/components/categories.dart';
import 'package:gogi/screens/menu/components/products.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          Categories(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Expanded(child: Products())
          ,
        ],
      ),
    );
  }
}
