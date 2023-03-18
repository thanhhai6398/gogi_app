import 'package:flutter/material.dart';
import 'package:gogi/components/custom_bottom_nav_bar.dart';
import 'package:gogi/enums.dart';

import 'components/body.dart';

class OrderScreen extends StatelessWidget {
  static String routeName = "/order";

  const OrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Receipt", style: TextStyle(color: Colors.black),),
      ),
      body: Body(),
      bottomNavigationBar: const CustomBottomNavBar(selectedMenu: MenuState.receipt),
    );
  }
}