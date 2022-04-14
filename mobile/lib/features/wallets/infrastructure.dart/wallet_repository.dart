import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:mobile/features/wallets/domain/wallet.dart';
import 'package:mobile/features/wallets/domain/i_wallet_facade.dart';

class WalletRepository extends IWalletFacade {
  @override
  Future<Either<List<Wallet>, Unit>> fetchWallets() async {
    try {
      final data = await FirebaseFirestore.instance.collection('test').get();
      print('DATA: ${data.docs.isEmpty}');
      return left([]);
    } catch (error) {
      print('ERROR: $error');
      return right(unit);
    }
  }
}
