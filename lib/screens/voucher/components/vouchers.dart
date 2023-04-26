import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogi/format.dart';

import '../../../constants.dart';
import '../../../models/Voucher.dart';
import '../../../size_config.dart';

class Vouchers extends StatefulWidget {
  List<Voucher> vouchers = [];

  Vouchers({super.key, required this.vouchers});

  @override
  State<Vouchers> createState() => StateVouchers();
}

class StateVouchers extends State<Vouchers>{
  int selectedIndex = -1;
  int? id;

  @override
  Widget build(BuildContext context) {
    if (widget.vouchers.isEmpty) {
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
        children: List.generate(widget.vouchers.length, (index) {
          return Center(
            child: InkWell(
              onTap: () => setState(() =>
              {selectedIndex = index, id = widget.vouchers[index].id}),
              child: Container(
                color:
                (selectedIndex == index) ? Colors.deepOrange : Colors.white,
                child: VoucherCard(voucher: widget.vouchers[index]),
              ),
            ),
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
        margin: const EdgeInsets.all(3.0),
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
