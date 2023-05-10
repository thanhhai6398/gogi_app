import 'package:flutter/material.dart';
import 'package:gogi/format.dart';
import '../../../constants.dart';
import '../../../models/Customer.dart';
import '../../../size_config.dart';

class CustomerInf extends StatelessWidget {
  Customer customer;

  CustomerInf({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5),
          child: Column(
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.add_location,
                    color: kPrimaryColor,
                  ),
                  Text(
                    "Địa chỉ nhận hàng",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(children: [
                  Row(children: [
                    const Text("Tên:"),
                    const Spacer(),
                    Text(customer.name),
                  ]),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(children: [
                    const Text("Số điện thoại:"),
                    const Spacer(),
                    Text(customer.phone),
                  ]),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(children: [
                    const Text("Địa chỉ:"),
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: Text(
                        totTitle(customer.address),
                        maxLines: 3,
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ])
                ]),
              ),
            ],
          ),
        ));
  }
}
