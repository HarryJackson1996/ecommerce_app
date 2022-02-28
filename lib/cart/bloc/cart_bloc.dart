import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping/models/store.dart';
import 'package:shopping/shopping_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ShoppingRepository shoppingRepository;

  CartBloc({
    required this.shoppingRepository,
  }) : super(const CartState()) {
    on<CartItemAddedEvent>(_mapCartItemAddedToState);
    on<CartItemRemovedEvent>(_mapCartItemRemovedToState);
  }

  void _mapCartItemAddedToState(CartItemAddedEvent event, Emitter<CartState> emit) async {
    List<Product> newProductList = [];
    newProductList.addAll(state.products);
    newProductList.add(event.product);
    emit(state.copyWith(products: newProductList));
  }

  void _mapCartItemRemovedToState(CartItemRemovedEvent event, Emitter<CartState> emit) async {
    List<Product> newProductList = [];
    newProductList.addAll(state.products);
    newProductList.remove(event.product);
    emit(state.copyWith(products: newProductList));
  }
}
