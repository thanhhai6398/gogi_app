import 'package:flutter/material.dart';
import 'package:gogi/constants.dart';
import 'package:gogi/size_config.dart';

import '../../../models/Store.dart';
import 'customer_profile_form.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => StateBody();
}

class StateBody extends State<Body>{
  int? dropdownValue = 1;
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
  InputDecorator buildStoreFormField() {
    return InputDecorator(
      decoration: InputDecoration(
        contentPadding:
        EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
        labelText: 'Cửa hàng',
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          onChanged: (int? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: demoStores.map((store) {
            return DropdownMenuItem<int>(
              value: store.id,
              child: Text(store.name),
            );
          }).toList(),
        ),
      ),
    );
  }
}
