import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salahly/loginpage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salahly/profile1.dart';
import 'package:salahly/editprofile.dart';
import 'package:salahly/categories.dart';
import 'package:salahly/profile1.dart';

class Facebook extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FacebookState();
  }
}

class _FacebookState extends State<Facebook> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoggedIn = false;
  Map userProfile;
  final facebookLogin = FacebookLogin();

  _loginWithFB() async {

    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        setState(() async {
          userProfile = profile;
          _isLoggedIn = true;
          if(_auth.currentUser() !=null) {
            Navigator.of(context).pushNamed('/categories');
          }
          else {
            AuthCredential credential = FacebookAuthProvider.getCredential(
                accessToken: token);
            FirebaseUser firebaseUser = (
                await FirebaseAuth.instance.signInWithCredential(credential)
            ).user;
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new Editprofile(
                        userProfile["email"],
                        userProfile["picture"]["data"]["url"], "")));
          }
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false);
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false);
        break;
    }
  }
  _logout() {
    facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phone1Controller = new TextEditingController();
  TextEditingController _phone2Controller = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _birthdayController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        home: Scaffold(
          body: Center(
              child: _isLoggedIn
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                ],
              )
                  : Center(
                child: OutlineButton(
                  child: Text("Login with Facebook"),
                  onPressed: () {
                    _loginWithFB();
                  }
                ),
              )),
        ),
      );
    }
  }