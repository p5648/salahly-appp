import 'dart:io';
import 'dart:math';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:splashscreen/splashscreen.dart';
//import 'package:sal7ly_firebase/Design/Start.dart';
import 'package:salahly/loginpage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:salahly/categories.dart';
import 'package:salahly/main.dart';
import 'package:salahly/editprofile.dart';
import 'package:flutter/services.dart';
class Splash extends StatefulWidget {

  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position  _currentPosition;
 Future <Position> _getCurrentLocation() async{
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      //print('pos: ${position}');
      _currentPosition = position;
      print(_currentPosition);
      return position;
    }).catchError((e) {
      print(e.toString());
    });
  }
  var mymap = {};
  var title = '';
  var body = {};
  var mytoken = '';
  List<String> rphone = new List<String>();
  StreamSubscription connectivityStream;
  ConnectivityResult olders;

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();
  void getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform);
    firebaseMessaging.configure(
        onLaunch: (Map<String, dynamic> msg) {
          print("onLaunch called ${(msg)}");
        },
        onResume: (Map<String, dynamic> msg) {
          print("onResume called ${(msg)}");
        },
        onMessage: (Map<String, dynamic> msg) {
          print("onResume called ${(msg)}");
          mymap = msg;
          showNotification(msg);
        }
    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print("onIosSettingsRegistered");
    });
    firebaseMessaging.getToken().then((token) {
      update(token);
    });

    connectivityStream = Connectivity().onConnectivityChanged.listen((
        ConnectivityResult resnow) {
      if (resnow == ConnectivityResult.none) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Salahly"),
                content: Text("No Internet Connection"),
                actions: [
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
      }
      else if (olders == ConnectivityResult.none) {
        print("connected successfully");
      }
    });

      _getCurrentLocation().then((value) => {
        Future.delayed(Duration(seconds: 4), () async {
        value = _currentPosition;
        print(value);
        SharedPreferences prefs2 = await SharedPreferences.getInstance();
        prefs2.setDouble('lat',value.latitude );
        prefs2.setDouble('long',value.longitude );
        submitAll();
      }),
      // submitAll();
    });
  }

  @override
  void dispose() {
    super.dispose();
    connectivityStream.cancel();
  }
  showNotification(Map<String, dynamic> msg) async {
    var android = new AndroidNotificationDetails(
        "1", "channelName", "channelDescription");
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    msg.forEach((k, v) {
      title = k;
      body = v;
      setState(() {
      });
    });
    await flutterLocalNotificationsPlugin.show(
        0, " ${body.keys}", "  ${body.values}", platform);
  }
  update(String token) {
    print(token);
    DatabaseReference databaseReference = new FirebaseDatabase().reference();
    databaseReference.child('fcm-token/$token').set({"token": token});
    mytoken = token;
    setState(() {});
  }

  Future<String> submitAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var phone_number = prefs.getString('phone');
    if (email == null && phone_number == null) {
      Navigator.of(context).pushNamed('/loginpage');
    }
    else if (email != null) {
      await Firestore.instance
          .collection('clients').where('email', isEqualTo: email).limit(1)
          .snapshots()
          .listen((data) {
        //print(data.documents.length);
        print(email);
        //bool x =false;
        if (data.documents.length==1) {
          Navigator.of(context).pushNamed('/categories');
        }
        else if (data.documents.length !=1) {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new Editprofile(
                      email, "", "")));
          return;
        }
      });
    }
    else if (phone_number != null) {
      await Firestore.instance
          .collection('clients').where('phone',arrayContains:phone_number).limit(1)
          .snapshots()
          .listen((data) {
        //print(data.documents.length);
        print(phone_number);
        //bool x =false;
        if (data.documents.length==1) {
          Navigator.of(context).pushNamed('/categories');
        }
        else if (data.documents.length !=1) {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new Editprofile(
                      "", "", phone_number)));
          return;
        }
      });
    }
  }
    DocumentReference Z;
    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new MaterialApp(
          home: new Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/splash.jpg'),
                      fit: BoxFit.cover
                  ),
                ),
                child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.lightBlue),
                    )
                ),
              )
          )
      );
    }
  }

