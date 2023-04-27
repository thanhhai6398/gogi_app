import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../format.dart';
import '../../../models/Customer.dart';
import '../../../size_config.dart';
import '../../customers/customers_screen.dart';

class CustomerInfor extends StatelessWidget {
  Customer customer;

  CustomerInfor({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: const EdgeInsets.all(3),
        color: Colors.white,
        child: IntrinsicHeight(
            child: SizedBox(
                child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, CustomersScreen.routeName),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                alignment: Alignment.topLeft,
                child: SvgPicture.asset(
                  "assets/icons/Address.svg",
                  color: kPrimaryColor,
                  width: 22,
                ),
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Column(children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Địa chỉ giao hàng",
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "${customer.name} | ${customer.phone}",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        totTitle(customer.address),
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                        maxLines: 4,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(5))
                  ]),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, CustomersScreen.routeName),
                    child: const Icon(Icons.arrow_right)),
              ),
            ],
          ),
        ))));
  }
}
