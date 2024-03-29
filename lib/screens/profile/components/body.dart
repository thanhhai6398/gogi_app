import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogi/SharedPref.dart';
import 'package:gogi/screens/customers/customers_screen.dart';
import 'package:gogi/screens/forgot_password/forgot_password_screen.dart';
import 'package:gogi/screens/splash/splash_screen.dart';
import 'package:gogi/screens/voucher/voucher_screen.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../providers/CartProvider.dart';
import '../../../size_config.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String username = '';
  SharedPref pref = SharedPref();

  _BodyState() {
    pref.read("username").then((value) => setState(() {
          username = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.topCenter,
            child: Text(
              "Xin chào, $username",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 30),
          ProfileMenu(
            text: "Mã giảm giá",
            icon: "assets/icons/Cash.svg",
            press: ()
            {
              Navigator.pushNamed(context, VoucherScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Sổ địa chỉ",
            icon: "assets/icons/Address.svg",
            press: ()
            {
              Navigator.pushNamed(context, CustomersScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Quên mật khẩu",
            icon: "assets/icons/Settings.svg",
            press: () {
              Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Đăng xuất",
            icon: "assets/icons/Log out.svg",
            press: () {
              alertDialogLogout(context);
            },
          ),
        ],
      ),
    );
  }
}

alertDialogLogout(BuildContext context) {
  //final cart = Provider.of<CartProvider>(context);
  SharedPref sharedPref = SharedPref();
// set up the buttons
  Widget cancelButton = TextButton(
    style: ElevatedButton.styleFrom(primary: Colors.black54),
    child: const Text(
      "Hủy",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white
      ),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    style: ElevatedButton.styleFrom(primary: kPrimaryColor),
    child: const Text(
      "Đăng xuất",
      style: TextStyle(
        fontWeight: FontWeight.w600,
          color: Colors.white
      ),
    ),
    onPressed: () {
      sharedPref.clear();
      //if(cart.getCounter() > 0) {cart.removeAll();}
      Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => SplashScreen()),
        (_) => false,
      );
    },
  );

// set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text(
      "Đăng xuất",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: kPrimaryColor,
      ),
    ),
    content: const Text("Bạn có chắc chắn muốn đăng xuất không?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

// show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
