import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:HappyTaills/screens/HomePages/Home_screen.dart';
import 'package:HappyTaills/screens//LSScreen/login_screen.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          // hna ida kan 3ando min 9bal account wala la
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        }),
      ),
    );
  }
}
