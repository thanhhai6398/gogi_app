import 'dart:convert';

import 'Category.dart';
import 'Rating.dart';

class Product {
  final int id;
  final String name, image, description;
  final double price, discount;
  final bool status, hasTopping;
  final CategoryModel category;
  final double avgPoint;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.discount,
    required this.status,
    required this.description,
    required this.category,
    required this.avgPoint,
    required this.hasTopping,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      category: CategoryModel.fromJson(json["category"]),
      price: json['price'],
      discount: json['discount'],
      status: json['status'],
      description: json['description'],
      image: json['img_url'],
      avgPoint: json['avgPoint'],
      hasTopping: json['hasTopping'],
    );
  }
}

List<Product> parseProducts(String responseBody) {
  final parsed = jsonDecode(responseBody)["data"].cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();

}
Product parseProduct(String responseBody) {
  return Product.fromJson(jsonDecode(responseBody)["data"]["product"]);
}

class ProductDetail {
  final int id;
  final String name, image, description;
  final double price, discount;
  final bool status;
  final CategoryModel category;
  final double avgPoint;
  final List<Rating> rates;

  ProductDetail({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.discount,
    required this.status,
    required this.description,
    required this.category,
    required this.avgPoint,
    required this.rates,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    var rateList = json['rates'] as List;
    List<Rating> rates = rateList.map((r) => Rating.fromJson(r)).toList();
    return ProductDetail(
      id: json["product"]['id'] as int,
      name: json["product"]['name'] as String,
      category: CategoryModel.fromJson(json["product"]["category"]),
      price: json["product"]['price'],
      discount: json["product"]['discount'],
      status: json["product"]['status'],
      description: json["product"]['description'],
      image: json["product"]['img_url'],
      avgPoint: json["product"]['avgPoint'],
      rates: rates,
    );
  }
}

ProductDetail parseProductDetail(String responseBody) {
  return ProductDetail.fromJson(jsonDecode(responseBody)["data"]);
}
// Our demo Products

// List<Product> demoProducts = [
//   Product(
//     id: 1,
//     image: "https://firebasestorage.googleapis.com/v0/b/gogi-images.appspot.com/o/files%2Fzmnc2yp?alt=media&token=3307075b-e83f-4916-abe0-443fc2d78464",
//     name: "Trà sữa trân châu",
//     price: 30000,
//     description: "description",
//     status: true,
//     category: CategoryModel(id: 1, name: "Coffee", status: true),
//     avgPoint: 3,
//   ),
//   Product(
//     id: 2,
//     image: "https://firebasestorage.googleapis.com/v0/b/gogi-images.appspot.com/o/files%2Fzmnc2yp?alt=media&token=3307075b-e83f-4916-abe0-443fc2d78464",
//     name: "Trà sữa trân châu",
//     price: 30000,
//     description: "description",
//     status: true,
//     category: CategoryModel(id: 1, name: "Coffee", status: true),
//     avgPoint: 3,
//   ),
//   Product(
//     id: 3,
//     image: "https://firebasestorage.googleapis.com/v0/b/gogi-images.appspot.com/o/files%2Fzmnc2yp?alt=media&token=3307075b-e83f-4916-abe0-443fc2d78464",
//     name: "Trà sữa trân châu",
//     price: 30000,
//     description: "description",
//     status: true,
//     category: CategoryModel(id: 1, name: "Coffee", status: true),
//     avgPoint: 3,
//   ),
// ];

// const String description =
//     "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
