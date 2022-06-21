import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mobile2/features/authentication/domain/app_user.dart';
import 'package:mobile2/features/authentication/infrastructure/authentication_repo.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthState> {
  AuthenticationCubit(this.authenticationRepository) : super(AuthState(status: AuthStatus.initial));
  final AuthenticationRepository authenticationRepository;

  void checkUserHasSignedUp() async {
    await Future.delayed(const Duration(seconds: 3));
    final user = await authenticationRepository.checkUserHasSignedUp();
    if (user != null) {
      emit(AuthState(status: AuthStatus.userSignIn));
    } else {
      emit(AuthState(status: AuthStatus.userSignUp));
    }
  }
}
