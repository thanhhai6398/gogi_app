import 'package:flutter/material.dart';

import 'components/body.dart';

class CustomerProfileScreen extends StatelessWidget {
  static String routeName = "/customer_profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đặt hàng', style: TextStyle(color: Colors.black),),
      ),
      body: Body(),
    );
  }
}
