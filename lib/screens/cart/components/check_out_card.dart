import 'package:gogi/format.dart';
import 'package:gogi/screens/checkout/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../SharedPref.dart';
import '../../../components/default_button.dart';
import '../../../providers/CartProvider.dart';
import '../../../size_config.dart';
import '../../sign_in/sign_in_screen.dart';

class CheckoutCard extends StatelessWidget {
  CheckoutCard({
    Key? key,
  }) : super(key: key);

  SharedPref sharedPref = SharedPref();
  bool login = false;
  @override
  Widget build(BuildContext context) {
    sharedPref.containsKey("username").then((value) => login = value);
    final cart = Provider.of<CartProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Tổng cộng:\n",
                    children: [
                      TextSpan(
                        text: formatCurrency(cart.getTotalPrice()),
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(170),
                  child: DefaultButton(
                    text: "Tiếp tục",
                    press: () {
                      if(login == false) {
                          Navigator.pushNamed(context, SignInScreen.routeName);
                        }
                        else {
                        Navigator.pushNamed(context, CheckoutScreen.routeName);
                        }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


