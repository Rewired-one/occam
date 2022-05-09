import 'package:flutter/material.dart';
import 'package:mobile/widgets/input.dart';
import 'package:mobile/widgets/password_input.dart';

import 'package:mobile/features/authentication/presentation/passcode_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email = '';
  String password = '';
  String displayName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 150),
            Input(
              labelText: 'Display Name',
              onChange: (val) {},
            ),
            const SizedBox(height: 10),
            Input(
              labelText: 'Email',
              onChange: (val) {},
            ),
            const SizedBox(height: 10),
            PasswordInput(
              labelText: 'Password',
              onChange: (val) {},
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
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PasscodeScreen(
                      email: email,
                      password: password,
                      displayName: displayName,
                    ),
                  ),
                ),
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
