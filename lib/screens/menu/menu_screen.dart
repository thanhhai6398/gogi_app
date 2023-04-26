import 'package:flutter/material.dart';
import '../../components/custom_bottom_nav_bar.dart';
import '../../constants.dart';
import '../../enums.dart';
import './components/body.dart';

class MenuScreen extends StatelessWidget {
  static String routeName = "/menu";

  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Arguments agrs =
    ModalRoute.of(context)!.settings.arguments as Arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Body(id: agrs.id),
      bottomNavigationBar: const CustomBottomNavBar(selectedMenu: MenuState.menu),
    );
  }
}
class Arguments {
  late int id;

  Arguments({required this.id});
}
