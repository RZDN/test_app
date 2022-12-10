import 'package:flutter/material.dart';
import 'package:test_app/service/firebase/authentication.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
            await authentication.signOut();
            navigator.pop();
          },
          child: Container(
            height: 90,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.red,
            ),
            child: const Center(child: Text("Salir ")),
          ),
        ),
      ),
    );
  }
}
