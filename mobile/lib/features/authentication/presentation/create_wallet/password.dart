import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mobile2/constants/colors.dart';
import 'package:mobile2/widgets/loading_overlay.dart';
import 'package:mobile2/features/authentication/application/create_wallet_cubit/create_wallet_cubit.dart';

enum TermsAgreement { agree, disagree }

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

// TODO: Finish Password Validation Smooth Flow

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verifyPasswordController = TextEditingController();
  final ValueNotifier<bool> _termsIsChecked = ValueNotifier(false);
  bool canSubmit = false;
  bool obscureState = true;
  bool obscureState2 = true;

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _verifyPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubitLoading = context.watch<CreateWalletCubit>().state.status == CreateWalletStatus.loading;

    return BlocListener<CreateWalletCubit, CreateWalletState>(
      listener: (context, state) {
        if (state.status == CreateWalletStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error: ${state.errorMessage}',
                style: GoogleFonts.dmSans(
                  color: AppTheme.red,
                ),
              ),
              backgroundColor: Colors.black45,
              duration: const Duration(seconds: 2),
            ),
          );
        }
        if (state.status == CreateWalletStatus.setPasswordSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
        }
      },
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: constraints.maxHeight * .25,
                          ),
                          // TODO: Create Text Widget
                          Text(
                            'Create password',
                            style: GoogleFonts.dmSans(
                              fontSize: 19,
                              color: AppTheme.purple,
                            ),
                          ),
                          const SizedBox(height: 36),
                          Text(
                            'This is to unlock your Wallet',
                            style: GoogleFonts.dmSans(
                              fontSize: 15,
                              color: AppTheme.primary,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // TODO: Create Text Field Widget
                          TextFormField(
                            controller: _passwordController,
                            obscureText: obscureState2,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureState2 = !obscureState2;
                                  });
                                },
                                icon: Icon(obscureState2 ? Icons.visibility : Icons.visibility_off),
                              ),
                              labelText: 'Create',
                              labelStyle: const TextStyle(
                                fontSize: 13,
                                color: AppTheme.inactive,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            onChanged: (String? value) {
                              if (value?.isEmpty ?? false || _verifyPasswordController.text != value) {
                                setState(
                                  () {
                                    canSubmit = false;
                                  },
                                );
                              }
                              if (value != null &&
                                  value.isNotEmpty &&
                                  _verifyPasswordController.text.isNotEmpty &&
                                  _termsIsChecked.value) {
                                setState(
                                  () {
                                    canSubmit = true;
                                  },
                                );
                              }
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a Password!';
                              }
                              if (value != _verifyPasswordController.text) {
                                return 'Passwords do not match!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _verifyPasswordController,
                            obscureText: obscureState,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureState = !obscureState;
                                  });
                                },
                                icon: Icon(obscureState ? Icons.visibility : Icons.visibility_off),
                              ),
                              labelText: 'Confirm',
                              labelStyle: const TextStyle(
                                fontSize: 13,
                                color: AppTheme.inactive,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            onChanged: (String? value) {
                              if (value?.isEmpty ?? false || _passwordController.text != value) {
                                setState(
                                  () {
                                    canSubmit = false;
                                  },
                                );
                              }
                              if (value != null &&
                                  value.isNotEmpty &&
                                  _passwordController.text.isNotEmpty &&
                                  _termsIsChecked.value &&
                                  _passwordController.text == value) {
                                setState(
                                  () {
                                    canSubmit = true;
                                  },
                                );
                              }
                              if (value == _passwordController.text) {
                                // _formKey.currentState!.reset();
                              }
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a Password!';
                              }
                              if (value != _passwordController.text) {
                                _autovalidateMode = AutovalidateMode.onUserInteraction;
                                return 'Passwords do not match!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ValueListenableBuilder(
                                valueListenable: _termsIsChecked,
                                builder: (context, bool value, Widget? widget) {
                                  return Checkbox(
                                    value: value,
                                    shape: const CircleBorder(),
                                    onChanged: (bool? value) {
                                      _termsIsChecked.value = value!;
                                      if (_passwordController.text.isNotEmpty &&
                                          _verifyPasswordController.text.isNotEmpty &&
                                          value) {
                                        setState(() {
                                          canSubmit = true;
                                        });
                                      }
                                      if (!value) {
                                        setState(() {
                                          canSubmit = false;
                                        });
                                      }
                                    },
                                  );
                                },
                              ),
                              const Text('I agree to Terms of Service')
                            ],
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: 250,
                            child: MaterialButton(
                              onPressed: !canSubmit
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context
                                            .read<CreateWalletCubit>()
                                            .registerWalletWithPassword(_passwordController.text);
                                      }
                                    },
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
                        ],
                      ),
                    ),
                  ),
                ),
                if (cubitLoading) const LoadingOverlayWidget()
              ],
            );
          },
        ),
      ),
    );
  }
}
