import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../apiServices/CustomerService.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../models/Customer.dart';
import '../../customers/components/customer_form.dart';
import '../../customers/components/customers.dart';

class dialogCustomer extends StatelessWidget {
  CustomerService customerService = CustomerService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const Center(
          child: Text(
            "Địa chỉ giao hàng",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: FutureBuilder(
              future: customerService.getCustomer(),
              builder: (context, AsyncSnapshot<List<Customer>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('ERROR: ${snapshot.error.toString()}'),
                  );
                } else if (snapshot.hasData) {
                  return Customers(
                    customers: snapshot.data!,
                    screen: 'checkout',
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: DefaultButton(
                text: "Thêm địa chỉ mới",
                press: () => {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              insetPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              scrollable: true,
                              content: AddCustomerForm(),
                              actions: [
                                TextButton(
                                    child: const Text("Đóng"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ],
                            );
                          })
                    }),
          ),
        )
      ],
    );
  }
}
