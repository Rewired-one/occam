import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/authentication/application/auth/auth_cubit.dart';
import 'package:mobile/features/navigation/presentation/navigation.dart';

class RecoveryPhraseScreen extends StatelessWidget {
  const RecoveryPhraseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passphrase = context.read<AuthCubit>().state.user?.appWallet.mneumonic.split(' ');
    print(passphrase);
    final list1 = passphrase!.sublist(0, 3);
    print(list1);
    final list2 = passphrase.sublist(3, 6);
    print(list2);
    final list3 = passphrase.sublist(6, 9);
    print(list3);
    final list4 = passphrase.sublist(9, 12);

    final list = [list1, list2, list3, list4];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF212121),
              Color(0xFF171717),
              Color(0xFF212121),
            ],
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            const SafeArea(child: SizedBox.shrink()),
            Text(
              'Recovery Phrase',
              style: GoogleFonts.dmSans(
                textStyle: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.normal,
                  color: Color(
                    0xFFCB4EE8,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 330,
              child: Text(
                'Please write these words down in the order shown and store them somewhere safe.',
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 330,
              child: Text(
                'This phrase is the only way to recover your account!',
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            for (final phrases in list)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (final word in phrases)
                      Expanded(
                        child: Text(
                          word,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.purpleAccent,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            const SizedBox(height: 100),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 75),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(99, 99, 99, .1),
                  elevation: 0,
                  onPrimary: Colors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                onPressed: () =>
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const NavigationScreen())),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
