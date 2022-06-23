import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mobile2/features/authentication/domain/app_user.dart';
import 'package:mobile2/features/authentication/infrastructure/authentication_repo.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthState> {
  AuthenticationCubit(this.authenticationRepository) : super(const AuthState(status: AuthStatus.initial));
  final AuthenticationRepository authenticationRepository;

  Future<void> checkUserHasSignedUp() async {
    await Future.delayed(const Duration(seconds: 3));
    final user = await authenticationRepository.checkUserHasSignedUp();
    if (user != null) {
      emit(const AuthState(status: AuthStatus.userSignIn));
    } else {
      emit(const AuthState(status: AuthStatus.userSignUp));
    }
  }

  Future<void> signIn(String password) async {
    emit(const AuthState(status: AuthStatus.userSignIn, cubitLoading: true));
    final response = await authenticationRepository.signIn(password);
    response.fold(
      (l) => emit(
        AuthState(status: AuthStatus.userSignIn, errorMessage: l),
      ),
      (r) => emit(
        AuthState(status: AuthStatus.authenticated, appUser: r),
      ),
    );
  }

  Future<void> signOut() async {
    await authenticationRepository.logout();
    emit(const AuthState(status: AuthStatus.userSignIn));
  }
}
