import 'package:flutter/material.dart';

import '../../../models/Category.dart';
import '../../../size_config.dart';
import '../menu_screen.dart';

class Categories extends StatelessWidget {
  List<CategoryModel> categoies = [];
  int id;

  Categories({super.key, required this.categoies, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(categoies.length, (index) {
            if (categoies[index].status == true) {
              return CategoryCard(
                id: id,
                category: categoies[index],
                press: () => Navigator.pushReplacementNamed(
                  context,
                  MenuScreen.routeName,
                  arguments: Arguments(id: categoies[index].id),
                ),
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
    required this.id,
  }) : super(key: key);

  final CategoryModel category;
  final GestureTapCallback press;
  final int id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: SizeConfig.defaultSize,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5.0),
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                  color: id == category.id ? Colors.deepOrangeAccent : const Color(0xFFFFECDF),
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
