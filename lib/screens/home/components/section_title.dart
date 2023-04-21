import 'package:flutter/material.dart';
import 'package:gogi/constants.dart';

import '../../../size_config.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.bolt,
              color: kPrimaryColor,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                color: Colors.black,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: press,
          child: const Text(
            "Xem thêm",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
