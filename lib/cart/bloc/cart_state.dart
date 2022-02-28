part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<Product> products;

  const CartState({
    this.products = const [],
  });

  CartState copyWith({List<Product>? products}) => CartState(
        products: products ?? this.products,
      );

  @override
  List<Object> get props => [products];
}
