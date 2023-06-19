import 'package:flutter/foundation.dart';

import '../constants.dart';
import 'package:http/http.dart' show Client;

import '../models/Category.dart';

class CategoryService {
  Client client = Client();

  Future<List<CategoryModel>> getAllCategory() async {
    final response = await client.get(Uri.parse('$url/categories/available'));
    return compute(parseCategories, response.body);
  }
}