import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile/features/authentication/presentation/sign_in.dart';
import 'package:mobile/features/authentication/presentation/sign_up.dart';
import 'package:mobile/features/navigation/presentation/navigation.dart';

class CheckAuthentication extends StatefulWidget {
  const CheckAuthentication({Key? key}) : super(key: key);

  @override
  State<CheckAuthentication> createState() => _CheckAuthenticationState();
}

class _CheckAuthenticationState extends State<CheckAuthentication> {
  late User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const SignInScreen();
    }
    return NavigationScreen();
  }
}
