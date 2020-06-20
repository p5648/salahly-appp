import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salahly/loginpage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:salahly/choice.dart';
class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomeState();
}
class _HomeState extends State<Home> {
  String _uid = '';
  getUid(){}
  @override
  void initState() {
    this._uid = '';
    FirebaseAuth.instance.currentUser().then((val) {
      setState(() {
        this._uid = val.uid;
      });
    }).catchError((e) {
      print(e);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("dashboard"),
        centerTitle: true,
      ),
        body: Center(
    child :Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        new Text("your are logged in with ${_uid}"),
      ],),
    )
      ),
    );
  }
  }