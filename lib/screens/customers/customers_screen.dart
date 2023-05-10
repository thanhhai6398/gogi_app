import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'components/body.dart';

class CustomersScreen extends StatelessWidget {
  static String routeName = "/customer";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text("Sổ địa chỉ"),
            backgroundColor: kPrimaryColor,
            automaticallyImplyLeading: false,
          ),
          body: Body(),
        );
  }
}
