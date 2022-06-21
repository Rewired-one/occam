import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile2/constants/colors.dart';
import 'package:mobile2/features/authentication/application/create_wallet_cubit/create_wallet_cubit.dart';

class RecoveryPhraseScreen extends StatelessWidget {
  const RecoveryPhraseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recoveryCode = context.read<CreateWalletCubit>().state.recoveryCode;
    final List<String> codeList = recoveryCode!.split(' ');

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
                  height: constraints.maxHeight * .25,
                ),
                Text(
                  'Recovery Phrase',
                  style: GoogleFonts.dmSans(
                    fontSize: 19,
                    color: AppTheme.purple,
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 29),
                  child: Text(
                    'Physically write these words down in the order shown and place them somewhere safe.',
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      color: const Color(0xFFE7E7E7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 29),
                  child: Text(
                    'This phrase is the only way to recover your account.',
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      color: const Color(0xFFFFD83D),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
