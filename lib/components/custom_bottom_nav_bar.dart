import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gogi/screens/order/order_screen.dart';

import '../SharedPref.dart';
import '../constants.dart';
import '../enums.dart';
import '../screens/favourite/favourite_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/menu/menu_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/sign_in/sign_in_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  SharedPref sharedPref = SharedPref();
  bool login = false;
  @override
  Widget build(BuildContext context) {
    sharedPref.containsKey("username").then((value) => login = value);
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, HomeScreen.routeName),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Menu Icon2.svg",
                  width: 22,
                  height: 22,
                  color: MenuState.menu == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () => Navigator.pushNamed(
                  context,
                  MenuScreen.routeName,
                  arguments: Arguments(id: 0),
                ),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Bill Icon2.svg",
                  color: MenuState.order == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () {
                  if(login == false) {
                    Navigator.pushNamed(context, SignInScreen.routeName);
                  }
                  else {
                    Navigator.pushNamed(context, OrderScreen.routeName);
                  }
                }
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Heart Icon.svg",
                  color: MenuState.favorite == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () {
                  if (login == false) {
                    Navigator.pushNamed(context, SignInScreen.routeName);
                  }
                  else {
                    Navigator.pushNamed(context, FavouriteScreen.routeName);
                  }
                }
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () {
                  if(login == false) {
                    Navigator.pushNamed(context, SignInScreen.routeName);
                  }
                  else {
                    Navigator.pushNamed(context, ProfileScreen.routeName);
                  }
                }
              ),
            ],
          )),
    );
  }
}
