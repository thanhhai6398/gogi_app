import 'package:flutter/material.dart';
import 'package:gogi/apiServices/AccountService.dart';
import 'package:gogi/apiServices/RateService.dart';
import 'package:gogi/apiServices/ToppingService.dart';
import 'package:gogi/components/default_button.dart';
import 'package:gogi/components/toast.dart';
import 'package:gogi/models/CartItem.dart';
import 'package:gogi/models/Product.dart';
import 'package:gogi/models/Topping.dart';
import 'package:gogi/screens/details/components/product_rating.dart';
import 'package:gogi/screens/details/components/sugar.dart';
import 'package:gogi/screens/details/components/toppings.dart';
import 'package:gogi/size_config.dart';
import 'package:provider/provider.dart';

import '../../../enums.dart';
import '../../../providers/CartProvider.dart';
import '../../../models/Rating.dart';
import 'count.dart';
import 'iced.dart';
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

class _DetailState extends State<Body> {
  AccountService accountService = AccountService();
  RateService rateService = RateService();
  ToppingService toppingService = ToppingService();
  SIZE _size = SIZE.s;
  String _iced = '100%', _sugar = '100%';
  int _quantity = 1;
  List<Topping> toppings = [];

  setSize(size) {
    setState(() {
      _size = size;
    });
  }

  setIced(String iced) {
    setState(() {
      _iced = iced;
    });
  }

  setSugar(String sugar) {
    setState(() {
      _sugar = sugar;
    });
  }

  setQuantity(int quantity) {
    setState(() {
      _quantity = quantity;
    });
  }

  setToppings(List<int> selectedToppings, List<Topping> toppingOptions) {
    List<Topping> selected = [];
    for (final id in selectedToppings) {
      Topping topping =
          toppingOptions.firstWhere((element) => element.id == id);
      selected.add(topping);
    }
    setState(() {
      toppings = selected;
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
              TopRoundedContainer(
                  color: const Color(0xFFF6F7F9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20)),
                        child: const Text(
                          "Chọn cỡ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Container(
                        color: Colors.white,
                        child: Size(
                          notifyParent: setSize,
                          size: _size,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20)),
                        child: const Text(
                          "Chọn mức đá",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Container(
                        color: Colors.white,
                        child: Iced(
                          notifyParent: setIced,
                          iced: _iced,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20)),
                        child: const Text(
                          "Chọn mức đường",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Container(
                        color: Colors.white,
                        child: Sugar(
                          notifyParent: setSugar,
                          sugar: _sugar,
                        ),
                      ),
                      (product.hasTopping == true)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: getProportionateScreenHeight(10)),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(20)),
                                  child: const Text(
                                    "Chọn topping",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(10)),
                                FutureBuilder(
                                    future: toppingService.getAllTopping(),
                                    builder: (context,
                                        AsyncSnapshot<List<Topping>> snapshot) {
                                      if (snapshot.hasError) {
                                        return const Center(
                                          child: Text('An error...'),
                                        );
                                      } else if (snapshot.hasData) {
                                        return Container(
                                          color: Colors.white,
                                          child: Toppings(
                                            toppings: snapshot.data!,
                                            notifyParent: setToppings,
                                          ),
                                        );
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }),
                                SizedBox(
                                    height: getProportionateScreenHeight(10))
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  )),
              SizedBox(height: getProportionateScreenHeight(10)),
              Row(
                children: [
                  Count(
                    notifyParent: setQuantity,
                    quantity: _quantity,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.05,
                        right: SizeConfig.screenWidth * 0.05,
                      ),
                      child: DefaultButton(
                        text: 'Thêm vào giỏ',
                        press: () {
                          double surCharge = _size == SIZE.s
                              ? 0
                              : _size == SIZE.m
                                  ? 6000
                                  : 10000;
                          double toppingPrice = 0;
                          for (final t in toppings) {
                            toppingPrice += t.price;
                          }
                          double price =
                              product.price + surCharge + toppingPrice;
                          CartItem carItem = CartItem(
                              product_id: product.id,
                              name: product.name,
                              image: product.image,
                              size: _size.name,
                              sugar: _sugar,
                              iced: _iced,
                              quantity: ValueNotifier(_quantity),
                              price: price,
                              toppings: toppings);
                          cart.addToCart(carItem);
                          successToast("Đã thêm vào giỏ");
                          setState(() {
                            _quantity = 1;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              TopRoundedContainer(
                  color: const Color(0xFFF6F7F9),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 15),
                        child: const Text(
                          "Đánh giá",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                          future: rateService.getRateByProductId(product.id),
                          builder:
                              (context, AsyncSnapshot<List<Rating>> snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child:
                                    Text('ERROR: ${snapshot.error.toString()}'),
                              );
                            } else if (snapshot.hasData) {
                              return ProductRating(rates: snapshot.data!);
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
    );
  }
}
