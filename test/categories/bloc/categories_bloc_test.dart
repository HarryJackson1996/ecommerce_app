import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:primarybid_ecommerce_app/categories/bloc/categories_bloc.dart';
import 'package:shopping/models/store.dart';
import 'package:shopping/shopping_repository.dart';

class MockShoppingRepository extends Mock implements ShoppingRepository {}

var mockProduct = Product(
  id: 8,
  title: 'title',
  price: 23.00,
  category: 'Jewellery',
  description: 'description',
  image: '',
  rating: Rating(
    count: 10,
    rate: 2,
  ),
);

var mockCategory = Category(
  name: 'Test',
  products: [mockProduct, mockProduct],
);
void main() {
  late ShoppingRepository shoppingRepository;
  late CategoriesBloc categoriesBloc;
  late Categories mockCategories;

  setUp(() {
    shoppingRepository = MockShoppingRepository();
    categoriesBloc = CategoriesBloc(
      shoppingRepository: shoppingRepository,
    );
    mockCategories = Categories(
      categories: [
        Category(name: 'test', products: [mockProduct])
      ],
    );
  });

  group('CategoriesBloc', () {
    test('Initial state is CategoriesState with no categories', () {
      final productsBloc = CategoriesBloc(
        shoppingRepository: shoppingRepository,
      );
      expect(
        productsBloc.state,
        CategoriesState(
          categories: Categories(categories: const []),
          categoriesStatus: CategoriesStatus.initial,
        ),
      );
    });

    blocTest<CategoriesBloc, CategoriesState>(
      'Emits [loading, success] - With Categories object containing List<Category>',
      build: () => categoriesBloc,
      setUp: () {
        when(
          () => shoppingRepository.fetchCategories(),
        ).thenAnswer((_) async => mockCategories);
      },
      act: (bloc) {
        bloc.add(CategoriesFetchedEvent());
      },
      expect: () => [
        CategoriesState(categoriesStatus: CategoriesStatus.loading, categories: Categories(categories: const [])),
        CategoriesState(categoriesStatus: CategoriesStatus.success, categories: mockCategories),
      ],
    );

    blocTest<CategoriesBloc, CategoriesState>(
      'Emits [loading, error] - When Exception is thrown',
      build: () => categoriesBloc,
      setUp: () {
        when(
          () => shoppingRepository.fetchCategories(),
        ).thenThrow(Exception());
      },
      act: (bloc) {
        bloc.add(CategoriesFetchedEvent());
      },
      expect: () => [
        CategoriesState(categoriesStatus: CategoriesStatus.loading, categories: Categories(categories: const [])),
        CategoriesState(categoriesStatus: CategoriesStatus.error, categories: Categories(categories: const [])),
      ],
    );
  });
}
