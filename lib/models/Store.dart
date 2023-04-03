import 'package:flutter/material.dart';

class Store {
  final int id;
  final String address;
  final int district_id;
  final int province_id;
  final String name;

  Store({
    required this.id,
    required this.address,
    required this.district_id,
    required this.province_id,
    required this.name,
  });

  // factory Store.fromJson(Map<String, dynamic> json) {
  //   Map<String, dynamic> data = json['data'];
  //   return Store(
  //     id: data['id'] as int,
  //     name: data['storeName'] as String,
  //     address: data['address'] as String,
  //     district_id: data['districtId'] as int,
  //     province_id: data['provinceId'] as int,
  //   );
  // }
  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'] as int,
      name: json['storeName'] as String,
      address: json['address'] as String,
      district_id: json['districtId'] as int,
      province_id: json['provinceId'] as int,
    );
  }
}

List<Store> demoStores = [
  Store(
    id:1,
    address: "1332 Kha Vạn Cân",
    district_id: 769,
    province_id: 79,
    name: "GoGi Thủ Đức",
  ),
  Store(
    id:2,
    address: "130 Phan Văn Trị",
    district_id: 769,
    province_id: 79,
    name: "GoGi Bình Thạnh",
  ),
  Store(
    id:3,
    address: "81 Nguyễn Thị Minh Khai",
    district_id: 769,
    province_id: 79,
    name: "GoGi Quận 1",
  ),
  Store(
    id:4,
    address: "130 Lê Văn Chí",
    district_id: 769,
    province_id: 79,
    name: "GoGi Quận 9",
  ),
];