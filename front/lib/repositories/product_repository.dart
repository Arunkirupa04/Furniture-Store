import 'package:food_delivery_app/models/product.dart';
import 'package:food_delivery_app/services/api_services.dart';

class ProductRepository {
  final ApiService _apiService = ApiService();

  Future<List<Product>> fetchProducts({String? keyword}) async {
    try {
      return await _apiService.fetchProductsAPI(keyword: keyword);
    } catch (e) {
      throw Exception('Failed to load products from REPOOOO: $e');
    }
  }
}
