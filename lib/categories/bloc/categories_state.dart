part of 'categories_bloc.dart';

enum CategoriesStatus {
  initial,
  loading,
  success,
  error,
}

class CategoriesState extends Equatable {
  const CategoriesState({
    required this.categories,
    this.categoriesStatus = CategoriesStatus.initial,
  });

  final Categories categories;
  final CategoriesStatus categoriesStatus;

  CategoriesState copyWith({
    Categories? categories,
    CategoriesStatus? categoriesStatus,
  }) =>
      CategoriesState(
        categories: categories ?? this.categories,
        categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      );

  @override
  List<Object> get props => [categories, categoriesStatus];
}
