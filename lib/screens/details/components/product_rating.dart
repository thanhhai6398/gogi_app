import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gogi/format.dart';
import 'package:gogi/models/Rate.dart';

import '../../../models/Product.dart';

class ProductRating extends StatelessWidget {
  final Product product;

  const ProductRating({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    List<Rate> rates = product.rates.toList();

    if (rates.isEmpty) {
      return const Center(
        child: Text(
          "Chưa có đánh giá",
          style: TextStyle(color: Colors.black),
        ),
      );
    } else {
      return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: List.generate(rates.length, (index) {
          return Center(
            child: RateCard(rate: rates[index]),
          );
        }),
      );
    }
  }
}

class RateCard extends StatelessWidget {
  RateCard({super.key, required this.rate});

  Rate rate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                const Icon(Icons.person),
                SizedBox(width: 10),
                Text(rate.username),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: RatingBar.builder(
                itemSize: 25,
                initialRating: rate.point.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.deepOrangeAccent,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(rate.content),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(children: [
              Text(formatDate(rate.createdDate)),
              SizedBox(width: 10,),
              Text(formatTime(rate.createdDate)),
            ]),
          ),

        ],
      ),
    );
  }
}
