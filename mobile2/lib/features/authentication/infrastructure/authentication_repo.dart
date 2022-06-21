import 'package:mobile2/features/authentication/domain/i_auth_facade.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepo implements IAuthFacade {
  @override
  Future<String?> checkUserHasSignedUp() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? hasSignedUp = prefs.getBool('hasSignedUp');
    if (hasSignedUp ?? false) {
      final String? userAccount = prefs.getString('userAccount');
      return userAccount;
    } else {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    // TODO: implement logout
  }

  @override
  Future<bool> signIn() async {
    return false;
  }

  @override
  Future<bool> signUp() async {
    return true;
  }
}
