part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class ProductsFetchedEvent extends ProductsEvent {
  final Category category;

  const ProductsFetchedEvent({
    required this.category,
  });

  @override
  List<Object> get props => [category];
}
