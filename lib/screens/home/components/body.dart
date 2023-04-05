import 'package:flutter/material.dart';

import '../../../apiServices/ProductService.dart';
import '../../../models/Product.dart';
import '../../../size_config.dart';
import 'categories.dart';
import 'home_header.dart';
import 'banner_title.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  ProductService productService = ProductService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            BannerTitle(),
            Categories(),
            FutureBuilder(
                future: productService.getProductPopular(),
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
            SizedBox(height: getProportionateScreenWidth(30)),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
