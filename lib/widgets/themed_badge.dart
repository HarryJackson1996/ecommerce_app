import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:primarybid_ecommerce_app/widgets/themed_text.dart';

import '../cart/bloc/cart_bloc.dart';

class ThemedBadge extends StatelessWidget {
  const ThemedBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Badge(
          position: BadgePosition.topEnd(top: 0, end: 3),
          animationType: BadgeAnimationType.fade,
          badgeColor: Colors.white,
          badgeContent: ThemedText(
            text: state.products.length.toString(),
            themeTextType: ThemeTextType.body,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.shopping_basket_outlined,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        );
      },
    );
  }
}
