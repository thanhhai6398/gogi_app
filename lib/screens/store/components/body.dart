import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gogi/screens/store/components/stores.dart';
import 'package:http/http.dart';

import '../../../apiServices/StoreService.dart';
import '../../../models/Address.dart';
import '../../../models/Store.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => BodyState();
}

class BodyState extends State<Body> {
  StoreService storeService = StoreService();
  List<Store> stores = [];

  //address
  Client client = Client();
  String host = "https://provinces.open-api.vn/api/?depth=2";
  var data;
  List<Province> provinces = [];
  List<District> districts = [];
  int? provinceValue, districtValue;

  @override
  void initState() {
    getProvinces();
    storeService.getAllStore().then((value) {
      setState(() {
        stores = value;
      });
    });
    super.initState();
  }

  Future<void> getProvinces() async {
    final res = await client.get(
      Uri.parse(host),
      headers: {"content-type": "application/json; charset=UTF-8"},
    );
    if (res.statusCode == 200) {
      setState(() {
        data = jsonDecode(utf8.decode(res.bodyBytes));
        provinces = List<Province>.from(data.map((i) {
          return Province.fromJSON(i);
        }));
      });
    } else {
      print("Error during fetching data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Column(
            children: [
              InputDecorator(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 8.0),
                  labelText: 'Chọn',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: provinceValue,
                    hint: const Text("Chọn Tỉnh/TP"),
                    items: provinces.map((p) {
                      return DropdownMenuItem(
                        value: p.code,
                        child: Text(p.name), //value of item
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        provinceValue = value!;
                        districtValue = null;
                      });
                      getDistrictList(value!);
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InputDecorator(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 8.0),
                  labelText: 'Chọn',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: districtValue,
                    hint: const Text("Chọn Quận/ Huyện"),
                    items: districts.map((d) {
                      return DropdownMenuItem(
                        value: d.code,
                        child: Text(d.name), //value of item
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        districtValue = value!;
                      });
                      storeService
                          .getStoreByAddress(provinceValue!, districtValue)
                          .then((value) {
                        setState(() {
                          stores = value;
                        });
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          (stores.isNotEmpty)
              ? Expanded(child: Stores(stores: stores))
              : const Text("Xin lỗi! Gogi chưa có cửa hàng tại đây"),
        ],
      ),
    );
  }

  //address
  getDistrictList(int provinceId) {
    Province province = provinces
        .where((e) => e.code.toString().contains(provinceId.toString()))
        .first;
    setState(() {
      districts = province.districts;
    });
  }
}
