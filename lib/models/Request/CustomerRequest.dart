import 'dart:convert';

class CustomerRequest {
  final String name, phone, address, accountUsername;
  final int provinceId, districtId;
  final bool isDefault;

  @override
  String toString() {
    return 'CustomerRequest{name: $name, phone: $phone, address: $address, accountUsername: $accountUsername, provinceId: $provinceId, districtId: $districtId, isDefault: $isDefault}';
  }

  CustomerRequest({
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


String customerReqToJson(CustomerRequest data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}