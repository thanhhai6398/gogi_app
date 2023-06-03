import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../format.dart';
import '../../../models/Topping.dart';

class Toppings extends StatefulWidget {
  List<Topping> toppings = [];

  Toppings({super.key, required this.toppings});

  @override
  ToppingsState createState() => ToppingsState();
}

class ToppingsState extends State<Toppings> {
  final List<String> _selectedItems = [];

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: widget.toppings
          .map((item) => CheckboxListTile(
                value: _selectedItems.contains(item.name),
                title: Row(
                  children: [
                    Text(item.name),
                    Spacer(),
                    Text(
                      "${formatDouble(item.price)}đ",
                    )
                  ],
                ),
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (isChecked) => _itemChange(item.name, isChecked!),
              ))
          .toList(),
    );
  }
}
// onChanged: (bool value) {
// if (value) {
// if (!_tempSelectedCities.contains(cityName)) {
// setState(() {
// _tempSelectedCities.add(cityName);
// });
// }
// } else {
// if (_tempSelectedCities.contains(cityName)) {
// setState(() {
// _tempSelectedCities.removeWhere(
// (String city) => city == cityName);
// });
// }
// }