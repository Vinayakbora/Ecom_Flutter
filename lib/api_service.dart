import 'dart:convert';

import 'package:flutter_assngmnt/category.dart';
import 'package:flutter_assngmnt/product.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';
  static const String getProductsEndPoint = '/products';
  static const String getCategoriesEndPoint = '/products/categories';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl + getProductsEndPoint));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['products'];
      return jsonData.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(baseUrl + getCategoriesEndPoint));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
