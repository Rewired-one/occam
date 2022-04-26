import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// A User's wallet which store's SOL and Signs Transactions
abstract class IWallet {
  late final String name;
  late final String pubKey;
  late final String privKey;

  /// Private Keypair Blob
  // late final Uint8List privKeyPair;

  /// A Mneumonic Passphrase 12 - 24 words
  late final String mneumonic;

  /// Update the wallets name
  Future<void> updateName(String name);

  /// Destroy the wallet permanently
  Future<void> destroy();

  /// Signs a transactions
  Future<void> sign();

  /// Requests a payment from a user
  Future<void> requestPayment();
}

class Wallet implements IWallet {
  Wallet({
    required this.mneumonic,
    required this.name,
    required this.privKey,
    required this.pubKey,
    // required this.privKeyPair,
  });

  // @override
  // Uint8List privKeyPair;

  @override
  String mneumonic;

  @override
  String name;

  @override
  String privKey;

  @override
  String pubKey;

  @override
  Future<void> destroy() {
    // TODO: implement destroy
    throw UnimplementedError();
  }

  @override
  Future<void> requestPayment() {
    // TODO: implement requestPayment
    throw UnimplementedError();
  }

  @override
  Future<void> sign() {
    // TODO: implement sign
    throw UnimplementedError();
  }

  @override
  Future<void> updateName(String name) {
    // TODO: implement updateName
    throw UnimplementedError();
  }

  @override
  String toString() {
    return 'Wallet(mneumonic: $mneumonic, name: $name, privKey: $privKey, pubKey: $pubKey)';
  }

  factory Wallet.fromSnapshot(Map<String, dynamic> doc) {
    print(doc['priv_key_array']);
    return Wallet(
      mneumonic: doc['mneumonic'],
      name: doc['name'],
      privKey: doc['priv_key'],
      pubKey: doc['pub_key'],
      // privKeyPair: doc['priv_key_array'],
    );
  }
}
