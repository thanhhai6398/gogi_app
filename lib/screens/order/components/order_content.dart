import 'package:flutter/material.dart';
import 'package:gogi/screens/order/components/orderCard.dart';

import '../../../models/Order.dart';

class OrderContent extends StatefulWidget {
  List<Order> orders = [];

  OrderContent({Key? key, required this.orders}) : super(key: key);

  @override
  State<OrderContent> createState() => _OrderContentState();
}

class _OrderContentState extends State<OrderContent>
    with SingleTickerProviderStateMixin {
  List<Order> _foundedOrders = [];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    setState(() {
      _foundedOrders = widget.orders;
      _tabController = TabController(length: 5, vsync: this);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Text("Chở xử lí", style: TextStyle(color: Colors.black)),
            Text("Đang giao", style: TextStyle(color: Colors.black)),
            Text("Thành công", style: TextStyle(color: Colors.black)),
            Text("Đã hủy", style: TextStyle(color: Colors.black)),
            Text("Tất cả", style: TextStyle(color: Colors.black)),
          ],
        ),
        Expanded(child: TabBarView(
          controller: _tabController,
          children: [
            listOrder(0),
            listOrder(1),
            listOrder(2),
            listOrder(3),
            listOrder(4),
          ],
        ))
      ],
    );
  }

  listOrder(int statusId) {
    if (statusId == 4) {
      _foundedOrders = widget.orders;
    } else {
      _foundedOrders = widget.orders
          .where(
              (order) => order.status.toString().contains(statusId.toString()))
          .toList();
    }
    return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        children: List.generate(_foundedOrders.length, (index) {
          return Center(
            child: OrderCard(order: _foundedOrders[index]),
          );
        }),
      );
  }
}
// List<Order> _foundedOrders = [];
//
// @override
// void initState() {
//   super.initState();
//
//   setState(() {
//     _foundedOrders = widget.orders;
//   });
// }
//
// // onSearch() {
// //   setState(() {
// //     _foundedOrders = demoOrders.where((order) => order.status.toString().contains(dropdownValue.toString())).toList();
// //   });
// // }
//
// int? dropdownValue = 4;
//
// @override
// Widget build(BuildContext context) {
//   return Column(
//     children: [
//       Padding(padding: EdgeInsets.all(10), child: InputDecorator(
//         decoration: InputDecoration(
//           contentPadding:
//           EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
//           labelText: 'Chọn',
//           border:
//           OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<int>(
//             value: dropdownValue,
//             icon: const Icon(Icons.arrow_drop_down),
//             iconSize: 24,
//             elevation: 16,
//             onChanged: (int? newValue) {
//               setState(() {
//                 dropdownValue = newValue!;
//                 if (dropdownValue == 4) {
//                   _foundedOrders = widget.orders;
//                 } else {
//                   _foundedOrders = widget.orders
//                       .where((order) => order.status
//                       .toString()
//                       .contains(dropdownValue.toString()))
//                       .toList();
//                 }
//               });
//             },
//             items: orderStatus.map((item) {
//               return DropdownMenuItem<int>(
//                 value: item["id"],
//                 child: Text(item["name"]),
//               );
//             }).toList(),
//           ),
//         ),
//       ))
//       ,
//       Expanded(
//         child: ListView(
//           shrinkWrap: true,
//           padding: const EdgeInsets.all(10.0),
//           children: List.generate(_foundedOrders.length, (index) {
//             return Center(
//               child: OrderCard(order: _foundedOrders[index]),
//             );
//           }),
//         ),
//       )
//     ],
//   );
// }
