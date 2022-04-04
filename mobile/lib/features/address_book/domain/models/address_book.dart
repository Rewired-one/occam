import 'package:mobile/features/address_book/domain/models/address_entry.dart';

abstract class IAddressBook {
  late List<IAddressEntry> addresses;
  Future<void> addAddress();
  Future<void> removeAddress();
  Future<void> shareAddress();
}