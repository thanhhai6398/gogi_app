import 'package:http/http.dart' show Client;

import 'package:flutter/foundation.dart';

import '../constants.dart';
import '../models/Store.dart';

class StoreService {
  Client client = Client();

  Future<List<Store>> getAllStore() async {
    final response = await client.get(Uri.parse('$url/stores'));
    return compute(parseStores, response.body);
  }

}