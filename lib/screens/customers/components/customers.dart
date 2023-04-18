import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogi/format.dart';

import '../../../constants.dart';
import '../../../models/Customer.dart';
import '../../../size_config.dart';

class Customers extends StatelessWidget {
  List<Customer> customers = [];

  Customers({super.key, required this.customers});

  @override
  Widget build(BuildContext context) {
    if (customers.isEmpty) {
      return const Center(
        child: Text(
          "Chưa lưu địa chỉ",
          style: TextStyle(color: Colors.black),
        ),
      );
    } else {
      return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: List.generate(customers.length, (index) {
          return Center(
            child: CustomerCard(customer: customers[index]),
          );
        }),
      );
    }
  }
}

class CustomerCard extends StatelessWidget {
  Customer customer;

  CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/icons/Address.svg",
                color: kPrimaryColor,
                width: 22,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5.0),
                alignment: Alignment.topLeft,
                child: Column(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${customer.name} | ${customer.phone}",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      customer.address,
                      maxLines: 4,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  IsDefault(customer: customer),
                ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {},
                child: const Text(
                  "Sửa",
                  style: TextStyle(color: kPrimaryColor),
                ),
              ),
            ),
          ],
        ));
  }
}

class IsDefault extends StatelessWidget {
  Customer customer;

  IsDefault({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    if (customer.isDefault == true) {
      return Container(
          margin: const EdgeInsets.only(right: 200.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            border: Border.all(color: kPrimaryColor),
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.topLeft,
          child: const Text(
            "Mặc định",
            style: TextStyle(
              fontSize: 12,
              color: kPrimaryColor,
            ),
          ));
    } else {
      return const SizedBox.shrink();
    }
  }
}
