import 'package:flutter/material.dart';

import '../../../size_config.dart';

class BannerTitle extends StatelessWidget {
  const BannerTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      width: double.infinity,
      margin: EdgeInsets.all(getProportionateScreenWidth(20)),
      // padding: EdgeInsets.symmetric(
      //   horizontal: getProportionateScreenWidth(20),
      //   vertical: getProportionateScreenWidth(15),
      // ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child:
      Image(
          image: NetworkImage(
              'https://file.hstatic.net/1000075078/file/web_desktop_d158a17fa9e64ead95e49c8772b69284.jpg'),
         ),
    );
  }
}
