import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const url = "https://helloWord.com";
const email = "ayamahdi00@gmail.com";
const phone = "+213 6509482204";
const location = "Algeria/Biskra";

class infocard extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  final String text;
  final IconData iconData;
  final Function() onPressed;

  infocard(
      {required this.text, required this.iconData, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 23),
        child: ListTile(
          leading: Icon(
            iconData,
            color: Colors.teal,
          ),
          title: Text(
            text,
            style: TextStyle(
              color: Colors.teal,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
