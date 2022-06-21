import 'package:bloc/bloc.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthState> {
  AuthenticationCubit() : super(AuthState(status: AuthStatus.initial));
}
