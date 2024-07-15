import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_delivery_app/config/config.dart'; // Import the configuration file
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart'; // Assuming you have a Product model

class ApiService {
  final String baseUrl = Config.baseUrl; // Use the baseUrl from the config file

  Future<List<Product>> fetchProductsAPI(
      {int page = 1,
      String? keyword,
      Map<String, dynamic>? priceFilter}) async {
    try {
      // Retrieve the stored token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      print("Token stored checking $token");
      if (token == null) {
        throw Exception('No auth token found');
      }

      // Construct the URL with query parameters
      final queryParams = {
        'page': page.toString(),
        if (keyword != null) 'keyword': keyword,
        if (priceFilter != null)
          ...priceFilter
              .map((key, value) => MapEntry('price[$key]', value.toString())),
      };
      print("Queries : ${queryParams}");
      final url =
          Uri.parse('$baseUrl/products').replace(queryParameters: queryParams);

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $token', // Include the token in the Authorization header
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body)['products'];
        List<Product> products =
            body.map((item) => Product.fromJson(item)).toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products from API: $e');
    }
  }

  Future<http.Response> registerUser(
    String fullname,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'fullname': fullname,
          'email': email,
          'password': password,
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  Future<http.Response> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addToCartAPI(String productId, int quantity) async {
    try {
      // Retrieve the stored token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      print("Token stored checking ${token}");
      if (token == null) {
        throw Exception('No auth token found');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/addToCart'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'productId': productId,
          'quantity': quantity,
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to add to cart');
      }
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  Future<void> addToWishlist(String productId) async {
    try {
      // Retrieve the stored token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      print("Token stored checking ${token}");
      if (token == null) {
        throw Exception('No auth token found');
      }
      final url = Uri.parse('$baseUrl/wishlist');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'productId': productId}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add to wishlist: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to add to wishlist: $e');
    }
  }

  Future<List<dynamic>> fetchWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    print("Token stored checking ${token}");
    if (token == null) {
      throw Exception('No auth token found');
    }

    final url = Uri.parse('$baseUrl/wishlist');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch wishlist: ${response.body}');
    }

    final responseData = jsonDecode(response.body);
    return responseData['wishlistItems']['products'];
  }

  Future<List<dynamic>> fetchCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    if (token == null) {
      throw Exception('No auth token found');
    }

    try {
      final url = Uri.parse('$baseUrl/getCart');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("ResponseData: ${responseData['cartItems']}");
        return responseData['cartItems'];
      } else {
        throw Exception('Failed to load cart items: ${response.body}');
      }
    } catch (e) {
      print('Error fetching cart items: $e');
      throw e;
    }
  }

  Future<void> deleteAllItems() async {
    final url = Uri.parse('$baseUrl/deleteAllCartItems');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    if (token == null) {
      throw Exception('No auth token found');
    }

    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Deleted all items successfully');
      } else {
        throw Exception('Failed to delete items: ${response.body}');
      }
    } catch (e) {
      print('Error deleting items: $e');
      throw e;
    }
  }

  Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      if (token == null) {
        throw Exception('No auth token found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/products/category/?category=$category'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body)['products'] as List;
        List<Product> products = responseData.map((productJson) {
          return Product.fromJson(productJson);
        }).toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
