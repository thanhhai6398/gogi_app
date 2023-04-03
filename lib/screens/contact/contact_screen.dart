import 'package:flutter/material.dart';
import 'components/body.dart';
class ContactScreen extends StatelessWidget {
  static String routeName = "/contact";

  const ContactScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liên hệ", style: TextStyle(color: Colors.black),),
      ),
      body: Body(),
    );
  }

}