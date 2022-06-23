import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile2/constants/colors.dart';

enum TermsAgreement { agree, disagree }

class CreatePasswordScreen extends StatelessWidget {
  CreatePasswordScreen({Key? key}) : super(key: key);

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verifyPasswordController = TextEditingController();
  final ValueNotifier<TermsAgreement> terms = ValueNotifier(TermsAgreement.agree);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
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
                  // TODO: Create Text Field Widget
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Create',
                      labelStyle: TextStyle(
                        fontSize: 13,
                        color: AppTheme.inactive,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _verifyPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm',
                      labelStyle: TextStyle(
                        fontSize: 13,
                        color: AppTheme.inactive,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder(
                          valueListenable: terms,
                          builder: (BuildContext context, TermsAgreement value, Widget? widget) {
                            return Radio(
                              value: TermsAgreement.agree,
                              groupValue: value,
                              onChanged: (TermsAgreement? value) {
                                print(value);
                                terms.value = value!;
                              },
                            );
                          }),
                      const Text('I agree to Terms of Service')
                    ],
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 250,
                    child: MaterialButton(
                      onPressed: () {},
                      color: const Color.fromRGBO(99, 99, 99, 0.1),
                      textColor: const Color(0xFFCB4EE8),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      child: Text(
                        'Continue',
                        style: GoogleFonts.dmSans(
                          fontSize: 19,
                          color: AppTheme.inactive,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
