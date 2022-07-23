import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile2/features/authentication/application/create_wallet_cubit/create_wallet_cubit.dart';
import 'package:mobile2/features/authentication/presentation/create_wallet/recovery_phrase.dart';

class CreateWallet extends StatefulWidget {
  const CreateWallet({Key? key}) : super(key: key);

  @override
  State<CreateWallet> createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> {
  @override
  void initState() {
    context.read<CreateWalletCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateWalletCubit, CreateWalletState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.status) {
          case CreateWalletStatus.initial:
            return const Scaffold();
          case CreateWalletStatus.loading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFCB4EE8)),
                ),
              ),
            );
          case CreateWalletStatus.error:
            return Container();
          case CreateWalletStatus.recoveryPhrase:
            return const RecoveryPhraseScreen();
          case CreateWalletStatus.setPasswordSuccess:
            return Container();
        }
      },
    );
  }
}
