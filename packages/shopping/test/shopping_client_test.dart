import 'package:mocktail/mocktail.dart';
import 'package:shopping/shopping_client.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() async {
  late ShoppingClient shoppingClient;
  late http.Client httpClient;
  final Uri categoriesUri = Uri.parse('https://fakestoreapi.com/products/categories');
  final Uri productsUri = Uri.parse('https://fakestoreapi.com/products/category/Jewelery');

  setUp(() {
    httpClient = MockHttpClient();
    shoppingClient = ShoppingClient(httpClient: httpClient);
  });

  group('constructor', () {
    test('Does not require a httpClient', () {
      expect(ShoppingClient(), isNotNull);
    });
  });

  group('Fetch Categories', () {
    test('Makes correct http request', () async {
      when(
        () => httpClient.get(
          categoriesUri,
        ),
      ).thenAnswer(
        (_) async => http.Response('''[
          "electronics",
          "jewelery",
          "men's clothing",
          "women's clothing"
          ]''', 200),
      );

      try {
        await shoppingClient.fetchCategories();
      } catch (_) {}
      verify(
        () => httpClient.get(
          categoriesUri,
        ),
      ).called(1);
    });

    test('throws Exception on non-200 response', () async {
      when(
        () => httpClient.get(
          categoriesUri,
        ),
      ).thenAnswer(
        (_) async => http.Response('Bad request', 400),
      );
      expect(
        () async => await shoppingClient.fetchCategories(),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('Fetch Products', () {
    test('Makes correct http request', () async {
      when(
        () => httpClient.get(
          productsUri,
        ),
      ).thenAnswer(
        (_) async => http.Response('''
[
  {
    "id": 5,
    "title": "John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet",
    "price": 695,
    "description": "From our Legends Collection, the Naga was inspired by the mythical water dragon that protects the ocean's pearl. Wear facing inward to be bestowed with love and abundance, or outward for protection.",
    "category": "jewelery",
    "image": "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
    "rating": {
      "rate": 4.6,
      "count": 400
    }
  },
  {
    "id": 8,
    "title": "Pierced Owl Rose Gold Plated Stainless Steel Double",
    "price": 10.99,
    "description": "Rose Gold Plated Double Flared Tunnel Plug Earrings. Made of 316L Stainless Steel",
    "category": "jewelery",
    "image": "https://fakestoreapi.com/img/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
    "rating": {
      "rate": 1.9,
      "count": 100
    }
  }
]''', 200),
      );

      try {
        await shoppingClient.fetchProducts(category: 'Jewelery');
      } catch (_) {}
      verify(
        () => httpClient.get(
          productsUri,
        ),
      ).called(1);
    });

    test('throws Exception on non-200 response', () async {
      when(
        () => httpClient.get(
          productsUri,
        ),
      ).thenAnswer(
        (_) async => http.Response('Bad request', 400),
      );
      expect(
        () async => await shoppingClient.fetchProducts(category: 'Jewelery'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
