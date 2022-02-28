import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping/models/store.dart';
import 'package:shopping/shopping_repository.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final ShoppingRepository shoppingRepository;

  CategoriesBloc({
    required this.shoppingRepository,
  }) : super(CategoriesState(categories: Categories(categories: const []))) {
    on<CategoriesFetchedEvent>(_mapCategoriesFetchedToState);
  }

  void _mapCategoriesFetchedToState(
    CategoriesFetchedEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    if (state.categoriesStatus != CategoriesStatus.loading) {
      emit(state.copyWith(categoriesStatus: CategoriesStatus.loading));
    }
    try {
      var categories = await shoppingRepository.fetchCategories();
      emit(state.copyWith(
        categories: categories,
        categoriesStatus: CategoriesStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(categoriesStatus: CategoriesStatus.error));
    }
  }
}
