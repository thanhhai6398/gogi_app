import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogi/apiServices/OrderService.dart';
import 'package:gogi/components/toast.dart';
import 'package:gogi/models/CartItem.dart';
import 'package:gogi/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import '../../SharedPref.dart';
import '../../components/default_button.dart';
import '../../constants.dart';
import '../../models/Request/OrderRequest.dart';
import '../../providers/CartProvider.dart';
import '../../size_config.dart';
import '../order/order_screen.dart';
import './components/body.dart';

class CheckoutScreen extends StatelessWidget {
  static String routeName = "/checkout";

  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SharedPref sharedPref = SharedPref();
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Trang thanh toán'),
              content: const Text('Bạn muốn thoát khỏi trang thanh toán?'),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Hủy'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                  onPressed: () => {
                    sharedPref.remove("customerId"),
                    sharedPref.remove("voucherId"),
                    sharedPref.remove("storeId"),
                    sharedPref.remove("lastTotal"),
                    sharedPref.remove("type"),
                    Navigator.pushNamed(context, HomeScreen.routeName)
                  },
                  child: const Text('Thoát'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
        onWillPop: showExitPopup, //call function on back button press
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Xác nhận đơn hàng",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Body(),
          backgroundColor: Colors.grey[100],
          bottomNavigationBar: Bottom(),
        ));
  }
}

class Bottom extends StatefulWidget {
  @override
  State<Bottom> createState() => BottomState();
}

class BottomState extends State<Bottom> {
  SharedPref sharedPref = SharedPref();
  OrderService orderService = OrderService();

  int orderType = 0;
  double total = 0;
  String account_username = '';
  int customer_id = 0;
  int store_id = 0;
  var voucher_id;
  List<CartItem> details = [];

  @override
  void initState() {
    super.initState();
    context
        .read<CartProvider>()
        .getData()
        .then((value) => value.forEach((item) => details.add(item)));
  }

  BottomState() {
    sharedPref.read("username").then((value) => setState(() {
          account_username = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: getProportionateScreenWidth(190),
          child: DefaultButton(
            text: "Đặt đơn",
            press: () {
              readValue();
              showOrderAlertDialog(context, cart);
            },
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK", style: TextStyle(color: kPrimaryColor)),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Thông báo", style: TextStyle(color: kPrimaryColor)),
      content: const Text("Chưa đủ thông tin đặt hàng"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showOrderAlertDialog(BuildContext context, cart) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text(
        "OK",
        style: TextStyle(color: kPrimaryColor),
      ),
      onPressed: () {
        readValue();
        OrderRequest orderReq = OrderRequest(
            customer_id: customer_id,
            store_id: store_id,
            account_username: account_username,
            orderType: orderType,
            total: total,
            details: details,
            voucher_id: voucher_id);
        if (customer_id == 0 || store_id == 0) {
          showAlertDialog(context);
        } else {
          //print(orderReq);
          orderService.postOrder(orderReq).then((value) {
            if (value == true) {
              sharedPref.remove("customerId");
              sharedPref.remove("voucherId");
              sharedPref.remove("storeId");
              sharedPref.remove("lastTotal");
              sharedPref.remove("type");
              cart.removeAll();
              successToast("Đặt hàng thành công");
              Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(builder: (context) => const OrderScreen()),
                (_) => false,
              );
            } else {
              print("FALSE");
            }
          });
          Navigator.pop(context);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Đặt hàng", style: TextStyle(color: kPrimaryColor)),
      content: const Text("Xác nhận đặt hàng"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  readValue() {
    sharedPref.containsKey("type").then((value) {
      if (value == true) {
        sharedPref.readInt("type").then((value) => setState(() {
              orderType = value!;
            }));
      }
    });

    sharedPref.readDouble("lastTotal").then((value) => setState(() {
          total = value!;
        }));

    sharedPref.containsKey("customerId").then((value) {
      if (value == true) {
        sharedPref.readInt("customerId").then((value) => setState(() {
          customer_id = value!;
        }));
      }
    });

    sharedPref.readInt("voucherId").then((value) => setState(() {
          voucher_id = value;
        }));
    sharedPref.containsKey("storeId").then((value) => (value == true)
        ? sharedPref.readInt("storeId").then((value) => setState(() {
              store_id = value!;
            }))
        : setState(() {
            store_id = 0;
          }));
  }
}
