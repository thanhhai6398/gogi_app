import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogi/format.dart';

import '../../../constants.dart';
import '../../../models/Voucher.dart';
import '../../../size_config.dart';

class Vouchers extends StatelessWidget {
  List<Voucher> vouchers = [];

  Vouchers({super.key, required this.vouchers});

  @override
  Widget build(BuildContext context) {
    if (vouchers.isEmpty) {
      return const Center(
        child: Text(
          "Không có mã giảm giá",
          style: TextStyle(color: Colors.black),
        ),
      );
    } else {
      return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        children: List.generate(vouchers.length, (index) {
          return Center(
            child: VoucherCard(voucher: vouchers[index]),
          );
        }),
      );
    }
  }
}

class VoucherCard extends StatelessWidget {
  Voucher voucher;

  VoucherCard({super.key, required this.voucher});

  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: Colors.deepOrange,
        elevation: 3.0,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: const Image(
                image: AssetImage("assets/images/voucher.jpg"),
                height: 70,
                width: 70,
              ),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.topLeft,
              child: Column(children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    voucher.name,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "HSD: ${formatDate(voucher.endDate)}",
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Giá trị: ${prettify(voucher.value * 100)}%"),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Đơn tối thiểu: ${formatPrice(voucher.minimumOrderValue)}",
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Giảm tối đa: ${formatPrice(voucher.maximumDiscountAmount)}",
                    maxLines: 2,
                  ),
                ),
              ]),
            )),
          ],
        ));
  }
}
