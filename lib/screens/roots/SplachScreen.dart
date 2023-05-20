import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../HomePages/Home_screen.dart';
import '../LSScreen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isAnimating = false;
  double _fontSize = 20;
  FontWeight _fontWeight = FontWeight.bold;
  Color _color = Color.fromARGB(255, 130, 171, 233);

  @override
  void initState() {
    super.initState();

    // desapper and go to the  next page
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });

    // Animation
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    _controller.addListener(() {
      setState(() {
        _fontSize = _isAnimating ? 40 : 20;
        _fontWeight = _isAnimating ? FontWeight.bold : FontWeight.bold;
        _color = _isAnimating
            ? Color.fromARGB(255, 12, 77, 173)
            : Color.fromARGB(255, 144, 167, 202);
        Color.fromARGB(255, 1, 22, 53);
      });
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isAnimating = false;
      } else if (status == AnimationStatus.forward) {
        _isAnimating = true;
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _navigateToHomeScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => const HomeScreen(),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image
            SvgPicture.asset(
              'images/LOGO.svg',
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 500),
                style: TextStyle(
                  fontSize: _fontSize,
                  fontWeight: _fontWeight,
                  color: _color,
                ),
                child: const Center(
                  child: Text('Happy Taills'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
