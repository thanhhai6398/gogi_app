import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/Product.dart';
import '../screens/details/details_screen.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: ProductDetailsArguments(product: product),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 2/3,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Hero(
                      tag: product.id.toString(),
                      child: Image(
                        image: NetworkImage(product.image),
                        fit: BoxFit.fill,
                      ),
                    )),
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  product.name,
                  style: TextStyle(color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "${product.price}đ",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
