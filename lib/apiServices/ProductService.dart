import 'package:flutter/foundation.dart';

import '../constants.dart';
import 'package:http/http.dart' show Client;

import '../models/Product.dart';
class ProductService {
  Client client = Client();

  Future<List<Product>> getAllProduct() async {
    final response = await client.get(Uri.parse('$url/products/all'));
    return compute(parseProducts, response.body);
  }

  Future<List<Product>> getProductPopular() async {
    final response = await client.get(Uri.parse('$url/products/all'));
    return compute(parseProducts, response.body);
  }

  Future<List<Product>> getProductById(int id) async {
    final response = await client.get(Uri.parse('$url/products/$id'));
    return compute(parseProducts, response.body);
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