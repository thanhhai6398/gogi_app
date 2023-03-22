import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, description;
  final String image;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.image,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: 1,
    image: "assets/images/1.jpg",
    title: "Trà sữa trân châu",
    price: 30000,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 2,
    image:  "assets/images/2.jpg",
    title: "Trà sữa nướng",
    price: 25000,
    description: description,
    rating: 4.1,
    isPopular: true,
  ),
  Product(
    id: 3,
    image: "assets/images/3.jpg",
    title: "Trà dâu tằm",
    price: 28000,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 4,
    image: "assets/images/4.jpg",
    title: "Trà Nhài",
    price: 22000,
    description: description,
    rating: 4.1,
    isFavourite: true,
  ),
  Product(
    id: 5,
    image: "assets/images/3.jpg",
    title: "Trà dâu",
    price: 30000,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 6,
    image: "assets/images/4.jpg",
    title: "Trà Nhài",
    price: 20000,
    description: description,
    rating: 4.1,
    isFavourite: true,
  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
