import 'package:flutter/material.dart';
import 'package:gogi/screens/store/components/stores.dart';
import 'package:gogi/screens/store/components/search.dart';

import '../../../apiServices/StoreService.dart';
import '../../../models/Store.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  StoreService storeService = StoreService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Search(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Expanded(
            child: FutureBuilder(
                future: storeService.getAllStore(),
                builder: (context, AsyncSnapshot<List<Store>> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error...'),
                    );
                  } else if (snapshot.hasData) {
                    return Stores(stores: snapshot.data!);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  // Future<List<Store>> fetchStores(http.Client client) async {
  //   final response =
  //       await client.get(Uri.parse('$url/stores'));
  //   print(response.body);
  //   return compute(parseStores, response.body);
  // }

  // List<Store> parseStores(String responseBody) {
  //   final parsed =
  //       jsonDecode(responseBody)["data"].cast<Map<String, dynamic>>();
  //   return parsed.map<Store>((json) => Store.fromJson(json)).toList();
  // }
}
