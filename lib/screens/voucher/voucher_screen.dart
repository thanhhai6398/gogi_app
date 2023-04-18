import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class VoucherScreen extends StatelessWidget {
  static String routeName = "/voucher";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mã khuyến mãi",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Body(),
    );
  }
}
