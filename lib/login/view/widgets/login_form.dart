import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:primarybid_ecommerce_app/utils/extensions/string_extension.dart';
import 'package:primarybid_ecommerce_app/widgets/spacer.dart';
import 'package:primarybid_ecommerce_app/widgets/themed_button.dart';
import 'package:primarybid_ecommerce_app/widgets/themed_text.dart';
import 'package:primarybid_ecommerce_app/widgets/themed_text_field.dart';
import '../../bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == FormStatus.failed) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const ThemedText(
              text: 'Login',
              themeTextType: ThemeTextType.h1,
              fontColor: Colors.black,
            ),
            const VSpacer(15.0),
            const ThemedText(
              text: 'Sign into your account by entering your information below',
              themeTextType: ThemeTextType.body,
              fontColor: Color.fromARGB(255, 62, 62, 62),
            ),
            const VSpacer(40.0),
            _usernameField(),
            const VSpacer(25.0),
            _passwordField(),
            const VSpacer(40.0),
            _loginButton(_formKey),
          ],
        ),
      ),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return ThemedTextFormField(
          key: const Key('text_input_username'),
          hintText: 'Username',
          validator: (username) => state.username.isValidInput('Username'),
          onChanged: (username) => context.read<LoginBloc>().add(LoginUsernameChanged(username: username)),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return ThemedTextFormField(
          key: const Key('text_input_password'),
          hintText: 'Password',
          obscureText: true,
          validator: (password) => state.password.isValidInput('Password'),
          onChanged: (password) => context.read<LoginBloc>().add(LoginPasswordChanged(password: password)),
        );
      },
    );
  }

  Widget _loginButton(GlobalKey<FormState> _formKey) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return ThemedButton(
          state.status == FormStatus.loading
              ? const CircularProgressIndicator(
                  color: Colors.black,
                )
              : const ThemedText(
                  text: 'Login',
                  themeTextType: ThemeTextType.button,
                  fontColor: Color.fromARGB(255, 255, 255, 255),
                ),
          key: const Key('loginForm_login_themedButton'),
          width: double.maxFinite,
          backgroundColor: const Color.fromRGBO(126, 140, 247, 1),
          onClick: () {
            if (_formKey.currentState!.validate() && state.status != FormStatus.loading) {
              context.read<LoginBloc>().add(LoginSubmitted());
            }
          },
        );
      },
    );
  }
}
