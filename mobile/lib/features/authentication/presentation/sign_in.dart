import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:occam/widgets/input.dart';
import 'package:occam/constants/colors.dart';
import 'package:occam/widgets/loading_overlay.dart';
import 'package:occam/features/authentication/application/auth_cubit/authentication_cubit.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool canLogin = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubitLoading = context.watch<AuthenticationCubit>().state.cubitLoading;

    return BlocListener<AuthenticationCubit, AuthState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          setState(() {
            canLogin = false;
          });
          _formKey.currentState!.validate();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage!,
                style: GoogleFonts.dmSans(
                  color: AppTheme.red,
                ),
              ),
              backgroundColor: Colors.black45,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Container(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF212121),
                          Color(0xFF171717),
                          Color(0xFF212121),
                        ],
                        stops: [
                          0,
                          56.25,
                          100,
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: constraints.maxHeight * .2,
                        ),
                        Text(
                          'occam',
                          style: GoogleFonts.dmSans(fontSize: 49),
                        ),
                        Text(
                          'Crypto wallet for solana ecosystem',
                          style: GoogleFonts.dmSans(fontSize: 15, color: const Color(0xFF7C7C7C)),
                        ),
                        SizedBox(height: constraints.maxHeight * .175),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: InputWidget(
                            controller: _controller,
                            labelText: 'Password',
                            obscureText: true,
                            onChanged: (String? value) {
                              // TODO: Optimize for less setState
                              if (value != null && value.isNotEmpty) {
                                setState(() {
                                  canLogin = true;
                                });
                              } else {
                                setState(() {
                                  canLogin = false;
                                });
                              }
                            },
                            validator: (String? value) {
                              if (!canLogin) {
                                return 'Invalid Password!';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * .1),
                        SizedBox(
                          width: 250,
                          child: MaterialButton(
                            onPressed:
                                !canLogin ? null : () => context.read<AuthenticationCubit>().signIn(_controller.text),
                            disabledColor: const Color.fromRGBO(99, 99, 99, 0.1),
                            disabledTextColor: AppTheme.inactive,
                            color: const Color.fromRGBO(99, 99, 99, 0.1),
                            textColor: const Color(0xFFCB4EE8),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            child: Text(
                              'Continue',
                              style: GoogleFonts.dmSans(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SafeArea(
                          child: SizedBox.shrink(),
                        )
                      ],
                    ),
                  ),
                ),
                if (cubitLoading ?? false) const LoadingOverlayWidget()
              ],
            );
          },
        ),
      ),
    );
  }
}
