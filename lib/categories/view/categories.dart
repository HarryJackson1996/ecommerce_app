import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:primarybid_ecommerce_app/categories/view/widgets/categories_view.dart';
import 'package:primarybid_ecommerce_app/widgets/themed_badge.dart';
import 'package:primarybid_ecommerce_app/widgets/themed_text.dart';
import 'package:shopping/shopping_repository.dart';
import '../bloc/categories_bloc.dart';

class CategoriesPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => const CategoriesPage());
  }

  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        title: const ThemedText(
          text: 'Categories',
          themeTextType: ThemeTextType.h2,
        ),
        actions: const [
          ThemedBadge(),
        ],
      ),
      body: BlocProvider(
        create: (context) {
          return CategoriesBloc(
            shoppingRepository: RepositoryProvider.of<ShoppingRepository>(context),
          )..add(CategoriesFetchedEvent());
        },
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: CategoriesView(),
        ),
      ),
    );
  }
}
