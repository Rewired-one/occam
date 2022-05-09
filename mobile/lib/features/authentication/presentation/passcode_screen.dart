import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/authentication/application/auth/auth_cubit.dart';
import 'package:mobile/features/authentication/presentation/passphrase_screen.dart';
import 'package:mobile/features/navigation/presentation/navigation.dart';

class PasscodeScreen extends StatefulWidget {
  const PasscodeScreen({
    Key? key,
    required this.email,
    required this.password,
    required this.displayName,
  }) : super(key: key);

  final String email;
  final String password;
  final String displayName;

  @override
  State<PasscodeScreen> createState() => _PasscodeScreenState();
}

const numberPad = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
  [0]
];

class _PasscodeScreenState extends State<PasscodeScreen> {
  List<int> passcode = [];

  @override
  void initState() {
    super.initState();
    print('EMAIL: ${widget.email}');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
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

        if (state.status == AuthStatus.signUpSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const PassphraseScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.status == AuthStatus.initial) {
          return Scaffold(
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SafeArea(child: SizedBox.shrink()),
                  const Text(
                    'Please Enter a 4 Digit Passcode',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      SizedBox(
                        width: 55,
                        child: Text(
                          passcode.join(''),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.backspace, color: Colors.red[600]),
                          onPressed: () => setState(() {
                            if (passcode.isNotEmpty) {
                              passcode.removeLast();
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  for (final numbers in numberPad)
                    Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (final number in numbers)
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(15),
                              ),
                              onPressed: () => setState(() {
                                if (passcode.length < 4) {
                                  passcode.add(number);
                                }
                              }),
                              child: Text(
                                number.toString(),
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      onPressed: () =>
                          context.read<AuthCubit>().signUp(widget.email, widget.password, widget.displayName, passcode),
                      child: const Text('Register'),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
