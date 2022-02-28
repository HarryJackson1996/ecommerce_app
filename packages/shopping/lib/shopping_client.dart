import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/store.dart';

class ShoppingClient {
  final http.Client _httpClient;

  ShoppingClient({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  Future<Categories> fetchCategories() async {
    const String productsUrl = 'https://fakestoreapi.com/products/categories';

    final response = await _httpClient.get(
      Uri.parse(productsUrl),
    );
    if (response.statusCode == 200) {
      Categories categories = Categories(
        categories: List<Category>.from(
          jsonDecode(response.body).map(
            (e) => Category(name: e, products: const []),
          ),
        ),
      );
      return categories;
    } else {
      throw Exception('Error');
    }
  }

  Future<List<Product>> fetchProducts({required String category}) async {
    final String productsUrl = 'https://fakestoreapi.com/products/category/$category';

    final response = await _httpClient.get(
      Uri.parse(productsUrl),
    );
    if (response.statusCode == 200) {
      var products = List<Product>.from(json.decode(response.body).map((x) => Product.fromJson(x)));
      return products;
    } else {
      throw Exception('Error');
    }
  }
}
