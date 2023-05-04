import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogi/screens/home/home_screen.dart';
import '../../SharedPref.dart';
import '../../components/default_button.dart';
import '../../constants.dart';
import '../../size_config.dart';
import '../order/order_screen.dart';
import '../splash/splash_screen.dart';
import './components/body.dart';

class CheckoutScreen extends StatelessWidget {
  static String routeName = "/checkout";

  const CheckoutScreen({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text("Xác nhận đơn hàng", style: TextStyle(color: Colors.black),),
  //     ),
  //     body: Body(),
  //     backgroundColor: Colors.grey[100],
  //     bottomNavigationBar: Bottom(),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    SharedPref sharedPref = SharedPref();
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Trang thanh toán'),
              content: const Text('Bạn muốn thoát khỏi trang thanh toán?'),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: const Text('Hủy'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                  onPressed: () => {
                    sharedPref.remove("customerId"),
                    sharedPref.remove("voucherId"),
                    Navigator.of(context).pop(true),
                  },
                  //return true when click on "Yes"
                  child: const Text('Thoát'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
        onWillPop: showExitPopup, //call function on back button press
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Xác nhận đơn hàng",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Body(),
          backgroundColor: Colors.grey[100],
          bottomNavigationBar: Bottom(),
        ));
  }
}

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: getProportionateScreenWidth(190),
          child: DefaultButton(
            text: "Đặt đơn",
            press: () {
              Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(builder: (context) => OrderScreen()),
                (_) => false,
              );
            },
          ),
        ),
      ),
    );
  }
}
