import 'package:flutter/material.dart';
import 'package:gogi/apiServices/VoucherService.dart';
import 'package:gogi/screens/home/components/section_title.dart';

import '../../../SharedPref.dart';
import '../../../apiServices/AccountService.dart';
import '../../../apiServices/ProductService.dart';
import '../../../models/Product.dart';
import '../../../models/Voucher.dart';
import '../../../size_config.dart';
import 'home_header.dart';
import 'home_banner.dart';
import 'popular_product.dart';
import 'coupons.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}
class _BodyState extends State<Body> {
  ProductService productService = ProductService();
  AccountService accountService = AccountService();
  VoucherService voucherService = VoucherService();
  SharedPref sharedPref = SharedPref();
  bool login = false;
  _BodyState() {
    sharedPref.containsKey("username").then((value) => setState(() {
      login = value;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(5)),
            const BannerHome(),
            (login == true) ? FutureBuilder(
                future: productService.getProductsForYou(),
                builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error...'),
                    );
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return Column(
                        children: [
                          SizedBox(height: getProportionateScreenWidth(20)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(20)),
                            child: SectionTitle(
                                title: " Dành cho bạn",
                                icon: Icons.eco,
                                press: () {}),
                          ),
                          PopularProducts(products: snapshot.data!)
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
            : const SizedBox.shrink(),
            SizedBox(height: getProportionateScreenWidth(20)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: SectionTitle(
                  title: "Best seller", icon: Icons.bolt, press: () {}),
            ),
            FutureBuilder(
                future: productService.getBestSeller(),
                builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error...'),
                    );
                    //return PopularProducts(products: demoProducts);
                  } else if (snapshot.hasData) {
                    return PopularProducts(products: snapshot.data!);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            (login == true) ? FutureBuilder(
                future: voucherService.getVoucher(),
                builder: (context, AsyncSnapshot<List<Voucher>> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error...'),
                    );
                  } else if (snapshot.hasData) {
                    return Coupons(vouchers: snapshot.data!);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
            : const SizedBox.shrink(),
            SizedBox(height: getProportionateScreenWidth(20)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: SectionTitle(
                  title: "Combo siêu HOT",
                  icon: Icons.local_fire_department,
                  press: () {}),
            ),
            FutureBuilder(
                future: productService.getCombo(),
                builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Center(
                      child: Text('An error...'),
                    );
                  } else if (snapshot.hasData) {
                    return PopularProducts(products: snapshot.data!);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
