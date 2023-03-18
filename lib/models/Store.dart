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
}

List<Store> demoStores = [
  Store(
    id:1,
    address: "1332 Kha Van Can",
    district_id: 769,
    province_id: 79,
    name: "GoGi Thu Duc",
  ),
  Store(
    id:2,
    address: "130 Phan Van Tri",
    district_id: 769,
    province_id: 79,
    name: "GoGi Binh Thanh",
  ),
  Store(
    id:3,
    address: "81 Nguyen Thi Minh Khai",
    district_id: 769,
    province_id: 79,
    name: "GoGi Q1",
  ),
  Store(
    id:4,
    address: "130 Kha Van Can",
    district_id: 769,
    province_id: 79,
    name: "GoGi Thu Duc",
  ),
];