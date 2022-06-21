import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile2/features/authentication/application/auth_cubit/authentication_cubit.dart';
import 'package:mobile2/features/authentication/presentation/sign_up.dart';

import 'package:mobile2/features/authentication/presentation/splash_screen.dart';

class CheckAuthentication extends StatefulWidget {
  const CheckAuthentication({Key? key}) : super(key: key);

  @override
  State<CheckAuthentication> createState() => _CheckAuthenticationState();
}

class _CheckAuthenticationState extends State<CheckAuthentication> {
  @override
  void initState() {
    context.read<AuthenticationCubit>().checkUserHasSignedUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error) {}
      },
      builder: (context, state) {
        switch (state.status) {
          case AuthStatus.initial:
            return const SplashScreen();
          case AuthStatus.loading:
            return Container();
          case AuthStatus.authenticated:
            return Container();
          case AuthStatus.userSignIn:
            return Container();
          case AuthStatus.userSignUp:
            return const SignUpScreen();
          default:
            return const SplashScreen();
        }
      },
    );
  }
}
