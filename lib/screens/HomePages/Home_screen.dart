import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'AccountScreen.dart';

import 'FavoriteScreen.dart';
import 'ScrollScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Post? post;
  List Screen = [
    ScrollScreen(),
    favoriteScreen(
      favoritePosts: [],
    ),
    AccountScreen(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 60,
        backgroundColor: Color.fromARGB(255, 217, 233, 241),
        animationDuration: Duration(milliseconds: 250),
        items: const [
          Icon(Icons.home),
          Icon(Icons.favorite),
          Icon(Icons.person),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: Screen[_selectedIndex],
    );
  }
}
