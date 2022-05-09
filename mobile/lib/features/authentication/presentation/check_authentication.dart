import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/authentication/application/auth/auth_cubit.dart';

import 'package:mobile/features/authentication/presentation/sign_in.dart';
import 'package:mobile/features/navigation/presentation/navigation.dart';

class CheckAuthentication extends StatefulWidget {
  const CheckAuthentication({Key? key}) : super(key: key);

  @override
  State<CheckAuthentication> createState() => _CheckAuthenticationState();
}

class _CheckAuthenticationState extends State<CheckAuthentication> {
  late User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;

    // get the user before moving to navigation screen
    if (user != null) {
      context.read<AuthCubit>().fetchUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        // User is not logged in
        if (user == null) {
          return const SignInScreen();
        }
        // User authentication persisted. User is logged in.
        if (state.user == null) {
          return const Scaffold(
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return const NavigationScreen();
      },
    );
  }
}
