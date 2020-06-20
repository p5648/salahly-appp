import 'package:flutter/material.dart';
import 'package:salahly/location.dart';
import 'package:salahly/notification.dart';
import 'package:salahly/homepage.dart';
import 'package:salahly/location2.dart';
import 'package:salahly/loginpage.dart';
import 'package:salahly/dsitance.dart';
import 'package:salahly/registerpage.dart';
import 'package:salahly/image.dart';
import 'package:salahly/forget_password.dart';
import 'package:salahly/choice.dart';
import 'package:salahly/categories.dart';
import 'package:salahly/subcategories.dart';
import 'package:salahly/splash.dart';
import 'package:salahly/servicedetails.dart';
import 'package:salahly/comment.dart';
import 'package:salahly/tawkelat.dart';
import 'package:salahly/wensh.dart';
import 'package:salahly/subwarsha.dart';
import 'package:salahly/banzeena.dart';
import 'package:salahly/subprofile.dart';
import 'package:salahly/mekaneky.dart';
import 'package:salahly/kahraba2y.dart';
import 'package:salahly/takeefat.dart';
import 'package:salahly/doko.dart';
import 'package:salahly/2ezaz.dart';
import 'package:salahly/samkary.dart';
import 'package:salahly/wensh.dart';
import 'package:salahly/editprofile2.dart';
import 'package:salahly/listchat.dart';
import 'package:salahly/ma8sala.dart';
import 'package:salahly/facebook.dart';
import 'package:salahly/phonelogin.dart';
import 'package:salahly/profile1.dart';
import 'package:salahly/editprofile.dart';
import 'package:salahly/amr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
//import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
//import 'dart:html';
void main() => runApp(new MyApp());
class MyApp extends StatelessWidget {
  DocumentReference X;
  String m;
  Position L;
  DocumentReference Z;
  SharedPreferences md;
  double lat;
  double long;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Splash(),
        routes: <String , WidgetBuilder>{
          '/landingpage' : (BuildContext context) => new MyApp(),
          '/loginpage' : (BuildContext context) => new LoginPage(""),
          '/editprofile2' : (BuildContext context) => new Edit2(""),
          '/register' : (BuildContext context) => new RegisterPage(),
          '/forgetpasswordpage' : (BuildContext context) => new Forget(),
          '/home' : (BuildContext context) => new Home(),
          '/image' : (BuildContext context) => new ImagePage(""),
          '/listchat' : (BuildContext context) => new Listchat(X),
          '/notification' : (BuildContext context) => new Notificat(),
          '/phonepage' : (BuildContext context) => new Phone(),
          '/categories': (BuildContext context) => new cata(m),
          '/subcatagories': (BuildContext context) => new  Subcatagories("",Z),
          '/location2':(BuildContext context) => new location2(X,lat,long,Z),
          '/detailsserives':(BuildContext context) => new detailsserives("catagoris","gh"),
        }
        );
  }
}
