import 'package:flutter/material.dart';

import '../../../models/Category.dart';
import '../../../size_config.dart';

class Categories extends StatelessWidget {
  List<CategoryModel> categoies = [];

  Categories({super.key, required this.categoies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(categoies.length, (index) {
            if (categoies[index].status == true) {
              return CategoryCard(
                category: categoies[index],
                press: () {},
              );
            }
            return const SizedBox.shrink();
          }),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.category,
    required this.press,
  }) : super(key: key);

  final CategoryModel category;
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
              margin: EdgeInsets.only(right: 5.0),
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(100),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(category.name!,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
