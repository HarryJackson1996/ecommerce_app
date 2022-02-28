import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping/models/store.dart';
import 'package:shopping/shopping_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ShoppingRepository shoppingRepository;

  ProductsBloc({
    required this.shoppingRepository,
  }) : super(const ProductsState(productsStatus: ProductsStatus.inital)) {
    on<ProductsFetchedEvent>(_mapProductsFetchedToState);
  }

  void _mapProductsFetchedToState(
    ProductsFetchedEvent event,
    Emitter<ProductsState> emit,
  ) async {
    if (state.productsStatus != ProductsStatus.loading) {
      emit(state.copyWith(productsStatus: ProductsStatus.loading));
    }
    try {
      var products = await shoppingRepository.fetchProducts(
        category: event.category.name,
      );
      var category = event.category.copyWith(products: products);
      emit(
        state.copyWith(
          category: category,
          productsStatus: ProductsStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          productsStatus: ProductsStatus.error,
        ),
      );
    }
  }
}
