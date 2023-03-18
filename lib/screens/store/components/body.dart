import 'package:flutter/material.dart';
import 'package:gogi/screens/store/components/stores.dart';
import 'package:gogi/screens/store/components/search.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Search(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Expanded(child: Stores())
          ,
        ],
      ),
    );
  }
}