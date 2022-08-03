import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:occam/firebase_options.dart';
import 'package:occam/features/authentication/presentation/sign_in.dart';
import 'package:occam/features/authentication/presentation/sign_up.dart';
import 'package:occam/features/occam/application/balance/balance_cubit.dart';
import 'package:occam/features/occam/infrastructure/balance_repository.dart';
import 'package:occam/features/main_navigation/presentation/main_navigation.dart';
import 'package:occam/features/authentication/infrastructure/authentication_repo.dart';
import 'package:occam/features/authentication/infrastructure/create_wallet_repo.dart';
import 'package:occam/features/authentication/presentation/check_authentication.dart';
import 'package:occam/features/authentication/presentation/create_wallet/password.dart';
import 'package:occam/features/authentication/presentation/create_wallet/create_wallet.dart';
import 'package:occam/features/authentication/application/auth_cubit/authentication_cubit.dart';
import 'package:occam/features/authentication/application/create_wallet_cubit/create_wallet_cubit.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthenticationCubit(AuthenticationRepository())),
        BlocProvider(create: (_) => CreateWalletCubit(CreateWalletRepository())),
        BlocProvider(create: (_) => BalanceCubit(BalanceRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Occam Wallet Flutter',
        theme: ThemeData.dark(),
        routes: {
          '/': (context) => const CheckAuthentication(),
          '/sign_in': (context) => const SignInScreen(),
          '/sign_up': (context) => const SignUpScreen(),
          '/create_wallet': (context) => const CreateWallet(),
          '/create_password': ((context) => const CreatePasswordScreen()),
          '/main': ((context) => MainNavigationScreen())
        },
      ),
    );
  }
}
