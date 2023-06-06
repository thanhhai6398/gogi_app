import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gogi/apiServices/ProductService.dart';
import 'package:gogi/apiServices/RateService.dart';
import 'package:gogi/components/toast.dart';
import 'package:gogi/format.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../models/Order_detail.dart';
import '../../../models/Product.dart';
import '../../../models/Request/RatingRequest.dart';
import '../../../size_config.dart';
import '../../details/details_screen.dart';

class Products extends StatelessWidget {
  List<OrderDetail> details = [];
  int state;

  Products({super.key, required this.details, required this.state});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(5.0),
      children: List.generate(details.length, (index) {
        return Center(
          child: ProductOrder(
            product: details[index],
            state: state,
          ),
        );
      }),
    );
  }
}

class ProductOrder extends StatelessWidget {
  RateService rateService = RateService();

  ProductOrder({
    Key? key,
    required this.product,
    required this.state,
  }) : super(key: key);

  final OrderDetail product;
  final int state;

  String toppings = '';

  @override
  Widget build(BuildContext context) {
    if (product.toppings.isNotEmpty) {
      // toppings = product.toppings.first.name;
      // for (int i = 1; i < product.toppings.length; i++) {
      //   toppings = "$toppings, ${product.toppings[i].name}";
      // }
      toppings = product.toppings.map((item) => totTitle(item.name)).join((', '));
    }

    return Card(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            alignment: Alignment.center,
            child: Text(
              "x${product.quantity}",
            ),
          ),
          const SizedBox(
            width: 5.0,
          ),
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(5)),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6F9),
              borderRadius: BorderRadius.circular(5),
            ),
            //product.image
            child: Image(
              image: NetworkImage(product.img_url),
              fit: BoxFit.contain,
              height: getProportionateScreenHeight(90),
              width: getProportionateScreenWidth(60),
            ),
          ),
          const SizedBox(
            width: 5.0,
          ),
          Expanded(
              child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  totTitle(product.product_name),
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Cỡ ${product.size}, ${product.sugar} đường, ${product.iced} đá.",
                ),
              ),
              (toppings.isNotEmpty)
                  ? Column(
                      children: [
                        SizedBox(height: getProportionateScreenHeight(5)),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Topping: $toppings",
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              Container(
                padding: const EdgeInsets.only(right: 5.0),
                alignment: Alignment.topRight,
                child: Text(
                  formatPrice(product.price),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              IsRated(
                state: state,
                product_id: product.product_id,
              )
            ],
          )),
        ],
      ),
    );
  }
}

class IsRated extends StatefulWidget {
  int state;
  int product_id;

  IsRated({super.key, required this.state, required this.product_id});

  @override
  State<IsRated> createState() => StateIsRated();
}

class StateIsRated extends State<IsRated> {
  RateService rateService = RateService();

  bool? isExisted;

  @override
  void initState() {
    super.initState();
    rateService.checkExisted(widget.product_id).then((value) {
      setState(() {
        isExisted = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isExisted == false) {
      if (widget.state == 2) {
        return Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
            onPressed: () => {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      insetPadding: EdgeInsets.all(10),
                      scrollable: true,
                      content: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: RateForm(
                            product_id: widget.product_id,
                          )),
                      actions: [
                        TextButton(
                            child: const Text("Đóng"),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    );
                  })
            },
            style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(kPrimaryColor)),
            child: const Text(
              "Đánh giá",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    } else {
      if (widget.state == 2) {
        return Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
            onPressed: () => {},
            style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(kPrimaryColor)),
            child: const Text(
              "Đã đánh giá",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    }
  }
}

class RateForm extends StatefulWidget {
  int product_id;

  RateForm({super.key, required this.product_id});

  @override
  State<RateForm> createState() => StateRateForm();
}

class StateRateForm extends State<RateForm> {
  RateService rateService = RateService();
  ProductService productService = ProductService();
  TextEditingController textarea = TextEditingController();
  double point = 1.0;
  late Product product;

  @override
  Widget build(BuildContext context) {
    productService
        .getProductById(widget.product_id)
        .then((value) => setState(() {
              product = value;
            }));
    return Column(
      children: [
        RatingBar.builder(
          initialRating: point.toDouble(),
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.deepOrangeAccent,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              point = rating;
            });
          },
        ),
        const SizedBox(
          height: 5.0,
        ),
        TextField(
          controller: textarea,
          keyboardType: TextInputType.multiline,
          maxLines: 4,
          decoration: const InputDecoration(
              hintText: "Bạn thấy sản phẩm như thế nào?",
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.redAccent))),
        ),
        const SizedBox(
          height: 10.0,
        ),
        DefaultButton(
            text: "Gửi",
            press: () {
              String content = textarea.text.toString();
              RatingRequest data = RatingRequest(
                  id: widget.product_id,
                  point: point.toInt(),
                  content: content);
              rateService.postRate(data).then((value) {
                if (value == true) {
                  Navigator.pop(context);
                  successToast("Đã đánh giá");
                  Navigator.pushNamed(
                    context,
                    DetailsScreen.routeName,
                    arguments: ProductDetailsArguments(product: product),
                  );
                } else {
                  print("error post rate");
                }
              });
            })
      ],
    );
  }
}
