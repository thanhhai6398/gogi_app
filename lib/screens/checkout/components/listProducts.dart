import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogi/models/CartItem.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../format.dart';
import '../../../providers/CartProvider.dart';
import '../../../size_config.dart';

class ListProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Consumer<CartProvider>(
            builder: (BuildContext context, provider, widget) {
          if (provider.cart.isEmpty) {
            return const Center(
                child: Text(
              'Không có gì trong giỏ hàng',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ));
          } else {
            return ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              children: List.generate(provider.cart.length, (index) {
                return Center(
                  child: CartCard(cartItem: provider.cart[index]),
                );
              }),
            );
          }
        }));
  }
}

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(6),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.deepOrange[50],
              ),
              child: Image.network(
                cartItem.image,
                height: 70,
                width: 50,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MergeSemantics(
                    child: Row(
                      children: <Widget>[
                        Flexible(
                            child: Text(
                          totTitle(cartItem.name),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Cỡ ${cartItem.size}, ${cartItem.sugar} đường, ${cartItem.iced} đá",
                  ),
                  Text(
                    cartItem.toppings.map((item) => totTitle(item.name)).join((', ')),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          formatDouble(cartItem.price),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor),
                        ),
                        Text("x${cartItem.quantity?.value}"),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
