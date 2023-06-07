import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogi/format.dart';
import 'package:gogi/models/Product.dart';

import '../../../apiServices/AccountService.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatefulWidget {
  ProductDescription({
    Key? key,
    required this.isLike,
    required this.product,
  }) : super(key: key);

  bool isLike;
  final Product product;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            totTitle(widget.product.name),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
          ),
          child: Container(
            width: 80,
            height: 30,
            color: kPrimaryColor,
            padding: const EdgeInsets.all(5),
            child: Center(
              child: Text(
                'GIẢM ${formatDouble(widget.product.discount * 100)}%',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
          // TextButton(
          //   onPressed: () {},
          //   style: TextButton.styleFrom(
          //       foregroundColor: Colors.white,
          //       elevation: 2,
          //       backgroundColor: kPrimaryColor),
          //   child: Text(
          //     'GIẢM ${formatDouble(widget.product.discount * 100)}%',
          //     style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          //   ),
          // ),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(20),
              ),
              child: Text(
                formatPrice(
                    widget.product.price / (1 - widget.product.discount)),
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(10),
              ),
              child: Text(
                formatPrice(widget.product.price),
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                if (widget.isLike == true) {
                  handleUnlike();
                } else {
                  handleLike();
                }
              },
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                width: getProportionateScreenWidth(64),
                decoration: BoxDecoration(
                  color: widget.isLike ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/icons/Heart Icon_2.svg",
                  color: widget.isLike
                      ? const Color(0xFFFF4848)
                      : const Color(0xFFDBDEE4),
                  height: getProportionateScreenWidth(16),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            widget.product.description,
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}
