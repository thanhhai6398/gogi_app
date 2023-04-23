import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../format.dart';
import '../../../models/Cart.dart';
import '../../../size_config.dart';

class ListProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      children: List.generate(demoCarts.length, (index) {
        return Center(
          child: CartCard(cart: demoCarts[index]),
        );
      }),
    );
  }
}

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.deepOrange[50],
            ),
            child: Image.asset(cart.product.image, height: 70, width: 50, fit: BoxFit.contain,),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text("x${cart.numOfItem} ",
                  style: Theme.of(context).textTheme.bodyText1,),
                Text(totTitle(cart.product.name),
                  style: const TextStyle(color: Colors.black, fontSize: 16), maxLines: 2,)
              ],),
              const SizedBox(height: 10),
              Text(
                "Size: ${cart.size}",
              ),
            ],
          ),
          Spacer(),
          Container(
            alignment: Alignment.center,
            child: Text(
              formatDouble(cart.product.price),
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: kPrimaryColor),
            ),
          )
        ],
      ),
    );
  }
}
