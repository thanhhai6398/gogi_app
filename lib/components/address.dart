import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


class Address extends StatefulWidget {
  @override
  State<Address> createState() => AddressState();

}

class AddressState extends State<Address> {
  Client client = Client();
  String host = "https://provinces.open-api.vn/api/?depth=2";
  var data;
  List<Province> provinces = [];
  List<District> districts = [];
  int provinceId = 0, districtId = 0;
  String provinceName = '', districtName = '';
  int? provinceValue, districtValue;

  @override
  void initState() {
    getProvinces();
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
    return Column(
      children: [
        InputDecorator(
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
            labelText: 'Chọn',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
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
                  provinceId = value;
                  getNameProvince(value);
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
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
            labelText: 'Chọn',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              value: districtId,
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
                  districtId = value;
                  getNameDistrict(value);
                });
              },
            ),
          ),
        )
      ],
    );
  }

  getDistrictList(int provinceId) {
    Province province = provinces
        .where((e) => e.code.toString().contains(provinceId.toString()))
        .first;
    setState(() {
      districts = province.districts;
    });
  }
  getNameProvince(int id) {
    Province province = provinces
        .where((e) => e.code.toString().contains(id.toString()))
        .first;
    setState(() {
      provinceName = province.name;
    });
  }
  getNameDistrict(int id) {
    District district = districts
        .where((e) => e.code.toString().contains(id.toString()))
        .first;
    setState(() {
      districtName = district.name;
    });
  }
}

class District {
  final String name;
  final int code;

  District({required this.name, required this.code});

  factory District.fromJSON(Map<String, dynamic> json) {
    return District(name: json["name"], code: json["code"]);
  }
}

class Province {
  final String name;
  final int code;
  final List<District> districts;

  Province({required this.name, required this.code, required this.districts});

  factory Province.fromJSON(Map<String, dynamic> json) {
    var districtList = json['districts'] as List;
    List<District> districts =
        districtList.map((d) => District.fromJSON(d)).toList();
    return Province(
        name: json["name"], code: json["code"], districts: districts);
  }
}
