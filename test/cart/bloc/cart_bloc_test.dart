import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:primarybid_ecommerce_app/cart/bloc/cart_bloc.dart';
import '../../../packages/shopping/shopping.dart';

class MockShoppingRepository extends Mock implements ShoppingRepository {}

void main() {
  late ShoppingRepository shoppingRepository;
  late CartBloc cartBloc;
  late Product mockProduct;

  setUp(() {
    shoppingRepository = MockShoppingRepository();
    cartBloc = CartBloc(
      shoppingRepository: shoppingRepository,
    );
    mockProduct = Product(
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
  });

  group('CartBloc', () {
    test('Initial state is CartState with empty product List', () {
      final cartBloc = CartBloc(
        shoppingRepository: shoppingRepository,
      );
      expect(cartBloc.state, const CartState(products: []));
    });

    blocTest<CartBloc, CartState>(
      'Emits [CartState] - With Product successfully added to state',
      build: () => cartBloc,
      act: (bloc) {
        bloc.add(
          CartItemAddedEvent(product: mockProduct),
        );
      },
      expect: () => [
        CartState(products: [mockProduct]),
      ],
    );

    blocTest<CartBloc, CartState>(
      'Emits [CartState] - With Product successfully removed from state',
      build: () => cartBloc,
      seed: () => CartState(products: [mockProduct, mockProduct]),
      act: (bloc) {
        bloc.add(
          CartItemRemovedEvent(product: mockProduct),
        );
      },
      expect: () => [
        CartState(products: [mockProduct]),
      ],
    );
  });
}
