import 'package:flutter/material.dart';
import './components/body.dart';

class StoreScreen extends StatelessWidget {
  static String routeName = "/store";

  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cửa hàng", style: TextStyle(color: Colors.black),),
      ),
      body: Body(),
    );
  }
}