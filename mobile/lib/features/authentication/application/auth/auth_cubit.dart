import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile/features/authentication/domain/user/user.dart';
import 'package:mobile/features/authentication/infrastructure/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthInitial());

  final AuthRepository authRepository;

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    final response = await authRepository.signInWithEmailAndPassword(email: email, password: password);
    response.fold((l) {
      return emit(AuthError(l.message));
    }, (r) async {
      return emit(AuthSuccess(user: r));
    });
  }
}
