//import 'dart:html';
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
import 'package:location/location.dart';
class Splash extends StatefulWidget {

  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position  _currentPosition;
  UserLocation _currentLocation;
  DocumentReference client ;
  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await Location().getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
    return _currentLocation;
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

    getLocation().then((value) => {
      print(_currentPosition),
      Future.delayed(Duration(seconds: 2), () async {
        if
        (
        _currentLocation!=null
        )
        {
          value = _currentLocation;
          print(value.latitude);
          print('farid');
          SharedPreferences prefs2 = await SharedPreferences.getInstance();
          prefs2.setDouble('lat', value.latitude);
          prefs2.setDouble('long', value.longitude);
          submitAll();
        }  }),
      // submitAll();
    });
  }


  @override
  void dispose() {
    super.dispose();
    connectivityStream.cancel();
  }
  Future<String> submitAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var phone_number = prefs.getString('phone');
    if (email == null && phone_number == null) {
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (context) =>
              new LoginPage(
                  "")));
    }
    else if (email != null) {
      await Firestore.instance
          .collection('clients').where('email', isEqualTo: email).limit(1)
          .snapshots()
          .listen((data) {
        print(email);
        if (data.documents.length==1) {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new cata(
                      "")));

        }
        else if (data.documents.length !=1) {
          Navigator.pushReplacement(
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
        print(phone_number);
        if (data.documents.length==1) {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new cata(
                      "")));
        }
        else if (data.documents.length !=1) {
          Navigator.pushReplacement(
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
    var deviceInfo = MediaQuery.of(context);
    // TODO: implement build
    return new MaterialApp(
        home: new Scaffold(
            body: Container(
              height: deviceInfo.size.height,
              width: deviceInfo.size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/splash2.jpg'),
                    fit: BoxFit.cover
                ),
              ),
              child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white),
                  )
              ),
            )
        )
    );
  }
}
class UserLocation {
  final double latitude;
  final double longitude;

  UserLocation({this.latitude, this.longitude});
}