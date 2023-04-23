import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogi/constants.dart';
import 'package:gogi/format.dart';
import 'package:gogi/screens/voucher/voucher_screen.dart';

import '../../../size_config.dart';
import '../../customers/customers_screen.dart';

class DetailInfor extends StatefulWidget {
  const DetailInfor({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailInfor> createState() => _StateDetailInfor();
}

class _StateDetailInfor extends State<DetailInfor> {
  final List<String> items = [
    'Trực tiếp',
    'Giao hàng',
  ];
  String? selectedValue;
  double fee = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(10),
        horizontal: getProportionateScreenWidth(10),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.redeem, color: kPrimaryColor,),
                const Text(" Thêm voucher", style: TextStyle(fontWeight: FontWeight.w600),),
                Spacer(),
                GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, VoucherScreen.routeName),
                    child: const Text(
                      "Chọn voucher >",
                      style: TextStyle(fontSize: 16),
                    ),
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            Row(
              children:[
                const Text("Thành tiền", style: TextStyle(fontWeight: FontWeight.w600)),
                Spacer(),
                Text(
                  formatPrice(90000.0),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Row(
              children:[
                const Text("Mã khuyến mãi", style: TextStyle(fontWeight: FontWeight.w600)),
                Spacer(),
                Text(
                  "-${formatPrice(0.0)}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Row(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: const Text(
                      'Phương thức',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    items: items
                        .map((item) =>
                        DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                        if(selectedValue == 'Giao hàng'){
                          fee = 20000;
                        } else {
                          fee = 0;
                        }
                      });

                    },
                  ),
                ),
                Spacer(),
                Text(
                  formatPrice(fee),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Row(
              children:[
                const Text("Tổng cộng", style: TextStyle(fontWeight: FontWeight.w600)),
                Spacer(),
                Text(
                  formatPrice(90000),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}