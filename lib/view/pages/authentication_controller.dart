import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:test_app/view/pages/login_page.dart';
import 'package:test_app/view/pages/main_page.dart';

class AuthenticationController extends StatelessWidget {
  const AuthenticationController({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return const MainPage();
          } else {
            return const LoginPage();
          }
        }),
      ),
    );
  }
}
