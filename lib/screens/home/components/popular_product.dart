import 'package:flutter/material.dart';
import 'package:gogi/components/product_card.dart';
import 'package:gogi/models/Product.dart';

import '../../../apiServices/AccountService.dart';
import '../../../size_config.dart';

class PopularProducts extends StatefulWidget {
  List<Product> products = [];

  PopularProducts({super.key, required this.products});

  @override
  State<PopularProducts> createState() => PopularProductsState();
}

class PopularProductsState extends State<PopularProducts> {
  AccountService accountService = AccountService();

  List listProductLiked = [];

  @override
  void initState() {
    getProductLiked();
    super.initState();
  }

  getProductLiked() {
    accountService.getProductLiked().then((value) {
      for (var item in value) {
        listProductLiked.add(item.id);
      }
      setState(() {
        listProductLiked = listProductLiked;
      });
    });

  }

  check(int id, List list) {
    if (list.isEmpty) return false;
    return list.where((element) => element == id).isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenWidth(15)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  widget.products.length,
                  (index) {
                    if (widget.products[index].status == true) {
                      return ProductCard(
                        product: widget.products[index],
                        isLike:
                            check(widget.products[index].id, listProductLiked),
                      );
                    }

                    return const SizedBox
                        .shrink(); // here by default width and height is 0
                  },
                ),
                SizedBox(width: getProportionateScreenWidth(20)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
