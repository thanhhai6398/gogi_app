import 'package:flutter/material.dart';
import 'package:gogi/size_config.dart';

import '../../constants.dart';
import 'components/body.dart';

class ResetPasswordScreen extends StatelessWidget {
  static String routeName = "/reset_password";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đặt lại mật khẩu"),
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Body(),
    );
  }
}
