import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogi/models/Customer.dart';
import 'package:gogi/screens/checkout/components/customerInfor.dart';
import 'package:gogi/screens/checkout/components/detailInfor.dart';
import 'package:gogi/screens/checkout/components/listProducts.dart';

import '../../../models/Store.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => StateBody();
}

class StateBody extends State<Body> {
  int? dropdownValue = 1;

  Customer customer = Customer(
      id: 1,
      name: "Thanh Hải",
      phone: '0914276398',
      address:
          '1332 Kha Vạn Cân, phường Linh Trung, Thành phố Thủ Đức, Thành phố Hồ Chí Minh',
      districtId: 77,
      provinceId: 746,
      isDefault: true);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          CustomerInfor(
            customer: customer,
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildStoreFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          ListProducts(),
          SizedBox(height: getProportionateScreenHeight(20)),
          const DetailInfor(),
        ],
      ),
    );
  }

  Padding buildStoreFormField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Cửa hàng gần nhất",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 15),
              ),
            ),
            const SizedBox(height: 5.0,),
            DropdownButtonFormField<int>(
              value: dropdownValue,
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
          ],
        ));
  }
}
