import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SecureStorageHelper {
  static Future<void> createSecureKey(String key, FlutterSecureStorage secureStorage) async {
    var containsEncryptionKey = await secureStorage.containsKey(key: key);
    if (!containsEncryptionKey) {
      var secureKey = Hive.generateSecureKey();
      await secureStorage.write(key: key, value: base64UrlEncode(secureKey));
    }
  }

  static Future<List<int>> read(String key, FlutterSecureStorage storage) async {
    var value = await storage.read(key: key);
    var encryptionKey = base64Url.decode(value!);
    return encryptionKey;
  }
}
