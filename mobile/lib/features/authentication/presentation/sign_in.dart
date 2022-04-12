import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile/widgets/input.dart';
import 'package:mobile/widgets/password_input.dart';
import 'package:mobile/features/navigation/presentation/navigation.dart';
import 'package:mobile/features/authentication/application/auth/auth_cubit.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email = '';
  String password = '';

  void signIn() async {
    await context.read<AuthCubit>().signIn(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, AuthState state) {
          if (state.status == AuthStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Error! ${state.authFailure?.message}',
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          }
          if (state.status == AuthStatus.success) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const NavigationScreen(),
              ),
            );
          }
        },
        builder: (context, AuthState state) {
          if (state.status == AuthStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == AuthStatus.success) {
            return const SizedBox(
              width: double.infinity,
              height: double.infinity,
            );
          }
          return Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 200),
                const Text(
                  'Occam Sign In',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Input(
                  labelText: 'Email',
                  onChange: (val) => email = val!,
                ),
                const SizedBox(height: 10),
                PasswordInput(
                  labelText: 'Password',
                  onChange: (val) => password = val!,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: const Color.fromARGB(255, 77, 195, 206),
                      side: const BorderSide(
                        width: 1,
                        color: Colors.blueAccent,
                      ),
                    ),
                    onPressed: () => signIn(),
                    child: const Text('Enter'),
                  ),
                ),
                const SizedBox(height: 20),
                if (state.status == AuthStatus.failure) Text(state.authFailure!.message),
              ],
            ),
          );
        },
      ),
    );
  }
}
