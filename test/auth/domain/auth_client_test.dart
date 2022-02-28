import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:primarybid_ecommerce_app/auth/domain/auth_client.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() async {
  late AuthClient authClient;
  late http.Client httpClient;
  final Uri uri = Uri.parse('https://fakestoreapi.com/auth/login');

  setUp(() {
    httpClient = MockHttpClient();
    authClient = AuthClient(httpClient: httpClient);
  });

  group('constructor', () {
    test('Does not require a httpClient', () {
      expect(AuthClient(), isNotNull);
    });
  });

  group('Login user', () {
    var body = {
      'username': 'username',
      'password': 'password',
    };
    test('Makes correct http request', () async {
      when(
        () => httpClient.post(
          uri,
          body: body,
          headers: {'Content-Type': 'application/json'},
        ),
      ).thenAnswer(
        (_) async => http.Response('test', 200),
      );

      try {
        await authClient.login(username: 'username', password: 'password');
      } catch (_) {}
      verify(
        () => httpClient.post(
          uri,
          body: json.encode(body),
          headers: {'Content-Type': 'application/json'},
        ),
      ).called(1);
    });

    test('throws Exception on non-200 response', () async {
      when(
        () => httpClient.post(
          uri,
          body: json.encode(body),
          headers: {'Content-Type': 'application/json'},
        ),
      ).thenAnswer(
        (_) async => http.Response('Bad request', 400),
      );
      expect(
        () async => await authClient.login(username: 'username', password: 'password'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
