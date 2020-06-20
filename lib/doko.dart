import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salahly/loginpage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Doko extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _DokoState();
}
class _DokoState extends State<Doko> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: new Text("welcome"),
        )
    );
  }
}
