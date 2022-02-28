import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:primarybid_ecommerce_app/auth/domain/auth_repository.dart';
import 'package:primarybid_ecommerce_app/login/bloc/login_bloc.dart';
import 'package:primarybid_ecommerce_app/login/view/login.dart';
import 'package:primarybid_ecommerce_app/login/view/widgets/login_form.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState> implements LoginBloc {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockLoginBloc mockLoginBloc;
  late AuthRepository authRepository;

  setUp(() {
    mockLoginBloc = MockLoginBloc();
    authRepository = MockAuthRepository();
  });

  test('is routable', () {
    expect(LoginPage.route(), isA<MaterialPageRoute>());
  });

  testWidgets('Renders login form', (WidgetTester tester) async {
    when(() => mockLoginBloc.state).thenReturn(const LoginState());
    await tester.pumpWidget(
      RepositoryProvider.value(
        value: authRepository,
        child: BlocProvider<LoginBloc>(
          create: (context) => mockLoginBloc,
          child: MaterialApp(
            home: Scaffold(
              body: LoginPage(),
            ),
          ),
        ),
      ),
    );
    expect(find.byType(LoginForm), findsOneWidget);
  });
}
