import 'package:HappyTaills/screens/roots/roots.dart';
import 'package:HappyTaills/screens/roots/rout_name.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:HappyTaills/screens/HomePages/Home_screen.dart';
import 'package:HappyTaills/screens//LSScreen/login_screen.dart';
import 'package:HappyTaills/screens//LSScreen/signup_screen.dart';

import 'auth.dart';

void main() async {
  // hna rbatna firebase b app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, //hadi li tna7i charit nta3 debug in top
      title: 'HappyTaills',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
      // home: LoginScreen(),
      routes: {
        '/': (context) => const Auth(),
        'HomeScreen': (context) => const HomeScreen(),
        'signupScreen': (context) => const SignupScreen(),
        'loginpScreen': (context) => const LoginScreen(),
      },
    );
  }
}
