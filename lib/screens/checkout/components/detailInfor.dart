import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogi/apiServices/VoucherService.dart';
import 'package:gogi/constants.dart';
import 'package:gogi/format.dart';
import 'package:gogi/screens/voucher/voucher_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../SharedPref.dart';
import '../../../providers/CartProvider.dart';
import '../../../size_config.dart';
import '../../customers/customers_screen.dart';
import '../checkout_screen.dart';

class DetailInfor extends StatefulWidget {
  int id;

  DetailInfor({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailInfor> createState() => _StateDetailInfor();
}

class _StateDetailInfor extends State<DetailInfor> {
  SharedPref sharedPref = SharedPref();
  VoucherService voucherService = VoucherService();
  final List<String> items = [
    'Trực tiếp',
    'Giao hàng',
  ];
  String? selectedValue;
  double fee = 0;
  String voucherName = '';
  double voucherValue = 0;
  double voucherMax = 0;
  double discount = 0;
  double total = 0;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    if (widget.id != 0) {
      voucherService.getVoucherById(widget.id).then((value) {
        voucherName = value.name;
        voucherValue = value.value;
        voucherMax = value.maximumDiscountAmount;
      });
    }
    (voucherValue * cart.totalPrice > voucherMax)
        ? discount = voucherMax
        : discount = voucherValue * cart.totalPrice;

    total = cart.totalPrice - discount + fee;
    sharedPref.saveDouble("lastTotal", total);

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
                const Icon(
                  Icons.redeem,
                  color: kPrimaryColor,
                ),
                const Text(
                  " Thêm voucher",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, VoucherScreen.routeName),
                  child: (widget.id != 0)
                      ? Row(
                          children: [
                            Text(
                              voucherName,
                              style: const TextStyle(
                                  fontSize: 16, color: kPrimaryColor),
                            ),
                            IconButton(
                              icon: const Icon(Icons.cancel_rounded, size: 22, color: kPrimaryColor),
                              onPressed: () {
                                sharedPref.remove("voucherId");
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => const CheckoutScreen()));
                              },
                            ),
                          ],
                        )
                      : const Text(
                          "Chọn voucher >",
                          style: TextStyle(fontSize: 16),
                        ),
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            Row(
              children: [
                const Text("Thành tiền",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Spacer(),
                Text(
                  formatPrice(cart.getTotalPrice()),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Row(
              children: [
                const Text("Mã khuyến mãi",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Spacer(),
                Text(
                  "-${formatPrice(discount)}",
                  style: const TextStyle(fontSize: 16),
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
                        .map((item) => DropdownMenuItem<String>(
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
                        if (selectedValue == 'Giao hàng') {
                          fee = 20000;
                          sharedPref.saveInt("type", 1);
                        } else {
                          fee = 0;
                          sharedPref.saveInt("type", 0);
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
              children: [
                const Text("Tổng cộng",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Spacer(),
                Text(
                  formatPrice(total),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
