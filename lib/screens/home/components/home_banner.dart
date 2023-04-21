import 'package:flutter/material.dart';

import '../../../size_config.dart';

class BannerHome extends StatelessWidget {
  const BannerHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenWidth(15),
      ),

      child: const Image(
        image: AssetImage("assets/images/slide.jpg"),
        fit: BoxFit.fill,
      ),
    );
  }
}
