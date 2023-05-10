import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogi/format.dart';
import 'package:gogi/screens/voucher/voucher_screen.dart';
import 'package:provider/provider.dart';

import '../../../SharedPref.dart';
import '../../../constants.dart';
import '../../../models/Voucher.dart';
import '../../../providers/CartProvider.dart';
import '../../../size_config.dart';
import '../../checkout/checkout_screen.dart';

class Vouchers extends StatefulWidget {
  List<Voucher> vouchers = [];

  Vouchers({super.key, required this.vouchers});

  @override
  State<Vouchers> createState() => StateVouchers();
}

class StateVouchers extends State<Vouchers> {
  SharedPref sharedPref = SharedPref();
  int selectedIndex = -1;
  int? id;
  double? value;
  List<Voucher> unavailableVoucher = [], availableVoucher = [];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    for (var item in widget.vouchers) {
      if (item.startDate.isAfter(DateTime.now())) {
        unavailableVoucher.add(item);
      } else {
        if (item.minimumOrderValue <= cart.totalPrice) {
          availableVoucher.add(item);
        } else {
          availableVoucher.add(item);
        }
      }
    }
    if (widget.vouchers.isEmpty) {
      return const Center(
        child: Text(
          "Không có mã giảm giá",
          style: TextStyle(color: Colors.black),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(5)),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(children: const [
              Icon(
                Icons.redeem,
                color: kPrimaryColor,
              ),
              Text(
                " Mã giảm khả dụng",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ]),
          ),
          SizedBox(height: getProportionateScreenHeight(5)),
          Expanded(
            flex: 2,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10.0),
              children: List.generate(availableVoucher.length, (index) {
                return Center(
                  child: InkWell(
                    onTap: () {
                      setState(() => {
                            selectedIndex = index,
                            id = availableVoucher[index].id,
                            value = availableVoucher[index].minimumOrderValue,
                          });
                      sharedPref.saveInt("voucherId", id);

                      (value! <= cart.totalPrice)
                          ? Navigator.of(context).pushAndRemoveUntil(
                              CupertinoPageRoute(
                                  builder: (context) => const CheckoutScreen()),
                              (_) => false,
                            )
                          : Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => VoucherScreen()));
                    },
                    child: Container(
                      color: (selectedIndex == index)
                          ? Colors.deepOrange
                          : Colors.white,
                      child: (availableVoucher[index].minimumOrderValue <=
                              cart.totalPrice)
                          ? VoucherCard(
                              voucher: availableVoucher[index], active: true)
                          : Column(
                              children: [
                                VoucherCard(
                                    voucher: availableVoucher[index],
                                    active: false),
                                Container(
                                  color: Colors.amberAccent[100],
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.info_outline,
                                        color: kPrimaryColor,
                                      ),
                                      Text(
                                          "Chưa đạt giá trị đơn hàng tối thiểu")
                                    ],
                                  ),
                                )
                              ],
                            ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(children: const [
              Icon(
                Icons.access_time,
                color: kPrimaryColor,
              ),
              Text(
                " Mã giảm sắp tới",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ]),
          ),
          SizedBox(height: getProportionateScreenHeight(5)),
          //unavailable
          Expanded(
            flex: 1,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10.0),
              children: List.generate(unavailableVoucher.length, (index) {
                return Center(
                  child: VoucherCard(
                      voucher: unavailableVoucher[index], active: false),
                );
              }),
            ),
          )
        ],
      );
    }
  }
}

class VoucherCard extends StatelessWidget {
  Voucher voucher;
  bool active;

  VoucherCard({super.key, required this.voucher, required this.active});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(width: 1),
            ),
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
                    image: AssetImage("assets/images/voucher.png"),
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
                    (voucher.startDate.isAfter(DateTime.now()))
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Có hiệu lực từ: ${formatDate(voucher.startDate)}",
                              maxLines: 2,
                            ),
                          )
                        : Align(
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
            )),
        (active == false)
            ? Container(
                height: 125,
                margin: const EdgeInsets.all(3.0),
                decoration: ShapeDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              )
            : Container(),
      ],
    );
  }
}
