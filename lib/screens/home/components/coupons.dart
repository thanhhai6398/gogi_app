import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../format.dart';
import '../../../models/Voucher.dart';
import '../../../size_config.dart';
import 'section_title.dart';

class Coupons extends StatelessWidget {
  List<Voucher> vouchers = [];

  Coupons({super.key, required this.vouchers});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(10),
                horizontal: getProportionateScreenWidth(20)),
            child: SectionTitle(
              title: "Mã khuyến mãi",
              press: () {},
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  vouchers.length,
                  (index) {
                    return CouponCard(voucher: vouchers[index]);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CouponCard extends StatelessWidget {
  CouponCard({
    Key? key,
    required this.voucher,
  }) : super(key: key);

  Voucher voucher;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 50,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            width: 160,
            height: 200,
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage("assets/images/coupon.jpg"),
                      fit: BoxFit.contain,
                      height: 100,
                      width: 170,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "HSD: ${formatDate(voucher.endDate)}",
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Code: ${voucher.code}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                              ),
                              maxLines: 2,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Khuyến mãi từ đơn ${formatPrice(voucher.minimumOrderValue)}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(13),
                                fontWeight: FontWeight.bold
                              ),
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ) //SizedBox
                ), //Column
          ), //Padding
        ),
        Positioned(
          top: 5,
          left: 5,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.red[700],
              border: Border.all(
                color: Colors.red,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(formatPrice(voucher.maximumDiscountAmount),
                style: const TextStyle(color: Colors.white, fontSize: 13)),
          ),
        ),
      ],
    );
  }
}
