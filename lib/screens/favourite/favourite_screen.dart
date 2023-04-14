import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class FavouriteScreen extends StatelessWidget{
  static String routeName = "/favourite";

  const FavouriteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sản phẩm yêu thích", style: TextStyle(color: Colors.black),),
      ),
      body: Body(),
    );
  }

}