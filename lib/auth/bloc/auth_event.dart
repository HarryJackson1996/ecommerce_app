part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStatusChangedEvent extends AuthEvent {
  const AuthStatusChangedEvent(this.authStatus);
  final AuthStatus authStatus;

  @override
  List<Object> get props => [authStatus];
}

class AuthCheckedEvent extends AuthEvent {}
