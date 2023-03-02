import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Special for you",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Column(
          children: [
            SpecialOfferCard(
              image: "assets/images/section.jpg",
              category:
                  "Nhà mới Nghệ An toạ lạc tại Lotte Mart (TP. Vinh), \nnằm bên cạnh những con phố sầm uất nhộn nhịp",
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            SpecialOfferCard(
              image: "assets/images/section1.jpg",
              category:
                  "Không gian ấm cúng và hương vị quen thuộc từ Nhà, \nmang đến nhiều cung bậc cảm xúc cho những buổi \nhẹn hò cùng bạn bè.",
            ),
          ],
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
  }) : super(key: key);

  final String category, image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(5)),
      child: SizedBox(
        width: getProportionateScreenWidth(320),
        height: getProportionateScreenWidth(120),
        child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: AssetImage(image),
              height: 200,
              width: 180,
            ),
          ),
          Padding(padding: EdgeInsets.only(right: 5.00)),
          Text("$category")
        ]),
      ),
    );
  }
}
