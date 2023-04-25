import 'package:flutter/material.dart';
import 'package:gogi/apiServices/AccountService.dart';
import 'package:gogi/apiServices/ProductService.dart';
import 'package:gogi/components/default_button.dart';
import 'package:gogi/models/Product.dart';
import 'package:gogi/screens/details/components/product_rating.dart';
import 'package:gogi/size_config.dart';
import 'package:provider/provider.dart';

import '../../../providers/CartProvider.dart';
import '../../../models/Rate.dart';
import 'count.dart';
import 'size.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';


class Body extends StatefulWidget {
  final Product product;
  Body({Key? key, required this.product}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailState();
}
class _DetailState extends State<Body>{
  AccountService accountService = AccountService();
  ProductService productService = ProductService();
  String _size = 's';
  int _quantity = 1;
  setSize(String size) {
    setState(() {
      _size = size;
    });
    return null;
  }
  setQuantity(int quantity){
    setState(() {
      _quantity = quantity;
    });
  }
  @override
  Widget build(BuildContext context) {
    Product product = widget.product;
    final cart = Provider.of<CartProvider>(context);

    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              FutureBuilder(
                  future: accountService.getProductLiked(),
                  builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error...'),
                      );
                    } else if (snapshot.hasData) {
                      bool isLike = false;
                      List<Product>? listProductLiked = snapshot.data;
                      for (var e in listProductLiked!) {
                        if (e.id == product.id) {
                          isLike = true;
                        }
                      }
                      return ProductDescription(
                        isLike: isLike,
                        product: product,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              // ProductDescription(
              //   isLike: false,
              //   product: product,
              // ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    Size(notifyParent: setSize,),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Row(
                      children: [
                        Count(notifyParent: setQuantity,),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.05,
                              right: SizeConfig.screenWidth * 0.05,
                            ),
                            child: DefaultButton(
                              text: "Đặt hàng",
                              press: () {
                                cart.addToCart(product, _size,_quantity);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    TopRoundedContainer(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(left: 15),
                              child: const Text(
                                "Đánh giá",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FutureBuilder(
                                  future: productService
                                      .getRateByProductId(product.id),
                                  builder: (context,
                                      AsyncSnapshot<List<Rate>> snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text(
                                            'ERROR: ${snapshot.error.toString()}'),
                                      );
                                    } else if (snapshot.hasData) {
                                      return ProductRating(
                                          rates: snapshot.data!);
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
