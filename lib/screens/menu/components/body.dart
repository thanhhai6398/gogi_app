import 'package:gogi/apiServices/CategoryService.dart';
import 'package:gogi/apiServices/ProductService.dart';
import 'package:gogi/models/Product.dart';

import 'package:gogi/screens/menu/components/categories.dart';
import 'package:gogi/screens/menu/components/products.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../../../models/Category.dart';

class Body extends StatelessWidget {
  int id;
  CategoryService categoryService = CategoryService();
  ProductService productService = ProductService();

  Body({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          FutureBuilder(
              future: categoryService.getAllCategory(),
              builder: (context, AsyncSnapshot<List<CategoryModel>> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error...'),
                  );
                } else if (snapshot.hasData) {
                  return Categories(categoies: snapshot.data!, id: id);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          SizedBox(height: getProportionateScreenHeight(10)),
          listProducts(),
        ],
      ),
    );
  }

  listProducts() {
    if (id == 0) {
      return Expanded(
        child: FutureBuilder(
            future: productService.getAllProduct(),
            builder: (context, AsyncSnapshot<List<Product>> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error...'),
                );
              } else if (snapshot.hasData) {
                return Products(products: snapshot.data!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      );
    }
    else {
      return Expanded(
        child: FutureBuilder(
            future: productService.getProductByCategoryId(id),
            builder: (context, AsyncSnapshot<List<Product>> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error...'),
                );
              } else if (snapshot.hasData) {
                return Products(products: snapshot.data!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      );
    }
  }
}
