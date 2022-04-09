import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:mobile/firebase_options.dart';
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
    return MaterialApp(
      title: 'Occam Wallet App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const CheckAuthentication(),
    );
  }
}
