import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salahly/wensh.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salahly/myColors.dart' as myColors;


class Map extends StatefulWidget {
  GeoPoint zz2;
  List<DocumentReference> XX = new List();
  List<String> XX2 = new List();
  Map(List<DocumentReference> xx , List<String> xx2 )
  {

    this.XX = xx;
    this.XX2 = xx2;
  }
  @override
  MyMap createState() => MyMap();
}

class MyMap extends State<Map> {
  GoogleMapController mapController;
  List<Position> kk = [];
  GeoPoint gg;
  String searchAddr;

  @override
  Widget build(BuildContext context) {
    searchandNavigate() {
      Geolocator().placemarkFromAddress(searchAddr).then((result) {
        mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target:
            LatLng(result[0].position.latitude, result[0].position.longitude),
            zoom: 10.0)));
        print(result[0].position);
        gg=result[0].position as GeoPoint;
      });
    }
    void onMapCreated(controller) {
      setState(() {
        mapController = controller;
      });
    }
    return Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                  target: LatLng(40.7128, -74.0060), zoom: 10.0),
            ),
            Positioned(
                top: 30.0,
                right: 15.0,
                left: 15.0,
                child: Container(
                  height: 110.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0), color: Colors.white),
                  child: Column(children: <Widget>[TextField(
                    decoration: InputDecoration(
                        hintText: 'ضع عنوانك',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 20.0, top: 20.0),
                        suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            color: myColors.red,
                            onPressed: searchandNavigate,
                            iconSize: 30.0)),

                    onChanged: (val) {
                      setState(() {
                        searchAddr = val;
                      });
                    },
                  ),
                    //new Padding(padding: EdgeInsets.all(15)),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new ClientSearch(widget.XX,widget.XX2,null,null

                                )));
                      },
                      child: SvgPicture.asset(
                        "icons/map-marker.svg",
                        color: myColors.red,
                        width: 24,
                        height: 24,
                      ),
                    ),

                  ]
                  ),
                )
            )],
        ));

  }
}