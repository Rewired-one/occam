import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mobile/features/wallets/domain/wallet.dart';
import 'package:mobile/features/wallets/domain/i_wallet_facade.dart';

class WalletRepository extends IWalletFacade {
  @override
  Future<Either<List<Wallet>, Unit>> fetchWallets() async {
    try {
      final email = FirebaseAuth.instance.currentUser?.email;
      final data = await FirebaseFirestore.instance.collection('wallets').doc(email).get();

      if (data.exists) {
        final List<Wallet> wallets =
            data.data()!['wallets'].map((wallet) => Wallet.fromSnapshot(wallet)).toList().cast<Wallet>();

        return left(wallets);
      } else {
        throw Exception('Collection Doesnt Exist!');
      }
    } catch (error) {
      print('ERROR: $error');
      return right(unit);
    }
  }

  @override
  Future<Either<Wallet, Unit>> createNewWallet({required String displayName}) {
    // TODO: implement createNewWallet
    throw UnimplementedError();
  }
}
