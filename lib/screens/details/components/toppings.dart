import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../format.dart';
import '../../../models/Topping.dart';

class Toppings extends StatefulWidget {
  List<Topping> toppings = [];
  final Function(List<int> selectedToppings, List<Topping> toppingOptions) notifyParent;

  Toppings({super.key, required this.toppings, required this.notifyParent});

  @override
  ToppingsState createState() => ToppingsState();
}

class ToppingsState extends State<Toppings> {
  final List<int> _selectedItems = [];

  void _itemChange(int itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
    widget.notifyParent(_selectedItems, widget.toppings);
  }

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: widget.toppings
          .map((item) => CheckboxListTile(
                value: _selectedItems.contains(item.id),
                title: Row(
                  children: [
                    Text(item.name),
                    Spacer(),
                    Text(
                      formatPrice(item.price),
                    )
                  ],
                ),
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (isChecked) => _itemChange(item.id, isChecked!),
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