part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String username;
  final String password;
  final FormStatus status;

  const LoginState({
    this.username = '',
    this.password = '',
    this.status = FormStatus.initial,
  });

  LoginState copyWith({
    String? username,
    String? password,
    FormStatus? status,
    User? user,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [username, password, status];
}

enum FormStatus {
  initial,
  success,
  loading,
  failed,
}
