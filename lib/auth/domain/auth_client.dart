import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthClient {
  final http.Client _httpClient;

  AuthClient({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  Future<String> login({
    required String username,
    required String password,
  }) async {
    var url = 'https://fakestoreapi.com/auth/login';
    var body = {
      'username': username,
      'password': password,
    };
    final response = await _httpClient.post(
      Uri.parse(url),
      body: json.encode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('error');
    } else {
      return jsonDecode(response.body)['token'];
    }
  }
}
