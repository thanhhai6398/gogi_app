import 'package:flutter/material.dart';
import 'package:gogi/screens/home/components/section_title.dart';

import '../../../apiServices/AccountService.dart';
import '../../../apiServices/ProductService.dart';
import '../../../models/Product.dart';
import '../../../models/Voucher.dart';
import '../../../size_config.dart';
import 'home_header.dart';
import 'home_banner.dart';
import 'popular_product.dart';
import 'coupons.dart';

class Body extends StatelessWidget {
  ProductService productService = ProductService();
  AccountService accountService = AccountService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            const HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(5)),
            const BannerHome(),
            FutureBuilder(
                future: accountService.getVoucher(),
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
                }),
            SizedBox(height: getProportionateScreenWidth(20)),
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
              child: SectionTitle(title: "Dành cho bạn", press: () {}),
            ),
            FutureBuilder(
                future: productService.getProductsForYou(),
                builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                  if (snapshot.hasError) {
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
            SizedBox(height: getProportionateScreenWidth(20)),
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
              child: SectionTitle(title: "Best seller", press: () {}),
            ),
            FutureBuilder(
                future: productService.getBestSeller(),
                builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                  if (snapshot.hasError) {
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
            SizedBox(height: getProportionateScreenWidth(20)),
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
              child: SectionTitle(title: "Combo siêu HOT", press: () {}),
            ),
            FutureBuilder(
                future: productService.getCombo(),
                builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                  if (snapshot.hasError) {
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
