import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile/features/authentication/domain/user/user.dart';
import 'package:mobile/features/authentication/infrastructure/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  
  AuthCubit(this.authRepository) : super(AuthInitial());
  
  final AuthRepository authRepository;


}
