import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:iq101/main.dart';
import 'package:iq101/model/product_model.dart';
import 'package:iq101/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../model/order_model.dart';
import '../model/user_model.dart';



class ProductService {
  // static const String baseUrl = 'http://10.0.2.2:5000/api';
  //   String baseUrl =  'http://127.0.0.1:5000/api';
   static const String baseUrl =  'http://34.212.238.163:6000/api';

  Future<List<ProductModel>> getAllProducts() async {
    await Future.delayed(const Duration(seconds: 3));
    final response = await http.get(Uri.parse('$baseUrl/getproducts'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['products'];
      print(jsonData);

      return jsonData.map((product) => ProductModel.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
  Future<List<ProductModel>> getAllType(String? type) async {
    final response = await http.get(Uri.parse('$baseUrl/getproducttype/$type'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['products'];

      return jsonData.map((product) => ProductModel.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<ProductModel>> filterProducts(String type, List<String>? color, List<String>? size, bool? isPrinted, int? minRange, int? maxRange) async {
    final Map<String, dynamic> queryParams = {
      'type': type,
      'color': color?.join(','),
      'size': size?.join(','),
      'is_printed': isPrinted.toString(),
      'min_cost': minRange.toString(),
      'max_cost': maxRange.toString(),
    };
    final response = await http.get(Uri.parse('$baseUrl/filter').replace(queryParameters: queryParams));
    print(response.request);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['products'];
      print(jsonData);

      return jsonData.map((product) => ProductModel.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }


  Future<List<ProductModel>> getFavorites(int userId) async {
    final String apiUrl = '$baseUrl/getfavorites/$userId';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        List<dynamic> favoritesData = jsonData['favorites'];
        List<ProductModel> favorites = favoritesData.map((data) => ProductModel.fromJson(data)).toList();
        return favorites;
      } else {
        throw Exception('Failed to load favorites');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> addToFavorites(int userId, int productId) async {
    const String apiUrl = '$baseUrl/addtofavorites';
    final Map<String, dynamic> data = {
      'user_id': userId,
      'product_id': productId,
    };

    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(data));

      if (response.statusCode == 200) {
        print('Product added to favorites.');
      } else {
        print('Failed to add product to favorites.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> unlikeProduct(int userId, int productId) async {
    final String url = '$baseUrl/unlike/$userId/$productId';

    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        // Product was successfully removed from favorites
        // You can perform any necessary updates in your local state or UI here
        print('Product removed from favorites.');
      } else if (response.statusCode == 404) {
        // Product was not found in favorites (already removed or not present)
        print('Product not found in favorites.');
      } else {
        // Handle other error scenarios
        print('Failed to remove product from favorites. Status code: ${response
            .statusCode}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
    }
  }

  Future<Order> placeOrder(int userId, List<int> productIds) async {
    final Map<String, dynamic> orderData = {
      'user_id': userId,
      'product_ids': productIds,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/orders'), // Replace with your actual API URL
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(orderData),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return Order.fromJson(responseData);
    } else {
      throw Exception('Failed to place order: ${response.body}');
    }
  }

  Future<List<ProductModel>> getProductsForUser(int userId) async {
    final url = Uri.parse('$baseUrl/getorders?user_id=$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Parse and return the list of products
        return (jsonData['products'] as List)
            .map((productData) => ProductModel.fromJson(productData))
            .toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load products: $error');
    }
  }

}
