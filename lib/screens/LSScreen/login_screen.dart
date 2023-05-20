import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'forgetPassword_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _storedEmail = ''; // Variable to store the stored email
  String _storedPassword = ''; // Variable to store the stored password

  // Define a list of colors to cycle through
  final List<Color> _colors = [
    Color.fromARGB(255, 186, 197, 255),
    Color.fromARGB(255, 151, 167, 248),
    Color.fromARGB(255, 95, 122, 243),
    Color.fromARGB(255, 59, 83, 155),
  ];

  // Define a timer to update the text color
  Timer? _timer;
  int _colorIndex = 0;

  @override
  void initState() {
    // Start the timer when the widget is first created
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _colorIndex = (_colorIndex + 1) % _colors.length;
      });
    });
    super.initState();
  }

  Future login() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        //trim bah ya3tini form s7i7 bla @ w haka 7wayj
        email: _emailController.text.trim(),
        // ma3naha n7taj ghir text li fi da5lo
        password: _passwordController.text.trim());
  }

  void openSignupScreen() {
    //dirna router bah ydirni l page nta3
    Navigator.of(context).pushReplacementNamed('signupScreen');
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    // y7abashom ki n3od man7tajhomch
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //image
                    SvgPicture.asset(
                      'images/LOGO.svg',
                      height: 150,
                    ),

                    //title
                    Text(
                      'HappyTaills',
                      style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        fontStyle: FontStyle.italic,
                        color: _colors[_colorIndex], // set the text color
                      ),
                    ),
                    Text(
                      'Welcome back! Nice to see you again <3',
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 18,
                        color: Color.fromARGB(255, 95, 122, 243),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20), // ya3ni yamin yasar
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 233, 247, 253),
                            borderRadius: BorderRadius.circular(90)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller:
                                _emailController, // ya7fad wach da5alti bah mba3d ya3raf 3andik account wala la
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20), // ya3ni yamin yasar
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 233, 247, 253),
                            borderRadius: BorderRadius.circular(90)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: _passwordController,
                            obscureText:
                                true, // hadi li t5ali text hidden fi password
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'PasswordS',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => forgetPassword()),
                            );
                          },
                          child: Text('Forget Password'),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: login,
                        child: Container(
                          padding: EdgeInsets.all(16), // external passing
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 95, 122, 243),
                              borderRadius: BorderRadius.circular(90)),
                          child: Center(
                              child: Text(
                            'Login',
                            style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          )),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'I Dont Have Account? ',
                          style: GoogleFonts.robotoCondensed(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: openSignupScreen,
                          child: Text(
                            'Sing Up',
                            style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 95, 122, 243),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
