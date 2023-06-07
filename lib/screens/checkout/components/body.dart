import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogi/apiServices/CustomerService.dart';
import 'package:gogi/apiServices/StoreService.dart';
import 'package:gogi/models/Customer.dart';
import 'package:gogi/screens/checkout/components/customerInfor.dart';
import 'package:gogi/screens/checkout/components/detailInfor.dart';
import 'package:gogi/screens/checkout/components/listProducts.dart';

import '../../../SharedPref.dart';
import '../../../models/Store.dart';
import '../../../size_config.dart';
import '../../customers/customers_screen.dart';

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
  bool voucher = false;
  int voucherId = 0;
  BodyState() {
    sharedPref.containsKey("customerId").then((value) => setState(() {
      customer = value;
    }));
    sharedPref.readInt("customerId").then((value) => setState((){
      customerId = value!;
    }));

    sharedPref.containsKey("voucherId").then((value) => setState(() {
      voucher = value;
    }));
    sharedPref.readInt("voucherId").then((value) => setState((){
      voucherId = value!;
    }));
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          (customer == false) ?
          FutureBuilder(
              future: customerService.getCustomerDefault(),
              builder: (context, AsyncSnapshot<Customer> snapshot) {
                if (snapshot.hasError) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, CustomersScreen.routeName),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      alignment: Alignment.center,
                                      child: const Text(
                                          "+Thêm địa chỉ nhận hàng")),
                                ),
                                const Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.arrow_right),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasData) {
                  storeService
                      .getStoreByAddress(
                      snapshot.data!.provinceId, snapshot.data?.districtId)
                      .then((value) {
                    setState(() {
                      stores = value;
                    });
                    sharedPref.saveInt("customerId", snapshot.data?.id);
                    sharedPref.saveInt("storeId", dropdownValue);
                  });
                  return CustomerInfor(customer: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }) : FutureBuilder(
              future: customerService.getCustomerById(customerId),
              builder: (context, AsyncSnapshot<Customer> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error...'),
                  );
                } else if (snapshot.hasData) {
                  storeService
                      .getStoreByAddress(
                      snapshot.data!.provinceId, snapshot.data?.districtId)
                      .then((value) {
                    setState(() {
                      stores = value;
                    });
                  });
                  sharedPref.saveInt("customerId", snapshot.data?.id);
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
          DetailInfor(id: voucherId,),
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
          padding: EdgeInsets.symmetric(horizontal: 5),
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
