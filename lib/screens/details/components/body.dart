import 'package:flutter/material.dart';
import 'package:gogi/components/default_button.dart';
import 'package:gogi/models/Product.dart';
import 'package:gogi/screens/details/components/product_rating.dart';
import 'package:gogi/size_config.dart';

import 'count.dart';
import 'size.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    Size(),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Row(
                      children: [
                        Count(),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.05,
                              right: SizeConfig.screenWidth * 0.05,
                            ),
                            child: DefaultButton(
                              text: "Đặt ngay",
                              press: () {},
                            ),
                          ),
                        )
                      ],
                    ),
                    TopRoundedContainer(
                        color: Colors.white,
                        child: Column(
                          children: [
                          Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 15),
                          child: const Text(
                            "Đánh giá",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ),
                            const SizedBox(
                              height: 10,
                            ),
                            ProductRating(product: product),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
