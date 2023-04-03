import 'package:flutter/material.dart';
import 'package:gogi/components/custom_bottom_nav_bar.dart';
import 'package:gogi/enums.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cá nhân", style: TextStyle(color: Colors.black)),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
