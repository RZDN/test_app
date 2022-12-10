import 'package:flutter/material.dart';
import 'package:test_app/service/firebase/authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Authentication authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () async {
            final navigator = Navigator.of(context);
            showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              },
            );
            await authentication.signInWithGoogle();
            navigator.pop();
          },
          child: Container(
            height: 120,
            width: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.orange,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 60,
                    child: Image.asset('lib/shared/icons/google.png'),
                  ),
                  const Text(
                    "Iniciar con Google",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
