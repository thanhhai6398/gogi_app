import 'package:flutter/material.dart';
import '../../components/custom_bottom_nav_bar.dart';
import '../../enums.dart';
import './components/body.dart';

class StoreScreen extends StatelessWidget {
  static String routeName = "/store";

  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Store", style: TextStyle(color: Colors.black),),
      ),
      body: Body(),
    );
  }
}