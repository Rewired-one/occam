import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/features/authentication/domain/user/user.dart';
import 'package:mobile/features/authentication/domain/auth/auth_failure.dart';
import 'package:mobile/features/authentication/infrastructure/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState(status: AuthStatus.initial));

  final AuthRepository authRepository;

  Future<void> signIn(String email, String password) async {
    emit(AuthState(status: AuthStatus.loading));
    final response = await authRepository.signInWithEmailAndPassword(email: email, password: password);
    response.fold((l) {
      return emit(AuthState(status: AuthStatus.failure, authFailure: l));
    }, (r) async {
      return emit(AuthState(status: AuthStatus.success, user: r));
    });
  }

  Future<void> signOut() async {
    await authRepository.logout();
    emit(AuthState(status: AuthStatus.initial));
  }

  /// Fetches a user based on their email address. Calling this should only happen if authentication has been persisted
  /// and user is already signed in.
  Future<void> fetchUser() async {
    emit(AuthState(status: AuthStatus.loading));

    final email = FirebaseAuth.instance.currentUser?.email;
    final appUser = await authRepository.fetchUser(email!);

    if (appUser != null) {
      emit(AuthState(status: AuthStatus.success, user: appUser));
    } else {
      emit(AuthState(status: AuthStatus.failure));
    }
  }

  Future<void> signUp(String email, String password, String displayName, List<int> passcode) async {
    emit(AuthState(status: AuthStatus.loading));
    final response = await authRepository.signUpWithEmailAndPassword(
        email: email, password: password, displayName: displayName, passcode: passcode);
    response.fold(
      (l) => emit(
        AuthState(status: AuthStatus.failure),
      ),
      (r) => emit(
        AuthState(status: AuthStatus.success, user: r),
      ),
    );
  }
}
