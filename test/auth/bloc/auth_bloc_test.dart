import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:primarybid_ecommerce_app/auth/bloc/auth_bloc.dart';
import 'package:primarybid_ecommerce_app/auth/domain/auth_repository.dart';
import 'package:primarybid_ecommerce_app/login/bloc/login_bloc.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockLoginBloc extends MockBloc<LoginEvent, LoginState> implements LoginBloc {}

void main() {
  late AuthRepository authRepository;
  late MockLoginBloc mockLoginBloc;

  setUp(() {
    authRepository = MockAuthRepository();
    mockLoginBloc = MockLoginBloc();
  });

  group('AuthBloc', () {
    test('Initial state is AuthState.unknown()', () {
      final authBloc = AuthBloc(
        authRepository: authRepository,
        loginBloc: mockLoginBloc,
      );
      expect(authBloc.state, const AuthState.unknown());
    });

    blocTest<AuthBloc, AuthState>(
      'Emits [loading, success] - Successfully Logged User in',
      build: () {
        whenListen(
          mockLoginBloc,
          Stream.value(const LoginState(status: FormStatus.success)),
        );
        return AuthBloc(authRepository: authRepository, loginBloc: mockLoginBloc);
      },
      expect: () => [
        const AuthState.authenticated(),
      ],
    );
  });
}
