import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:primarybid_ecommerce_app/auth/bloc/auth_bloc.dart';
import 'package:primarybid_ecommerce_app/auth/domain/auth_repository.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({
    required this.authRepository,
  }) : super(const LoginState()) {
    on<LoginUsernameChanged>(
      (event, emit) => emit(state.copyWith(username: event.username, status: FormStatus.initial)),
    );
    on<LoginPasswordChanged>(
      (event, emit) => emit(state.copyWith(password: event.password, status: FormStatus.initial)),
    );
    on<LoginSubmitted>(_mapLoginToState);
  }

  void _mapLoginToState(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    try {
      await authRepository.login(
        username: state.username,
        password: state.password,
      );
      emit(state.copyWith(status: FormStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormStatus.failed));
    }
  }
}
