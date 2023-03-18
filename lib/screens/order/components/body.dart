import 'package:flutter/material.dart';
import 'package:gogi/screens/order/components/content.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Content(),
    );
  }
}
