import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:primarybid_ecommerce_app/products/bloc/products_bloc.dart';
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
void main() {
  late ShoppingRepository shoppingRepository;
  late ProductsBloc productsBloc;
  late Category mockCategory;

  setUp(() {
    shoppingRepository = MockShoppingRepository();
    productsBloc = ProductsBloc(
      shoppingRepository: shoppingRepository,
    );
    mockCategory = const Category(
      name: 'Jewellery',
      products: [],
    );
  });

  group('ProductsBloc', () {
    test('Initial state is ProductsState with no Category', () {
      final productsBloc = ProductsBloc(
        shoppingRepository: shoppingRepository,
      );
      expect(
        productsBloc.state,
        const ProductsState(
          productsStatus: ProductsStatus.inital,
        ),
      );
    });

    blocTest<ProductsBloc, ProductsState>(
      'Emits [loading, success] - With Category containing fetched products',
      build: () => productsBloc,
      setUp: () {
        when(
          () => shoppingRepository.fetchProducts(
            category: mockCategory.name,
          ),
        ).thenAnswer((_) async => [mockProduct, mockProduct]);
      },
      act: (bloc) {
        bloc.add(ProductsFetchedEvent(category: mockCategory));
      },
      expect: () => [
        const ProductsState(productsStatus: ProductsStatus.loading),
        ProductsState(
          productsStatus: ProductsStatus.success,
          category: mockCategory.copyWith(
            products: [mockProduct, mockProduct],
          ),
        ),
      ],
    );

    blocTest<ProductsBloc, ProductsState>(
      'Emits [loading, error] - When Exception is thrown',
      build: () => productsBloc,
      setUp: () {
        when(
          () => shoppingRepository.fetchProducts(
            category: mockCategory.name,
          ),
        ).thenThrow(Exception());
      },
      act: (bloc) {
        bloc.add(ProductsFetchedEvent(category: mockCategory));
      },
      expect: () => [
        const ProductsState(productsStatus: ProductsStatus.loading),
        const ProductsState(productsStatus: ProductsStatus.error),
      ],
    );
  });
}
