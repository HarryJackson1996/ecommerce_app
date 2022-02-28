import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:primarybid_ecommerce_app/app.dart';
import 'package:primarybid_ecommerce_app/auth/domain/auth_client.dart';
import 'package:primarybid_ecommerce_app/auth/domain/auth_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:primarybid_ecommerce_app/utils/helpers/secure_storage_helper.dart';
import 'package:shopping/shopping_client.dart';
import 'package:shopping/shopping_repository.dart';
import 'services/hive_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env');
  await Hive.initFlutter();

  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  await SecureStorageHelper.createSecureKey(dotenv.get('STORAGE_KEY'), secureStorage);
  var encryptionKey = await SecureStorageHelper.read(dotenv.get('STORAGE_KEY'), secureStorage);
  var encryptedAuthBox = await Hive.openBox(
    dotenv.get('AUTH_BOX_KEY'),
    encryptionCipher: HiveAesCipher(encryptionKey),
  );

  runApp(ECommerceApp(
    authRepository: AuthRepository(
      authClient: AuthClient(),
      cache: HiveRepository<String>(encryptedAuthBox),
    ),
    shoppingRepository: ShoppingRepository(
      shoppingClient: ShoppingClient(),
    ),
  ));
}
