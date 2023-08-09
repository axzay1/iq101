import 'dart:convert';
import 'package:http/http.dart' as http;

class Order {
  final int? id;
  final int? userId;
  final List<int> productIds;

  Order({
    this.id,
    this.userId,
    required this.productIds,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['user_id'],
      productIds: List<int>.from(json['product_ids'] ?? []),
    );
  }
}

class OrderService {
  Future<Order> placeOrder(int userId, List<int> productIds) async {
    final Map<String, dynamic> orderData = {
      'user_id': userId,
      'product_ids': productIds,
    };

    final response = await http.post(
      Uri.parse('http://your-api-url/api/orders'), // Replace with your actual API URL
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
}
