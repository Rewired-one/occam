import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: () {},
                          color: const Color.fromRGBO(99, 99, 99, 0.1),
                          textColor: const Color(0xFFCB4EE8),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          child: const Text('Recovery Phrase'),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: () {},
                          color: const Color.fromRGBO(99, 99, 99, 0.1),
                          textColor: const Color(0xFFCB4EE8),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          child: const Text('Create Wallet'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SafeArea(
                  child: SizedBox.shrink(),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
