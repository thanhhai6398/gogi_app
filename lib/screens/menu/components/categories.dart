import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Shop Icon.svg", "text": "Tra sua"},
      {"icon": "assets/icons/Menu Icon.svg", "text": "Sinh to"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "Intro"},
      {"icon": "assets/icons/Contact Icon.svg", "text": "Contact"},
      {"icon": "assets/icons/Discover.svg", "text": "Recruitment"},
      {"icon": "assets/icons/Shop Icon.svg", "text": "Store"},
      {"icon": "assets/icons/Menu Icon.svg", "text": "Menu"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "Intro"},
      {"icon": "assets/icons/Contact Icon.svg", "text": "Contact"},
      {"icon": "assets/icons/Discover.svg", "text": "Recruitment"},
    ];
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text("Menu"),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                categories.length,
                    (index) => CategoryCard(
                  icon: categories[index]["icon"],
                  text: categories[index]["text"],
                  press: () {},
                ),
              ),
          ),
        ),
      ],
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
        width: SizeConfig.defaultSize,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 5),
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(100),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(text!, textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
