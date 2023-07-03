import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import '../../models/Product.dart';
import '../../providers/CartProvider.dart';
import '../cart/cart_screen.dart';
import '../home/components/icon_btn_with_counter.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments args =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      floatingActionButton: badges.Badge(
        badgeContent: Consumer<CartProvider>(
          builder: (context, value, child) {
            return Text(
              value.getCounter().toString(),
              style: const TextStyle(
                  color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold),
            );
          },
        ),
        badgeStyle: const badges.BadgeStyle(badgeColor: Colors.white,),
        position: badges.BadgePosition.topEnd(top: -5, end: 0),
        child: FloatingActionButton(
          heroTag: 'cart',
          backgroundColor: Colors.deepOrangeAccent[200],
          onPressed: () => Navigator.pushNamed(context, CartScreen.routeName),
          child: const Icon(Icons.shopping_cart_sharp),
        ),
      ),
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: args.product.avgPoint),
      ),
      body: Body(product: args.product),
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}
