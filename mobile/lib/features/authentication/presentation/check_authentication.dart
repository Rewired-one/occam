import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile2/features/authentication/application/auth_cubit/authentication_cubit.dart';
import 'package:mobile2/features/authentication/presentation/sign_in.dart';
import 'package:mobile2/features/authentication/presentation/sign_up.dart';

import 'package:mobile2/features/authentication/presentation/splash_screen.dart';
import 'package:mobile2/features/main_navigation/presentation/main_navigation.dart';

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
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          return MainNavigationScreen();
        }
        if (state.status == AuthStatus.userSignIn) {
          return const SignInScreen();
        }
        if (state.status == AuthStatus.userSignUp) {
          return const SignUpScreen();
        }
        return const SplashScreen();
      },
    );
  }
}
