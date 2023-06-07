import 'package:flutter/material.dart';
import 'package:gogi/constants.dart';

import '../../../size_config.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
    required this.icon,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: kPrimaryColor,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        GestureDetector(
            onTap: press,
            child: Row(
              children: const [
                Text(
                  "Xem thêm",
                  style: TextStyle(color: kPrimaryColor),
                ),
                Icon(Icons.keyboard_arrow_right_sharp, color: kPrimaryColor, size: 20,)
              ],
            ),
        ),
      ],
    );
  }
}
