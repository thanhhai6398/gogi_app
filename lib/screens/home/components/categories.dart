import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';
import '../../Contact/contact_screen.dart';
import '../../about/about_screen.dart';
import '../../menu/menu_screen.dart';
import '../../store/store_screen.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryCard(
            icon: "assets/icons/Shop Icon.svg",
            text: "Cửa hàng",
            press: () {
              Navigator.pushNamed(context, StoreScreen.routeName);
            },
          ),
          CategoryCard(
            icon: "assets/icons/Menu Icon.svg",
            text: "Menu",
            press: () {
              Navigator.pushNamed(
                context,
                MenuScreen.routeName,
                arguments: Arguments(id: 0),
              );
            },
          ),
          CategoryCard(
            icon: "assets/icons/Gift Icon.svg",
            text: "Giới thiệu",
            press: () {
              Navigator.pushNamed(context, AboutScreen.routeName);
            },
          ),
          CategoryCard(
            icon: "assets/icons/Contact Icon.svg",
            text: "Liên hệ",
            press: () {
              Navigator.pushNamed(context, ContactScreen.routeName);
            },
          ),
        ]
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(80),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(60),
              width: getProportionateScreenWidth(60),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon!),
            ),
            const SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
