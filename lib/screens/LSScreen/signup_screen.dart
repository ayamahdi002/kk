import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

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

  Future singup() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          //trim bah ya3tini form s7i7 bla @ w haka 7wayj
          email: _emailController.text.trim(),
          // ma3naha n7taj ghir text li fi da5lo
          password: _passwordController.text.trim());
      Navigator.of(context).pushNamed('/');
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  void openloginScreen() {
    //dirna router bah ydirni l page nta3
    Navigator.of(context).pushReplacementNamed('loginpScreen');
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    // y7abashom ki n3od man7tajhomch
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
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
                      height: 100,
                    ),

                    //title
                    Text(
                      'Create Account',
                      style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        fontStyle: FontStyle.italic,
                        color: _colors[_colorIndex], // set the text color
                      ),
                    ),
                    Text(
                      'Create a new Account',
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
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Name',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                      height: 10,
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
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Phone',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                                true, // ya7fad wach da5alti bah mba3d ya3raf 3andik account wala la
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                            controller: _confirmpasswordController,
                            obscureText:
                                true, // hadi li t5ali text hidden fi password
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirm Password',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: singup,
                        child: Container(
                          padding: EdgeInsets.all(16), // external passing
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 95, 122, 243),
                              borderRadius: BorderRadius.circular(90)),
                          child: Center(
                              child: Text(
                            'Sign Up',
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
                          'Not member yet? ',
                          style: GoogleFonts.robotoCondensed(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: openloginScreen,
                          child: Text(
                            'Login',
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
