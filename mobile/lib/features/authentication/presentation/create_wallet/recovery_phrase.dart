import 'package:flutter/material.dart';
import 'package:mobile2/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mobile2/features/authentication/application/create_wallet_cubit/create_wallet_cubit.dart';

class RecoveryPhraseScreen extends StatelessWidget {
  const RecoveryPhraseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recoveryCode = context.read<CreateWalletCubit>().state.recoveryCode;
    final List<String> codeList = recoveryCode!.split(' ');
    final list1 = codeList.sublist(0, 3);
    final list2 = codeList.sublist(3, 6);
    final list3 = codeList.sublist(6, 9);
    final list4 = codeList.sublist(9, 12);

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
                SizedBox(
                  height: constraints.maxHeight * .075,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var i = 0; i < list1.length; i++)
                        SizedBox(
                          width: constraints.maxWidth * .25,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${i + 1}. ',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 15,
                                    color: AppTheme.purple,
                                  ),
                                ),
                                TextSpan(
                                  text: list1[i],
                                  style: GoogleFonts.dmSans(
                                    fontSize: 15,
                                    color: AppTheme.primary,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var i = 0; i < list2.length; i++)
                        SizedBox(
                          width: constraints.maxWidth * .25,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${i + 4}. ',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 15,
                                    color: AppTheme.purple,
                                  ),
                                ),
                                TextSpan(
                                  text: list2[i],
                                  style: GoogleFonts.dmSans(
                                    fontSize: 15,
                                    color: AppTheme.primary,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var i = 0; i < list2.length; i++)
                        SizedBox(
                          width: constraints.maxWidth * .25,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${i + 7}. ',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 15,
                                    color: AppTheme.purple,
                                  ),
                                ),
                                TextSpan(
                                  text: list3[i],
                                  style: GoogleFonts.dmSans(
                                    fontSize: 15,
                                    color: AppTheme.primary,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var i = 0; i < list2.length; i++)
                        SizedBox(
                          width: constraints.maxWidth * .25,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${i + 10}. ',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 15,
                                    color: AppTheme.purple,
                                  ),
                                ),
                                TextSpan(
                                  text: list4[i],
                                  style: GoogleFonts.dmSans(
                                    fontSize: 15,
                                    color: AppTheme.primary,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 39),
                // TODO: Create Button Widget
                SizedBox(
                  width: 250,
                  child: MaterialButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamedAndRemoveUntil('/create_password', (route) => false),
                    color: const Color.fromRGBO(99, 99, 99, 0.1),
                    textColor: const Color(0xFFCB4EE8),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: Text(
                      'Continue',
                      style: GoogleFonts.dmSans(
                        fontSize: 19,
                        color: AppTheme.purple,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
