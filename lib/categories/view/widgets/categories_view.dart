import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:primarybid_ecommerce_app/categories/bloc/categories_bloc.dart';
import 'package:primarybid_ecommerce_app/routes.dart';
import 'package:primarybid_ecommerce_app/utils/extensions/string_extension.dart';
import 'package:primarybid_ecommerce_app/widgets/spacer.dart';
import 'package:primarybid_ecommerce_app/widgets/themed_button.dart';
import 'package:primarybid_ecommerce_app/widgets/themed_error.dart';
import 'package:primarybid_ecommerce_app/widgets/themed_text.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        switch (state.categoriesStatus) {
          case CategoriesStatus.success:
            return _categoriesListView(state);
          case CategoriesStatus.error:
            return ThemedError(
              errorText: 'Error fetching categories from server!',
              onClick: () => context.read<CategoriesBloc>().add(CategoriesFetchedEvent()),
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

  Widget _categoriesListView(CategoriesState state) {
    return ListView.separated(
      itemCount: state.categories.categories.length,
      separatorBuilder: (context, index) => const VSpacer(10.0),
      itemBuilder: (context, index) {
        return _categoriesListItem(state, index);
      },
    );
  }

  Widget _categoriesListItem(CategoriesState state, int index) {
    var category = state.categories.categories[index];
    return GestureDetector(
      onTap: () {
        AppNavigator.pushNamed(Routes.products, category);
      },
      child: SizedBox(
        height: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ThemedText(
                  text: category.name.capitalise(),
                  themeTextType: ThemeTextType.button,
                ),
                const Icon(
                  Icons.arrow_right_sharp,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
