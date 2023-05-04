import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogi/screens/voucher/components/vouchers.dart';

import '../../../apiServices/VoucherService.dart';
import '../../../constants.dart';
import '../../../models/Voucher.dart';
import '../../../size_config.dart';

VoucherService voucherService = VoucherService();

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController controller = TextEditingController();
  String kw = '';

  _BodyState() {
    kw = 'all';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
              width: SizeConfig.screenWidth * 0.9,
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenWidth(9)),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "Nhập mã code",
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        print(controller.text);
                        onSearchTextChanged(controller.text);
                      }),
                ),
              )),
          ListVoucher(kw: kw),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    if (text.isEmpty) {
      setState(() {});
      return;
    } else {
      kw = text;
    }
    setState(() {});
  }
}

class ListVoucher extends StatelessWidget {
  String kw;

  ListVoucher({super.key, required this.kw});

  @override
  Widget build(BuildContext context) {
    if (kw == 'all') {
      return Expanded(
        child: FutureBuilder(
            future: voucherService.getVoucher(),
            builder: (context, AsyncSnapshot<List<Voucher>> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error...'),
                );
              } else if (snapshot.hasData) {
                return Vouchers(vouchers: snapshot.data!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      );
    } else {
      return FutureBuilder(
          future: voucherService.searchVoucher(kw),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Không có mã giảm giá"),
              );
            } else if (snapshot.hasData) {
              return VoucherCard(voucher: snapshot.data);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    }
  }
}
