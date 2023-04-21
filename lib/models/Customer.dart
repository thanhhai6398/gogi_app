import 'dart:convert';

class Customer {
  final int id;
  final String name, phone, address;
  final int provinceId, districtId;
  final bool isDefault;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.districtId,
    required this.provinceId,
    required this.isDefault,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as int,
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      districtId: json['districtId'],
      provinceId: json['provinceId'],
      isDefault: json['isDefault'],
    );
  }
}

List<Customer> parseCustomers(String responseBody) {
  final parsed = jsonDecode(responseBody)["data"].cast<Map<String, dynamic>>();
  return parsed.map<Customer>((json) => Customer.fromJson(json)).toList();
}

class CustomerReq {
  final String name, phone, address, accountUsername;
  final int provinceId, districtId;
  final bool isDefault;

  CustomerReq({
    required this.name,
    required this.phone,
    required this.address,
    required this.districtId,
    required this.provinceId,
    required this.isDefault,
    required this.accountUsername,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "address": address,
      "provinceId": provinceId,
      "districtId": districtId,
      "isDefault": isDefault,
      "accountUsername": accountUsername,
    };
  }
}


String customerReqToJson(CustomerReq data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
// Customer customerDemo =
// Customer(
//     id: 1,
//     name: "Thu",
//     phone: "0797005740",
//     address: "1332 Kha Vạn Cân",
//     districtId: 79,
//     provinceId: 769,
//     isDefault: false);
