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
  State<Body> createState() => StateBody();
}

class StateBody extends State<Body> {
  SharedPref sharedPref = SharedPref();
  CustomerService customerService = CustomerService();
  StoreService storeService = StoreService();
  List<Store> stores = [];
  int? dropdownValue;

  bool customer = false;
  int customerId = 0;
  bool voucher = false;
  int voucherId = 0;
  StateBody() {
    sharedPref.containsKey("customerId").then((value) => setState(() {
      customer = value;
    }));
    sharedPref.readId("customerId").then((value) => setState((){
      customerId = value!;
    }));

    sharedPref.containsKey("voucherId").then((value) => setState(() {
      voucher = value;
    }));
    sharedPref.readId("voucherId").then((value) => setState((){
      voucherId = value!;
    }));
  }

  // Customer customer = Customer(
  //     id: 1,
  //     name: "Thanh Hải",
  //     phone: '0914276398',
  //     address:
  //         '1332 Kha Vạn Cân, phường Linh Trung, Thành phố Thủ Đức, Thành phố Hồ Chí Minh',
  //     districtId: 77,
  //     provinceId: 746,
  //     isDefault: true);

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
                      dropdownValue = stores.first.id;
                    });
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
                      dropdownValue = stores.first.id;
                    });
                  });
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

  // setStore(Customer customer) {
  //   storeService
  //       .getStoreByAddress(
  //       customer.provinceId, customer.districtId)
  //       .then((value) {
  //     setState(() {
  //       stores = value;
  //       dropdownValue = stores.first.id;
  //     });
  //   });
  // }
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
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 15),
                ),
              ),
              SizedBox(
                height: 5.0,
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
          padding: EdgeInsets.symmetric(horizontal: 10),
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
                onChanged: (int? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                  sharedPref.saveId("storeId", dropdownValue);
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
