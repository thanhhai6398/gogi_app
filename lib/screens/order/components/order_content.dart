import 'package:flutter/material.dart';
import 'package:gogi/screens/order/components/orderCard.dart';

import '../../../enums.dart';
import '../../../models/Order.dart';
import '../../../size_config.dart';

class OrderContent extends StatefulWidget {
  List<Order> orders = [];

  OrderContent({Key? key, required this.orders}) : super(key: key);

  @override
  State<OrderContent> createState() => _OrderContentState();
}

class _OrderContentState extends State<OrderContent> {
  List<Order> _foundedOrders = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      _foundedOrders = widget.orders;
    });
  }

  // onSearch() {
  //   setState(() {
  //     _foundedOrders = demoOrders.where((order) => order.status.toString().contains(dropdownValue.toString())).toList();
  //   });
  // }

  int? dropdownValue = 4;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(10), child: InputDecorator(
          decoration: InputDecoration(
            contentPadding:
            EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
            labelText: 'Chọn',
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              onChanged: (int? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                  if (dropdownValue == 4) {
                    _foundedOrders = widget.orders;
                  } else {
                    _foundedOrders = widget.orders
                        .where((order) => order.status
                        .toString()
                        .contains(dropdownValue.toString()))
                        .toList();
                  }
                });
              },
              items: orderStatus.map((item) {
                return DropdownMenuItem<int>(
                  value: item["id"],
                  child: Text(item["name"]),
                );
              }).toList(),
            ),
          ),
        ))
        ,
        Expanded(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10.0),
            children: List.generate(_foundedOrders.length, (index) {
              return Center(
                child: OrderCard(order: _foundedOrders[index]),
              );
            }),
          ),
        )
      ],
    );
  }
}
