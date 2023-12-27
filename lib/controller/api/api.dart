import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  Future<List> fetchingAllProducts() async {
    http.Response response = await http.get(Uri.parse(
        "https://ecommerce-ec204-default-rtdb.firebaseio.com/home.json"));

    final products = json.decode(response.body) as List;
    return products;
  }

  Future<List> fetchRecommendedProducts() async {
    http.Response response = await http.get(Uri.parse(
        "https://ecommerce-ec204-default-rtdb.firebaseio.com/recommendation.json"));

    final products = json.decode(response.body) as List;
    return products;
  }
}
