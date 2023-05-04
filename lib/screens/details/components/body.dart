import 'package:flutter/material.dart';
import 'package:gogi/apiServices/AccountService.dart';
import 'package:gogi/apiServices/RateService.dart';
import 'package:gogi/components/default_button.dart';
import 'package:gogi/models/Product.dart';
import 'package:gogi/screens/details/components/product_rating.dart';
import 'package:gogi/size_config.dart';
import 'package:gogi/utils/size.dart';
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
  RateService rateService = RateService();
  SIZE _size = SIZE.s;
  int _quantity = 1;
  setSize( size) {
    setState(() {
      _size = size;
    });
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
                color: const Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    Size(notifyParent: setSize,size: _size,),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Row(
                      children: [
                       Count(notifyParent: setQuantity,quantity: _quantity,),
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
                                setState(() {
                                  _quantity = 1;
                                  _size = SIZE.s;
                                });
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
                                  future: rateService
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
