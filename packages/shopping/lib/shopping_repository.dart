import 'models/store.dart';
import 'shopping_client.dart';

class ShoppingRepository {
  final ShoppingClient shoppingClient;

  ShoppingRepository({
    required this.shoppingClient,
  });

  Future<Categories> fetchCategories() async {
    var categories = await shoppingClient.fetchCategories();
    return categories;
  }

  Future<List<Product>> fetchProducts({required String category}) async {
    var products = await shoppingClient.fetchProducts(category: category);
    return products;
  }
}
