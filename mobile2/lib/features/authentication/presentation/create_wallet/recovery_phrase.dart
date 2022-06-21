import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile2/features/authentication/application/create_wallet_cubit/create_wallet_cubit.dart';

class RecoveryPhraseScreen extends StatelessWidget {
  const RecoveryPhraseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recoveryCode = context.read<CreateWalletCubit>().state.recoveryCode;
    return Scaffold(
      body: Center(child: Text(recoveryCode!)),
    );
  }
}
