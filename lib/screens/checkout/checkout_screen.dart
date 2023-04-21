import 'package:flutter/material.dart';
import '../../components/default_button.dart';
import '../../size_config.dart';
import './components/body.dart';

class CheckoutScreen extends StatelessWidget {
  static String routeName = "/checkout";

  const CheckoutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Xác nhận đơn hàng", style: TextStyle(color: Colors.black),),
      ),
      body: Body(),
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: Bottom(),
    );
  }
}
class Bottom extends StatelessWidget{
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
              press: () {},
            ),
          ),
        ),
    );
  }

}