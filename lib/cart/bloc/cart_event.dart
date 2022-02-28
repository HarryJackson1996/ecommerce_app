part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartItemAddedEvent extends CartEvent {
  final Product product;

  const CartItemAddedEvent({
    required this.product,
  });

  @override
  List<Object> get props => [product];
}

class CartItemRemovedEvent extends CartEvent {
  final Product product;

  const CartItemRemovedEvent({
    required this.product,
  });

  @override
  List<Object> get props => [product];
}
