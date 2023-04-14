import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogi/apiServices/AccountService.dart';
import 'package:gogi/screens/favourite/components/favourite_products.dart';

import '../../../models/Product.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  AccountService accountService = AccountService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          Expanded(
            child: FutureBuilder(
                future: accountService.getProductLiked(),
                builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error...'),
                    );
                  } else if (snapshot.hasData) {
                    return FavouriteProducts(products: snapshot.data!);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
