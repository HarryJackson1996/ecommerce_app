import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:primarybid_ecommerce_app/widgets/spacer.dart';
import 'package:primarybid_ecommerce_app/widgets/themed_text.dart';
import 'package:shopping/models/store.dart';
import '../../../cart/bloc/cart_bloc.dart';
import '../../../widgets/themed_error.dart';
import '../../bloc/products_bloc.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        switch (state.productsStatus) {
          case ProductsStatus.success:
            return productsListView(state, context);
          case ProductsStatus.error:
            return ThemedError(
              errorText: 'Error fetching products from server!',
              onClick: () => context.read<ProductsBloc>().add(
                    ProductsFetchedEvent(
                      category: Category(name: categoryName, products: const []),
                    ),
                  ),
            );
          default:
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
        }
      },
    );
  }

  Widget productsListView(ProductsState state, BuildContext context) {
    var products = state.category?.products;
    return ListView.separated(
      itemCount: products?.length ?? 0,
      itemBuilder: (context, index) {
        return productsListItem(products![index], context);
      },
      separatorBuilder: (context, index) {
        return const VSpacer(10);
      },
    );
  }

  Widget productsListItem(Product product, BuildContext context) {
    return SizedBox(
      height: 175,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              SizedBox(
                width: 70,
                child: CachedNetworkImage(
                  imageUrl: product.image,
                ),
              ),
              const HSpacer(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ThemedText(
                      text: product.title,
                      themeTextType: ThemeTextType.button,
                      maxLines: 3,
                    ),
                    const VSpacer(10),
                    Expanded(
                      child: ThemedText(
                        text: product.description,
                        textOverflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        themeTextType: ThemeTextType.body,
                      ),
                    ),
                    Row(
                      children: [
                        ThemedText(
                          text: '£' + product.price.toString(),
                          themeTextType: ThemeTextType.h3,
                          fontColor: Colors.black,
                        ),
                        const Spacer(),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 225, 225, 225),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              context.read<CartBloc>().add(CartItemRemovedEvent(product: product));
                            },
                            child: const Icon(Icons.remove),
                          ),
                        ),
                        const HSpacer(10),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 225, 225, 225),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              context.read<CartBloc>().add(CartItemAddedEvent(product: product));
                            },
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
