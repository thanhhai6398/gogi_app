import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:gogi/screens/cart/cart_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../SharedPref.dart';
import '../../../providers/CartProvider.dart';
import '../../../size_config.dart';
import '../../profile/profile_screen.dart';
import '../../sign_in/sign_in_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader({
    Key? key,
  }) : super(key: key);

  SharedPref sharedPref = SharedPref();
  bool login = false;
  @override
  Widget build(BuildContext context) {
    sharedPref.containsKey("username").then((value) => login = value);
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          const SizedBox(
            width: 8,
          ),
          badges.Badge(
            badgeContent: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(
                  value.getCounter().toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            badgeStyle: const badges.BadgeStyle(badgeColor: Color(0xFFE57905),),
            position: badges.BadgePosition.topEnd(top: -5, end: 0),
            child: IconBtnWithCounter(
              svgSrc: "assets/icons/Cart Icon.svg",
              press: () => Navigator.pushNamed(context, CartScreen.routeName),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/User Icon.svg",
            press: () {
              if(login == false) {
                Navigator.pushNamed(context, SignInScreen.routeName);
              }
              else {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              }
            }
          ),
        ],
      ),
    );
  }
}
