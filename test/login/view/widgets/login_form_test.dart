import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primarybid_ecommerce_app/login/bloc/login_bloc.dart';
import 'package:primarybid_ecommerce_app/login/view/widgets/login_form.dart';
import 'package:mocktail/mocktail.dart';
import 'package:primarybid_ecommerce_app/widgets/themed_button.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState> implements LoginBloc {}

void main() {
  group('LoginForm', () {
    late LoginBloc loginBloc;

    setUp(() {
      loginBloc = MockLoginBloc();
    });

    testWidgets('Check we have correct widgets rendered in LoginForm', (tester) async {
      when(() => loginBloc.state).thenReturn(const LoginState());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: loginBloc,
              child: const LoginForm(),
            ),
          ),
        ),
      );

      expect(
        find.descendant(
          of: find.byKey(const Key('text_input_username')),
          matching: find.byType(TextFormField),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byKey(const Key('text_input_password')),
          matching: find.byType(TextFormField),
        ),
        findsOneWidget,
      );
      expect(find.byType(ThemedButton), findsOneWidget);
    });

    testWidgets(
      'adds LoginUsernameChanged to LoginBloc when username is updated',
      (tester) async {
        const username = 'username';
        when(() => loginBloc.state).thenReturn(const LoginState());
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: loginBloc,
                child: const LoginForm(),
              ),
            ),
          ),
        );
        await tester.enterText(
          find.byKey(const Key('text_input_username')),
          username,
        );
        verify(
          () => loginBloc.add(const LoginUsernameChanged(username: username)),
        ).called(1);
      },
    );

    testWidgets(
      'adds LoginPasswordChanged to LoginBloc when password is updated',
      (tester) async {
        const password = 'secretPassword';
        when(() => loginBloc.state).thenReturn(const LoginState());
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BlocProvider.value(
                value: loginBloc,
                child: const LoginForm(),
              ),
            ),
          ),
        );
        await tester.enterText(
          find.byKey(const Key('text_input_password')),
          password,
        );
        verify(
          () => loginBloc.add(const LoginPasswordChanged(password: password)),
        ).called(1);
      },
    );

    testWidgets('LoginSubmitted not dispatched as text fields are empty', (tester) async {
      when(() => loginBloc.state).thenReturn(const LoginState());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: loginBloc,
              child: const LoginForm(),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(ThemedButton));
      verifyNever(() => loginBloc.add(LoginSubmitted()));
    });

    testWidgets('LoginSubmitted displays validation error on empty input', (tester) async {
      when(() => loginBloc.state).thenReturn(const LoginState());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: loginBloc,
              child: const LoginForm(),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(ThemedButton));
      await tester.pumpAndSettle();
      Finder emptyUsername = find.textContaining('Username cannot be empty');
      Finder emptyPassword = find.textContaining('Password cannot be empty');
      expect(emptyUsername, findsOneWidget);
      expect(emptyPassword, findsOneWidget);
    });

    testWidgets('LoginSubmitted displays validation error on input < 5 characters', (tester) async {
      const username = 'test';
      const password = 'pass';
      when(() => loginBloc.state).thenReturn(const LoginState(
        username: username,
        password: password,
      ));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: loginBloc,
              child: const LoginForm(),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(ThemedButton));
      await tester.pumpAndSettle();
      Finder emptyUsername = find.textContaining('Username must contain 5 or more characters');
      Finder emptyPassword = find.textContaining('Password must contain 5 or more characters');
      expect(emptyUsername, findsOneWidget);
      expect(emptyPassword, findsOneWidget);
    });

    testWidgets('LoginSubmitted fires as validation passes', (tester) async {
      const username = 'testUser';
      const password = 'password';
      when(() => loginBloc.state).thenReturn(const LoginState(
        username: username,
        password: password,
      ));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: loginBloc,
              child: const LoginForm(),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(ThemedButton));
      await tester.pumpAndSettle();
      verify(() => loginBloc.add(LoginSubmitted())).called(1);
    });

    testWidgets('shows SnackBar when status is submission failure', (tester) async {
      whenListen(
        loginBloc,
        Stream.fromIterable([
          const LoginState(status: FormStatus.loading),
          const LoginState(status: FormStatus.failed),
        ]),
      );
      when(() => loginBloc.state).thenReturn(const LoginState(
        status: FormStatus.failed,
      ));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: loginBloc,
              child: const LoginForm(),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('shows CircularProgressIndicator when status is submission loading', (tester) async {
      whenListen(
        loginBloc,
        Stream.fromIterable([
          const LoginState(status: FormStatus.loading),
        ]),
      );
      when(() => loginBloc.state).thenReturn(const LoginState(
        status: FormStatus.loading,
      ));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: loginBloc,
              child: const LoginForm(),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
