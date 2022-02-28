import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:primarybid_ecommerce_app/auth/domain/auth_repository.dart';
import 'package:primarybid_ecommerce_app/login/bloc/login_bloc.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;
  late LoginBloc loginBloc;

  setUp(() {
    authRepository = MockAuthRepository();
    loginBloc = LoginBloc(
      authRepository: authRepository,
    );
  });

  group('LoginBLoc', () {
    test('Initial state is LoginState with FormStatus.initial', () {
      final loginBloc = LoginBloc(
        authRepository: authRepository,
      );
      expect(loginBloc.state, const LoginState(status: FormStatus.initial));
    });

    blocTest<LoginBloc, LoginState>(
      'Emits [loading, success] - Successfully Logged User in',
      build: () => loginBloc,
      act: (bloc) {
        bloc.add(const LoginUsernameChanged(username: 'username'));
        bloc.add(const LoginPasswordChanged(password: 'password'));
        bloc.add(LoginSubmitted());
      },
      setUp: () {
        when(
          () => authRepository.login(
            username: 'username',
            password: 'password',
          ),
        ).thenAnswer((_) async => 'user');
      },
      expect: () => [
        const LoginState(username: 'username', status: FormStatus.initial),
        const LoginState(username: 'username', password: 'password', status: FormStatus.initial),
        const LoginState(username: 'username', password: 'password', status: FormStatus.loading),
        const LoginState(username: 'username', password: 'password', status: FormStatus.success)
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'Emits [loading, failed] - Unsuccessful Login attempt',
      build: () => loginBloc,
      act: (bloc) {
        bloc.add(const LoginUsernameChanged(username: 'username'));
        bloc.add(const LoginPasswordChanged(password: 'password'));
        bloc.add(LoginSubmitted());
      },
      setUp: () {
        when(
          () => authRepository.login(
            username: 'username',
            password: 'password',
          ),
        ).thenThrow(Exception('Error'));
      },
      expect: () => [
        const LoginState(username: 'username', status: FormStatus.initial),
        const LoginState(username: 'username', password: 'password', status: FormStatus.initial),
        const LoginState(username: 'username', password: 'password', status: FormStatus.loading),
        const LoginState(username: 'username', password: 'password', status: FormStatus.failed)
      ],
    );
  });
}
