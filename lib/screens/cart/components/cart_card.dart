import 'package:flutter/material.dart';
import 'package:gogi/format.dart';

import '../../../constants.dart';
import '../../../models/CartItem.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  final CartItem cartItem;

  const CartCard({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                  decoration: BoxDecoration(
                    //color: const Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(cartItem.image),
                ),
              ),
            ),
            Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        totTitle(cartItem.name),
                        style: const TextStyle(
                            color: Colors.black, fontSize: 16),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Cỡ ${cartItem.size}, ${cartItem
                            .sugar} đường, ${cartItem.iced} đá",
                      ),
                      Text(
                        cartItem.toppings.map((item) => totTitle(item.name))
                            .join((', ')),
                      ),
                      const SizedBox(height: 5),
                      Text.rich(
                        TextSpan(
                          text: formatPrice(cartItem.price),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor),
                          children: [
                            TextSpan(
                                text: " x ${cartItem.quantity?.value}",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyText1),
                          ],
                        ),
                      )
                    ],
                  ),)
            )
          ],
        ));
  }
}
