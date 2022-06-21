import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile2/features/authentication/application/auth_cubit/authentication_cubit.dart';
import 'package:mobile2/features/authentication/application/create_wallet_cubit/create_wallet_cubit.dart';
import 'package:mobile2/features/authentication/infrastructure/authentication_repo.dart';
import 'package:mobile2/features/authentication/infrastructure/create_wallet_repo.dart';
import 'package:mobile2/features/authentication/presentation/check_authentication.dart';
import 'package:mobile2/features/authentication/presentation/create_wallet/create_wallet.dart';
import 'package:mobile2/features/authentication/presentation/sign_in.dart';
import 'package:mobile2/features/authentication/presentation/sign_up.dart';
import 'package:mobile2/firebase_options.dart';

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Occam Wallet',
        theme: ThemeData.dark(),
        routes: {
          '/': (context) => const CheckAuthentication(),
          '/sign_in': (context) => const SignInScreen(),
          '/sign_up': (context) => const SignUpScreen(),
          '/create_wallet': (context) => const CreateWallet()
        },
      ),
    );
  }
}
