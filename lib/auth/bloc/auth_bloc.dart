import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:primarybid_ecommerce_app/auth/domain/auth_repository.dart';
import 'package:primarybid_ecommerce_app/login/bloc/login_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final LoginBloc loginBloc;
  late final StreamSubscription subscription;

  AuthBloc({
    required this.authRepository,
    required this.loginBloc,
  }) : super(const AuthState.unknown()) {
    on<AuthStatusChangedEvent>(_mapAuthStatusChangedToEvent);
    on<AuthCheckedEvent>(_mapAuthCheckedToEvent);
    subscription = loginBloc.stream.listen((state) {
      if (state.status == FormStatus.success) {
        add(const AuthStatusChangedEvent(AuthStatus.authenticated));
      }
    });
  }

  void _mapAuthStatusChangedToEvent(
    AuthStatusChangedEvent event,
    Emitter<AuthState> emit,
  ) async {
    switch (event.authStatus) {
      case AuthStatus.authenticated:
        emit(const AuthState.authenticated());
        break;
      case AuthStatus.unauthenticated:
        emit(const AuthState.unauthenticated());
        break;
      default:
        emit(const AuthState.unknown());
        break;
    }
  }

  void _mapAuthCheckedToEvent(
    AuthCheckedEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      var isLoggedIn = authRepository.isUserLoggedIn();
      if (isLoggedIn) {
        emit(const AuthState.authenticated());
      } else {
        emit(const AuthState.unauthenticated());
      }
    } catch (e) {
      emit(const AuthState.unauthenticated());
    }
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
