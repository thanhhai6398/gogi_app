import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogi/SharedPref.dart';
import 'package:gogi/screens/splash/splash_screen.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Tài khoản",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Quên mật khẩu",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Đăng xuất",
            icon: "assets/icons/Log out.svg",
            press: () {
              alertDialogLogout(context);
              // sharedPref.clear();
              // Navigator.of(context).pushAndRemoveUntil(
              //   CupertinoPageRoute(builder: (context) => SplashScreen()),
              //   (_) => false,
              // );
            },
          ),
        ],
      ),
    );
  }
}
alertDialogLogout(BuildContext context) {
  SharedPref sharedPref = SharedPref();
// set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Hủy"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Đăng xuất"),
    onPressed: () {
      sharedPref.clear();
      Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => SplashScreen()),
            (_) => false,
      );
    },
  );

// set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Đăng xuất"),
    content:
    const Text("Bạn có chắc chắn muốn đăng xuất không?"),
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


