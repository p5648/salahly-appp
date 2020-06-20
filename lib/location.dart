import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salahly/loginpage.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Location extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LocationState();

}
class _LocationState extends State<Location> {
  final db = Firestore.instance;
  //Location loc = new Location();
  String _locationmssg = "";
  void _getCurrentLocation()
  async {
    final position = await Geolocator().getCurrentPosition(desiredAccuracy:LocationAccuracy.high);
    print(position);
    Firestore.instance.collection('clients').add(
    {
      'location' : new GeoPoint(position.latitude, position.longitude)
    });
    setState(() {
      _locationmssg = "${position.latitude},${position.longitude}";
    });
  }
  //Location loc = new Location();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: Column
          (
            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text(_locationmssg),
           FlatButton(
            child :Text("save location"),
            color: Colors.teal,
            onPressed:() {
              _getCurrentLocation();
            }
    ),
    ]
    )
     // _getCurrentLocation();
      ),
  );
  }
}
