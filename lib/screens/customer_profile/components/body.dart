import 'package:flutter/material.dart';
import 'package:gogi/constants.dart';
import 'package:gogi/size_config.dart';

import 'customer_profile_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(10)),
                Text("Thông tin", style: headingStyle),
                const Text(
                  "Điền đầy đủ thông tin để đặt hàng",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                CustomerProfileForm(),
                SizedBox(height: getProportionateScreenHeight(30)),
                Text(
                  "Chọn 'Tiếp tục' để xác nhận \nvới các thông tin trên",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
