import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogi/apiServices/CustomerService.dart';
import 'package:gogi/components/default_button.dart';
import 'package:gogi/screens/customers/components/customer_form.dart';
import 'package:gogi/screens/customers/components/customers.dart';
import '../../../models/Customer.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => BodyState();
}

class BodyState extends State<Body> {
  CustomerService customerService = CustomerService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: customerService.getCustomer(),
                builder: (context, AsyncSnapshot<List<Customer>> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('ERROR: ${snapshot.error.toString()}'),
                    );
                  } else if (snapshot.hasData) {
                    return Customers(customers: snapshot.data!);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
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
                                insetPadding: EdgeInsets.all(10),
                                scrollable: true,
                                content: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: CustomerForm(action: 'add')),
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
      ),
    );
  }
}
