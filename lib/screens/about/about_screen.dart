import 'package:flutter/material.dart';

import 'components/body.dart';

class AboutScreen extends StatelessWidget {
  static String routeName = "/about";

  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giới thiệu", style: TextStyle(color: Colors.black),),
      ),
      body: Body(),
    );
  }

}