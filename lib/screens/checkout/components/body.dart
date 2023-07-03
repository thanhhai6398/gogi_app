import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogi/apiServices/CustomerService.dart';
import 'package:gogi/apiServices/StoreService.dart';
import 'package:gogi/models/Customer.dart';
import 'package:gogi/screens/checkout/components/customerInfor.dart';
import 'package:gogi/screens/checkout/components/detailInfor.dart';
import 'package:gogi/screens/checkout/components/listProducts.dart';
import '../../../SharedPref.dart';
import '../../../components/default_button.dart';
import '../../../models/Store.dart';
import '../../../size_config.dart';
import '../../customers/components/customer_form.dart';
import '../../customers/components/customers.dart';
import 'dialogCustomer.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => BodyState();
}

class BodyState extends State<Body> {
  SharedPref sharedPref = SharedPref();
  CustomerService customerService = CustomerService();
  StoreService storeService = StoreService();
  List<Store> stores = [];
  int? dropdownValue;

  bool customer = false;
  int customerId = 0;
  int voucherId = 0;

  // getValue() {
  //   sharedPref.containsKey("customerId").then((value) {
  //     setState(() {
  //       customer = value;
  //     });
  //   });
  //
  //   sharedPref.readInt("customerId").then((value) => setState(() {
  //         customerId = value!;
  //       }));
  //
  //   sharedPref.containsKey("voucherId").then((value) {
  //     if (value == true) {
  //       sharedPref.readInt("voucherId").then((value) => setState(() {
  //             voucherId = value!;
  //           }));
  //     }
  //   });
  // }

  // getCustomerDefault() async {
  //   await customerService.getCustomerDefault().then((value) {
  //     storeService
  //         .getStoreByAddress(value.provinceId, value.districtId)
  //         .then((value) {
  //       setState(() {
  //         stores = value;
  //       });
  //     });
  //     sharedPref.saveInt("customerId", value.id);
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getCustomerDefault();
  //   sharedPref.readInt("customerId").then((value) => setState(() {
  //     customerId = value!;
  //   }));
  // }

  BodyState() {
    // sharedPref.containsKey("customerId").then((value) => setState(() {
    //   customer = value;
    // }));
    sharedPref.readInt("customerId").then((value) {
      if (value != null) {
        setState(() {
          customerId = value;
        });
      }
    });

    sharedPref.readInt("voucherId").then((value) {
      if (value != null) {
        setState(() {
          voucherId = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          (customerId == 0)
              ? Card(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      child: GestureDetector(
                        onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                insetPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                elevation: 10,
                                child: dialogCustomer(),
                              );
                            }),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    alignment: Alignment.center,
                                    child:
                                        const Text("+ Thêm địa chỉ nhận hàng")),
                              ),
                              const Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.arrow_right),
                              ),
                            ]),
                      ),
                    ),
                  ),
                )
              // FutureBuilder(
              //         future: customerService.getCustomerDefault(),
              //         builder: (context, AsyncSnapshot<Customer> snapshot) {
              //           if (snapshot.hasError) {
              //
              //           } else if (snapshot.hasData && !snapshot.hasError) {
              //             storeService
              //                 .getStoreByAddress(snapshot.data!.provinceId,
              //                     snapshot.data?.districtId)
              //                 .then((value) {
              //               setState(() {
              //                 stores = value;
              //               });
              //               sharedPref.saveInt("customerId", snapshot.data?.id);
              //               //sharedPref.saveInt("storeId", dropdownValue);
              //             });
              //             return CustomerInfor(customer: snapshot.data!);
              //           } else {
              //             return const Center(
              //               child: CircularProgressIndicator(),
              //             );
              //           }
              //         })
              : FutureBuilder(
                  future: customerService.getCustomerById(customerId),
                  builder: (context, AsyncSnapshot<Customer> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error...'),
                      );
                    } else if (snapshot.hasData && !snapshot.hasError) {
                      storeService
                          .getStoreByAddress(snapshot.data!.provinceId,
                              snapshot.data?.districtId)
                          .then((value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            stores = value;
                          });
                        }
                      });
                      // sharedPref.saveInt("customerId", snapshot.data?.id);
                      return CustomerInfor(customer: snapshot.data!);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildStoreFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          ListProducts(),
          SizedBox(height: getProportionateScreenHeight(20)),
          DetailInfor(
            id: voucherId,
          ),
        ],
      ),
    );
  }

  Padding buildStoreFormField() {
    if (stores.isEmpty) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: const [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Cửa hàng gần nhất",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 15),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Không có cửa hàng tại địa chỉ này",
                  style: TextStyle(fontSize: 15),
                ),
              )
            ],
          ));
    } else {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Cửa hàng gần nhất",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              DropdownButtonFormField<int>(
                value: dropdownValue,
                hint: const Text("Chọn cửa hàng"),
                onChanged: (int? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                  sharedPref.saveInt("storeId", value);
                },
                items: stores.map((store) {
                  return DropdownMenuItem<int>(
                    value: store.id,
                    child: Text(store.name),
                  );
                }).toList(),
              ),
            ],
          ));
    }
  }
}


