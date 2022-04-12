import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/wallets/application/wallets_cubit.dart';
import 'package:mobile/features/wallets/infrastructure.dart/wallet_repository.dart';
import 'package:mobile/firebase_options.dart';

import 'package:mobile/features/authentication/application/auth/auth_cubit.dart';
import 'package:mobile/features/authentication/infrastructure/auth_repository.dart';
import 'package:mobile/features/authentication/presentation/check_authentication.dart';

void main() async {
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
        BlocProvider(create: (_) => AuthCubit(AuthRepository())),
        BlocProvider(create: (_) => WalletsCubit(WalletRepository())),
      ],
      child: MaterialApp(
        title: 'Occam Wallet App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const CheckAuthentication(),
      ),
    );
  }
}
