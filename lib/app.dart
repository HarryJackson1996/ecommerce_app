import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:primarybid_ecommerce_app/auth/bloc/auth_bloc.dart';
import 'package:primarybid_ecommerce_app/auth/domain/auth_repository.dart';
import 'package:primarybid_ecommerce_app/cart/bloc/cart_bloc.dart';
import 'package:primarybid_ecommerce_app/categories/view/categories.dart';
import 'package:primarybid_ecommerce_app/config/theme.dart';
import 'package:primarybid_ecommerce_app/login/bloc/login_bloc.dart';
import 'package:primarybid_ecommerce_app/login/view/login.dart';
import 'package:primarybid_ecommerce_app/routes.dart';
import 'package:shopping/shopping_repository.dart';

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({
    required this.authRepository,
    required this.shoppingRepository,
  });

  final AuthRepository authRepository;
  final ShoppingRepository shoppingRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => authRepository,
        ),
        RepositoryProvider<ShoppingRepository>(
          create: (context) => shoppingRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(
              authRepository: authRepository,
            ),
          ),
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: authRepository,
              loginBloc: BlocProvider.of<LoginBloc>(context),
            )..add(AuthCheckedEvent()),
          ),
          BlocProvider(
            create: (context) => CartBloc(
              shoppingRepository: shoppingRepository,
            ),
          ),
        ],
        child: ECommerceAppView(),
      ),
    );
  }
}

class ECommerceAppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme.first,
      navigatorKey: AppNavigator.navigatorKey,
      onGenerateRoute: AppNavigator.onGenerateRoute,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthStatus.authenticated:
                AppNavigator.pushAndRemoveUntil(CategoriesPage.route());
                break;
              case AuthStatus.unauthenticated:
                AppNavigator.pushAndRemoveUntil(LoginPage.route());
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      home: LoginPage(),
    );
  }
}
