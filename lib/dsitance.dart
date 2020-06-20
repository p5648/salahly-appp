//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' show cos, sqrt, asin;
List<pair> c;
List data = new List();
List<GeoPoint> listcour = new List();
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
Position _currentPosition;
String _currentAddress;

class _HomePageState extends State<HomePage> {
  final Geolocator geolocator = Geolocator()
    ..forceAndroidLocationManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  data=cx();
  }

  @override
  Widget build(BuildContext context) {
    /*   return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null) Text(_currentAddress.toString())else Text("g"),
            FlatButton(
              child: Text("Get location"),
              onPressed: () {
                _getCurrentLocation();
                print(_currentAddress);
              },
            ),
          ],
        ),
      ),
    );*/


    submitAll();
    cx();

    return ListView.builder(
      itemCount: cx().length,
      itemBuilder: (context, pos) {
        return Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                child: Text(
                  c[pos].toString(),
                  style: TextStyle(
                    fontSize: 18.0,
                    height: 1.6,
                  ),
                ),
              ),
            ));
      },
    );
  }


  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e.toString());
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
      return _currentAddress;
    } catch (e) {
      print(e.toString());
    }
  }




  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;

    return 12742 * asin(sqrt(a));
  }

  List<dynamic> data1 = [
    {"lat": 44.968046, "lng": -94.420307},
    {"lat": 44.33328, "lng": -89.132008},
    {"lat": 33.755787, "lng": -116.359998},
    {"lat": 33.844843, "lng": -116.54911},
    {"lat": 44.92057, "lng": -93.44786},
    {"lat": 44.240309, "lng": -91.493619},
    {"lat": 44.968041, "lng": -94.419696},
    {"lat": 44.333304, "lng": -89.132027},
    {"lat": 33.755783, "lng": -116.360066},
    {"lat": 33.844847, "lng": -116.549069}
  ];

  List cx() {
    c = new List();
    for (int i = 0; i < listcour.length; i++) {
      GeoPoint v = listcour[i];

      c.add(new pair(
        calculateDistance(
          //  _currentPosition.altitude,
          //  _currentPosition.longitude
          //

            33.844847,
            -116.549069,
            v.latitude,
            v.longitude),
        v.latitude,
        v.longitude,));
    }

    c.sort();

    for (int i = 0; i < c.length; i++) {
      print(c[i].toString());
    }

    return c;
  }

  Future<String> submitAll() async {
    await Firestore.instance
        .collection('service')
        .snapshots()
        .listen((data) =>
        data.documents.forEach((doc) {
          // print(data.documents.length);
          GeoPoint x = doc["location"];
//            listcour.add(x.latitude.toString() + " " + x.longitude.toString());
          listcour.add(x);

          //return 'success';
        }));
    return "sucesss";
  }
}
class pair implements Comparable<pair> {
  double distance;
  double lat;
  double lang;
  String placemark;
  String toString() => "${lat} , ${lang},${distance},";
  pair(double distance, double lat, double lang) {
    this.distance = distance;
    this.lat = lat;
    this.lang = lang;
  }

  @override
  int compareTo(pair p) {
    // TODO: implement compareTo
    if (this.distance > p.distance)
      return 1;
    else
      return -1;
  }
  Map<String, dynamic> get List {
    return {
      "Distance": distance,
      "lat": lat,
      "lang": lang,
    };
  }
}