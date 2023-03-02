import 'package:flutter/material.dart';
import './components/body.dart';

class MenuScreen extends StatelessWidget {
  static String routeName = "/menu";

  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}