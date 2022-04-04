abstract class IAddressEntry {
  late String id;
  late String entryName;
  late String entryEmail;
  late String entryPubKey;
  late String entryNotes;
  late String entryProfilePic;
  Future<void> update(String type, String value);
}