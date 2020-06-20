import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:salahly/homepage.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Io extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _IoState();
}
class _IoState extends State<Io> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    Future<FirebaseUser> handleSignInEmail(String email, String password) async {

      AuthResult result = await auth.signInWithEmailAndPassword(email: email, password: password);
      final FirebaseUser user = result.user;

      assert(user != null);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await auth.currentUser();
      assert(user.uid == currentUser.uid);
      if(user.uid == currentUser.uid) {
        Navigator.of(context).pushNamed('/home');
        print('signInEmail succeeded: $user');
        return user;                                            //login
      }

    }
    Future<FirebaseUser> handleSignUp(email, password) async {
      AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      final FirebaseUser user = result.user;
      assert (user != null);
      assert (await user.getIdToken() != null);     //register
      return user;
    }
    return Scaffold(
        body: Center(
          child: new Text("welcome"),
        )
    );
  }
}
