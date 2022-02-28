part of 'products_bloc.dart';

enum ProductsStatus {
  inital,
  loading,
  success,
  error,
}

class ProductsState extends Equatable {
  const ProductsState({this.productsStatus = ProductsStatus.inital, this.category});

  final ProductsStatus productsStatus;
  final Category? category;

  ProductsState copyWith({
    ProductsStatus? productsStatus,
    Category? category,
  }) =>
      ProductsState(
        productsStatus: productsStatus ?? this.productsStatus,
        category: category ?? this.category,
      );
  @override
  List<Object?> get props => [productsStatus, category];
}
