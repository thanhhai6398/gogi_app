import 'dart:convert';

class Voucher {
  final int id;
  final String name, code;
  final DateTime startDate, endDate;
  final double value, minimumOrderValue, maximumDiscountAmount;

  Voucher({
    required this.id,
    required this.name,
    required this.code,
    required this.startDate,
    required this.endDate,
    required this.value,
    required this.minimumOrderValue,
    required this.maximumDiscountAmount,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      value: json['value'],
      minimumOrderValue: json['minimumOrderValue'],
      maximumDiscountAmount: json['maximumDiscountAmount'],
    );
  }
}
Voucher parseVoucher(String responseBody) {
  return Voucher.fromJson(jsonDecode(responseBody)["data"]);
}
List<Voucher> parseVouchers(String responseBody) {
  final parsed = jsonDecode(responseBody)["data"].cast<Map<String, dynamic>>();
  return parsed.map<Voucher>((json) => Voucher.fromJson(json)).toList();
}
