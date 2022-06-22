import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile2/constants/colors.dart';

class CreatePasswordScreen extends StatelessWidget {
  const CreatePasswordScreen({Key? key}) : super(key: key);

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
                  TextFormField(),
                  const SizedBox(height: 20),
                  TextFormField(),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Radio(value: 0, groupValue: 0, onChanged: (value) {}),
                      Text('I agree to Terms of Service')
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
