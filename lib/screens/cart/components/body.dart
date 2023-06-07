import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../providers/CartProvider.dart';
import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: Consumer<CartProvider>(
        builder: (BuildContext context, provider, widget) {
          if (provider.cart.isEmpty) {
            return const Center(
                child: Text(
                  'Không có gì trong giỏ hàng',
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ));
          }
          else {
            return ListView.builder(
            itemCount: provider.cart.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Dismissible(
                key: Key(provider.cart[index].id.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() async{
                    await provider.removeFromCart(provider.cart[index].id);
                  });
                },
                background: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Spacer(),
                      SvgPicture.asset("assets/icons/Trash.svg"),
                    ],
                  ),
                ),
                child: CartCard(cartItem: provider.cart[index]),
              ),
            ),
          );
          }
        }
      )
    );
  }
}
