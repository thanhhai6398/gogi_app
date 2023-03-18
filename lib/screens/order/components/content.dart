import 'package:flutter/material.dart';
import 'package:gogi/screens/order/components/orderCard.dart';

import '../../../constants.dart';
import '../../../models/Order.dart';
import '../../../size_config.dart';

class Content extends StatefulWidget {
  const Content({
    Key? key,
  }) : super(key: key);

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  List<Order> _foundedOrders = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      _foundedOrders = demoOrders;
    });
  }

  // onSearch() {
  //   setState(() {
  //     _foundedOrders = demoOrders.where((order) => order.status.toString().contains(dropdownValue.toString())).toList();
  //   });
  // }

  int? dropdownValue = 4;
  List Status = [
    {
      "id": 0,
      "name": 'Chờ xử lý',
      "status": 'InProgress',
    },
    {
      "id": 1,
      "name": 'Đang giao',
      "status": 'Delivering',
    },
    {
      "id": 2,
      "name": 'Thành công',
      "status": 'Success',
    },
    {
      "id": 3,
      "name": 'Đã hủy',
      "status": 'Canceled',
    },
    {
      "id": 4,
      "name": 'All',
      "status": 'All',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(10.0)),
        InputDecorator(
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
            labelText: 'Choose status',
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
                    _foundedOrders = demoOrders;
                  } else {
                    _foundedOrders = demoOrders
                        .where((order) => order.status
                            .toString()
                            .contains(dropdownValue.toString()))
                        .toList();
                  }
                });
              },
              items: Status.map((item) {
                return DropdownMenuItem<int>(
                  value: item["id"],
                  child: Text(item["name"]),
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Expanded(child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
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
