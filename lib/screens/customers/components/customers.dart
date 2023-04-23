import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogi/format.dart';
import 'package:gogi/screens/customers/components/customer_form.dart';

import '../../../apiServices/CustomerService.dart';
import '../../../constants.dart';
import '../../../models/Customer.dart';
import '../../../size_config.dart';
import '../customers_screen.dart';

class Customers extends StatefulWidget {
  List<Customer> customers = [];

  Customers({super.key, required this.customers});

  @override
  State<Customers> createState() => StateCustomers();
}

class StateCustomers extends State<Customers> {
  int selectedIndex = -1;
  int? id;

  @override
  Widget build(BuildContext context) {
    // for (Customer e in widget.customers) {
    //   if (e.isDefault == true) {
    //     int index = widget.customers.indexWhere((item) => item.id == e.id);
    //     selectedIndex = index;
    //   }
    // }
    if (widget.customers.isEmpty) {
      return const Center(
        child: Text(
          "Chưa lưu địa chỉ",
          style: TextStyle(color: Colors.black),
        ),
      );
    } else {
      return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        children: List.generate(widget.customers.length, (index) {
          return Center(
            child: InkWell(
              onTap: () => setState(() =>
                  {selectedIndex = index, id = widget.customers[index].id}),
              child: Container(
                color:
                    (selectedIndex == index) ? Colors.deepOrange : Colors.white,
                child: CustomerCard(customer: widget.customers[index]),
              ),
            ),
          );
        }),
      );
      // ListView(
      //   shrinkWrap: true,
      //   padding: const EdgeInsets.all(10.0),
      //   children: List.generate(widget.customers.length, (index) {
      //     return Center(
      //       child: CustomerCard(customer: widget.customers[index]),
      //     );
      //   }),
      // );
    }
  }
}

class CustomerCard extends StatelessWidget {
  CustomerService customerService = CustomerService();

  Customer customer;

  CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: const EdgeInsets.all(3),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              alignment: Alignment.center,
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
                      totTitle(customer.address),
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                      maxLines: 4,
                    ),
                  ),
                  IsDefault(customer: customer),
                  SizedBox(height: getProportionateScreenHeight(5))
                ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                  onTap: () => {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                insetPadding: const EdgeInsets.only(
                                    right: 10,
                                    left: 180,
                                    top: 250,
                                    bottom: 300),
                                scrollable: true,
                                content: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(children: [
                                    TextButton(
                                      child: const Text(
                                        "Sửa",
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          CustomerFormScreen.routeName,
                                          arguments: CustomerArguments(
                                              customer: customer,
                                              action: 'update'),
                                        );
                                      },
                                    ),
                                    const Divider(
                                      color: Colors.black,
                                      height: 2.5,
                                      thickness: 2,
                                      indent: 0,
                                      endIndent: 0,
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    TextButton(
                                      child: const Text(
                                        "Đặt mặc định",
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      onPressed: () {
                                        customerService
                                            .putCustomerDefault(customer.id)
                                            .then((value) {
                                          if (value == true) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CustomersScreen()));
                                          } else {
                                            return "";
                                          }
                                        });
                                      },
                                    ),
                                  ]),
                                ),
                                actions: [
                                  TextButton(
                                      child: const Text("Đóng"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })
                                ],
                              );
                            })
                      },
                  // Navigator.pushNamed(
                  //   context,
                  //   CustomerFormScreen.routeName,
                  //   arguments: CustomerArguments(
                  //       customer: customer, action: 'update'),
                  // ),
                  child: const Icon(
                    Icons.more_vert,
                    color: kPrimaryColor,
                  )),
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
      return Align(
        alignment: Alignment.bottomLeft,
        child: TextButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(
              side: BorderSide(
                width: 2,
                color: kPrimaryColor,
              ),
            ),
          ),
          child: const Text(
            'Mặc định',
            style: TextStyle(color: kPrimaryColor, fontSize: 13),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}