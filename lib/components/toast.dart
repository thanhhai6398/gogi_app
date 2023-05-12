import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void successToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      // Also possible "TOP" and "CENTER"
      backgroundColor: Colors.deepOrangeAccent,
      textColor: Colors.white);
}

void alertToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      // Also possible "TOP" and "CENTER"
      backgroundColor: Colors.red,
      textColor: Colors.white);
}
