import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/authentication/application/auth/auth_cubit.dart';

class PassphraseScreen extends StatelessWidget {
  const PassphraseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passphrase = context.read<AuthCubit>().state.user?.appWallet.mneumonic.split(' ');
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SafeArea(child: SizedBox.shrink()),
            Text('Recovery Phrase'),
          ],
        ),
      ),
    );
  }
}
