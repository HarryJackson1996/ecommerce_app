import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:primarybid_ecommerce_app/auth/domain/auth_client.dart';
import '../../services/hive_repository.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthRepository {
  AuthRepository({
    required this.authClient,
    required this.cache,
  });

  final AuthClient authClient;
  final IRepository<String> cache;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    var token = await authClient.login(
      username: username,
      password: password,
    );
    await cache.put(dotenv.get('AUTH_KEY'), token);
  }

  bool isUserLoggedIn() {
    var token = cache.get(dotenv.get('AUTH_KEY'));
    return token != null ? true : false;
  }
}
