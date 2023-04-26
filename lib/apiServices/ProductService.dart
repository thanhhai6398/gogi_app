import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'package:http/http.dart' show Client;

import '../models/Product.dart';
import '../models/Rate.dart';
class ProductService {
  Client client = Client();

  Future<List<Product>> getAllProduct() async {
    final response = await client.get(Uri.parse('$url/products/all'));
    return compute(parseProducts, response.body);
  }

  Future<List<Product>> getBestSeller() async {
    final response = await client.get(Uri.parse('$url/products/bestSeller'));
    return compute(parseProducts, response.body);
  }

  Future<List<Product>> getProductsForYou() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");

    final response =
    await client.get(Uri.parse('$url/products/forYou'), headers: {
      'Authorization': 'Bearer $token',
    });
    return compute(parseProducts, response.body);
  }

  Future<List<Product>> getCombo() async {
    final response = await client.get(Uri.parse('$url/products/combo'));
    return compute(parseProducts, response.body);
  }

  Future<ProductDetail> getProductById(int id) async {
    final response = await client.get(Uri.parse('$url/products/$id'));
    return compute(parseProductDetail, response.body);
  }

  Future<List<Product>> searchProduct(String keyword) async {
    final response = await client.get(Uri.parse('$url/products/searchKeyword?k=$keyword'));
    print(response.body);
    return compute(parseProducts, response.body);
  }

  Future<List<Product>> getProductByCategoryId(int id) async {
    final response = await client.get(Uri.parse('$url/products/categoryId/$id'));
    return compute(parseProducts, response.body);
  }

}