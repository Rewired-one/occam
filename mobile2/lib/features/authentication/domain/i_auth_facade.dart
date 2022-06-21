abstract class IAuthFacade {
  Future<String?> checkUserHasSignedUp();
  Future<bool> signUp();
  Future<bool> signIn();
  Future<void> logout();
}
