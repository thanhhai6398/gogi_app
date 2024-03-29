import 'package:flutter/material.dart';
import 'package:gogi/format.dart';

import '../../../components/product_card.dart';
import '../../../constants.dart';
import '../../../models/Product.dart';
import '../../../size_config.dart';
import '../../details/details_screen.dart';

class FavouriteProducts extends StatelessWidget {
  List<Product> products = [];

  FavouriteProducts({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(
        child: Text(
          "Không có sản phẩm",
          style: TextStyle(color: Colors.black),
        ),
      );
    } else {
      return GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(product: products[index], isLike: true,);
        },
      );
    }
  }
}
class ProductCardGrid extends StatelessWidget{
  const ProductCardGrid({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: ProductDetailsArguments(product: product),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                    aspectRatio: 2 / 3,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Hero(
                          tag: product.id.toString(),
                          child: Image(
                            image: NetworkImage(product.image),
                            fit: BoxFit.contain,
                          ),
                        )),
                  ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  totTitle(product.name),
                  style: TextStyle(color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  formatPrice(product.price),
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}