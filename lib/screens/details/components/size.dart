import 'package:flutter/material.dart';
import '../../../size_config.dart';

class Size extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int selectedColor = 3;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Radio(
                    value: 1, groupValue: 'null', onChanged: (index) {}),
                Expanded(
                  child: Text('Nhỏ + 0đ'),
                )
              ],
            ),
            flex: 1,
          ),
          Expanded(
            child: Row(
              children: [
                Radio(
                    value: 1, groupValue: 'null', onChanged: (index) {}),
                Expanded(child: Text('Vừa + 6.000đ'))
              ],
            ),
            flex: 1,
          ),
          Expanded(
            child: Row(
              children: [
                Radio(
                    value: 1, groupValue: 'null', onChanged: (index) {}),
                Expanded(child: Text('Lớn + 10.000đ'))
              ],
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
