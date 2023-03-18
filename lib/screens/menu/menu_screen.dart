import 'package:flutter/material.dart';
import '../../components/custom_bottom_nav_bar.dart';
import '../../enums.dart';
import './components/body.dart';

class MenuScreen extends StatelessWidget {
  static String routeName = "/menu";

  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu", style: TextStyle(color: Colors.black)),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.menu),
    );
  }
}
