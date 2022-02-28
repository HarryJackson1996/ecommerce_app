import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:primarybid_ecommerce_app/products/view/widgets/products_view.dart';
import 'package:primarybid_ecommerce_app/routes.dart';
import 'package:primarybid_ecommerce_app/utils/extensions/string_extension.dart';
import 'package:primarybid_ecommerce_app/widgets/themed_badge.dart';
import 'package:primarybid_ecommerce_app/widgets/themed_text.dart';
import 'package:shopping/models/store.dart';
import 'package:shopping/shopping_repository.dart';
import '../bloc/products_bloc.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({required this.category});

  final Category category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        title: ThemedText(
          text: category.name.capitalise(),
          themeTextType: ThemeTextType.h2,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.black,
          onPressed: () {
            AppNavigator.pop();
          },
        ),
        actions: const [ThemedBadge()],
      ),
      body: BlocProvider(
        create: (context) => ProductsBloc(
          shoppingRepository: RepositoryProvider.of<ShoppingRepository>(context),
        )..add(ProductsFetchedEvent(category: category)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ProductsView(
            categoryName: category.name,
          ),
        ),
      ),
    );
  }
}
