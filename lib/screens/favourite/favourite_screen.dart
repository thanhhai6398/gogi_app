import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/custom_bottom_nav_bar.dart';
import '../../constants.dart';
import '../../enums.dart';
import 'components/body.dart';

class FavouriteScreen extends StatelessWidget{
  static String routeName = "/favourite";

  const FavouriteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sản phẩm yêu thích"),
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Body(),
      bottomNavigationBar: const CustomBottomNavBar(selectedMenu: MenuState.favorite),
    );
  }

}