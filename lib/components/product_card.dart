import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogi/apiServices/AccountService.dart';
import 'package:gogi/format.dart';

import '../constants.dart';
import '../models/Product.dart';
import '../screens/details/details_screen.dart';
import '../size_config.dart';

class ProductCard extends StatefulWidget {
  ProductCard({
    Key? key,
    this.width = 140,
    required this.product,
    required this.isLike
  }) : super(key: key);

  final double width;
  final Product product;
  bool isLike;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  AccountService accountService = AccountService();

  void handleUnlike() {
    accountService.unlike(widget.product.id).then((value) {
      if (value == true) {
        setState(() {
          widget.isLike = false;
        });
      }
    });
  }

  void handleLike() {
    accountService.like(widget.product.id).then((value) {
      if (value == true) {
        setState(() {
          widget.isLike = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
          elevation: 50,
          shadowColor: Colors.black.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              width: getProportionateScreenWidth(widget.width),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  DetailsScreen.routeName,
                  arguments: ProductDetailsArguments(product: widget.product),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Hero(
                                tag: widget.product.id.toString(),
                                child: Image(
                                  image: NetworkImage(widget.product.image),
                                  fit: BoxFit.contain,
                                ),
                              )),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              if (widget.isLike == true) {
                                handleUnlike();
                              } else {
                                handleLike();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(
                                  getProportionateScreenWidth(8)),
                              height: getProportionateScreenWidth(40),
                              width: getProportionateScreenWidth(40),
                              decoration: BoxDecoration(
                                color: widget.isLike
                                    ? kPrimaryColor.withOpacity(0.15)
                                    : kSecondaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/Heart Icon_2.svg",
                                color: widget.isLike
                                    ? const Color(0xFFFF4848)
                                    : const Color(0xFFDBDEE4),
                              ),
                            ),
                          ),
                        ),
                        (widget.product.avgPoint > 0) ? Positioned(
                          top: 10,
                          left: 5,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  widget.product.avgPoint.toString(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SvgPicture.asset("assets/icons/Star Icon.svg"),
                              ],
                            ),
                          ),
                        ) : const SizedBox.shrink(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        totTitle(widget.product.name),
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        formatPrice(widget.product.price),
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
          )),
    );
  }
}