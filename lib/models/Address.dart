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
