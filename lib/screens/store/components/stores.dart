import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gogi/format.dart';

import '../../../constants.dart';
import '../../../models/Store.dart';
import '../../../size_config.dart';

class Stores extends StatelessWidget {
  List<Store> stores = [];

  Stores({super.key, required this.stores});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: List.generate(stores.length, (index) {
        return Center(
          child: StoreCard(store: stores[index]),
        );
      }),
    );
  }
}

class StoreCard extends StatelessWidget {
  const StoreCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.store,
  }) : super(key: key);

  final double width, aspectRetio;
  final Store store;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/icons/Shop Icon.svg",
                height: 100,
                width: 80,
              ),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.topLeft,
              child: Column(children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    store.name,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    totTitle(store.address),
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "6:00 am - 6:30 pm",
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Có wifi",
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Giao hàng tận nơi",
                    maxLines: 2,
                  ),
                ),
              ]),
            )),
          ],
        ));
  }
}
