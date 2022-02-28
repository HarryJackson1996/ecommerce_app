import 'package:flutter/material.dart';
import 'package:primarybid_ecommerce_app/categories/view/categories.dart';
import 'package:primarybid_ecommerce_app/login/view/login.dart';
import 'package:primarybid_ecommerce_app/products/view/product.dart';
import 'package:shopping/models/store.dart';

enum Routes { login, categories, products }

class _Paths {
  static const String splash = '/';
  static const String login = '/login';
  static const String categories = '/categories';
  static const String products = '/products';
  static const Map<Routes, String> _pathMap = {
    Routes.login: _Paths.login,
    Routes.categories: _Paths.categories,
    Routes.products: _Paths.products,
  };

  static String of(Routes route) => _pathMap[route] ?? splash;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.login:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case _Paths.categories:
        return MaterialPageRoute(
          builder: (_) => const CategoriesPage(),
        );
      case _Paths.products:
        return MaterialPageRoute(
          builder: (_) => ProductPage(
            category: settings.arguments as Category,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static void pop() => state?.pop();

  static Future? pushNamed<T>(Routes route, [T? arguments]) {
    state?.pushNamed(_Paths.of(route), arguments: arguments);
  }

  static Future? pushAndRemoveUntil<T>(Route route, [T? arguments]) {
    state?.pushAndRemoveUntil(route, (route) => false);
  }

  static NavigatorState? get state => navigatorKey.currentState;
}
