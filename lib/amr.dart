//import 'dart:html';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class detailsserives extends StatefulWidget{
  String catagories;
  String name;
  detailsserives(String catagoris ,String name){
    this.name=name;
    this.catagories=catagoris;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Homestate();
  }

}
//final pat=FirebaseDatabase.instance.reference().child("");
class Homestate extends State<detailsserives> {


  int Radio = 0;
  String reslut = "";
  TextEditingController name;
  TextEditingController phone;
  TextEditingController email;
  TextEditingController location;
  TextEditingController offdays;
  TextEditingController price;
  var geolocator;
//  var geolocator;
  // get geolocator => null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = new TextEditingController();
    email = new TextEditingController();
    phone = new TextEditingController();
    location =new TextEditingController();
    offdays=new TextEditingController();
    price=new TextEditingController();

  }

  void Raioonchanges() {


  }
  GeoPoint _currentPosition;
  String _currentAddress;
  List <String> phonelist=new List<String>();
  List <String> off_dayslist=new List();
  _getAddressFromLatLng(GeoPoint x) async {
    try {


      List<Placemark> p = await Geolocator().placemarkFromCoordinates(
          30.074450,31.214590);

      Placemark place = p[0];

      setState(() {
        location.text =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
      return location.text;
    } catch (e) {
      print(e.toString());
    }
  }
  GeoPoint xx;
  var x;

  Map <String,dynamic>xxx=new Map();
  Map<String ,dynamic>time=new Map();
  Future<String> submitAll() async {
    await Firestore.instance
        .collection('service').where("name",isEqualTo: "الاخلاص")
        .snapshots()
        .listen((data) =>
        data.documents.forEach((doc) {
          name.text=doc["name"];
          xx=doc['location'];
          x=doc.documentID;
          phonelist=List.from(doc["phone"]);
          off_dayslist=List.from(doc["off_days"]);
          xxx=Map.from(doc["price"]);
          time=Map.from(doc["time"]);

        }));


  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    submitAll();
    print(name);
    return new Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: new Text("SlA7lY", textAlign: TextAlign.center,
        ),

      ),
      body: new Container(

        height: 500.0,
        padding: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: new ListView(
          padding: EdgeInsets.all(12.0),
          children: <Widget>[
            new Container(
              child: new Text("Deatiles Owner", style: new TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),),

            ),

            new Container(
              padding: EdgeInsets.only(top: 22.0)
              , child: new Column(

              children: <Widget>[
                new RawMaterialButton(

                  child: new Icon(
                    Icons.camera_alt,
                    color: Colors.blue,
                    size: 35.0,
                  ),
                  shape: new CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(15.0),

                ),
                new Row(
                  children: <Widget>[
                    new Icon(Icons.person, color: Colors.blue,),
                    new Padding(padding: EdgeInsets.only(left: 15)),
                    new Text(
                      "welcome", style: new TextStyle(color: Colors.blue),)
                  ],
                ),
                new Padding(padding: EdgeInsets.all(8)),
                new Row(
                  children: <Widget>[
                    new Icon(Icons.phone, color: Colors.blue,),
                    new Padding(padding: EdgeInsets.only(left: 15)),
                    new Text(
                      phonelist.toString(), style: new TextStyle(color: Colors.blue),)
                  ],
                ),
                new Padding(padding: EdgeInsets.all(8)),
                new Row(
                  children: <Widget>[
                    new Icon(Icons.monetization_on, color: Colors.blue,),
                    new Padding(padding: EdgeInsets.only(left: 15)),
                    new Text(
                      xxx.toString(), style: new TextStyle(color: Colors.blue),)
                  ],
                ),
                new Padding(padding: EdgeInsets.all(8))
                ,    new Row(
                  children: <Widget>[
                    new Icon(Icons.timer, color: Colors.blue,),
                    new Padding(padding: EdgeInsets.only(left: 15)),
                    new Text(
                      time.toString(), style: new TextStyle(color: Colors.blue),)
                  ],
                ),


                new Padding(padding: EdgeInsets.all(8))
                ,
                new Row(
                  children: <Widget>[
                    new Icon(Icons.location_on, color: Colors.blue,),
                    new Padding(padding: EdgeInsets.only(left: 15)),
                    new Text(
                      location.text, style: new TextStyle(color: Colors.blue),)
                  ],
                ),


              ],
            ),
            )
          ],

        ),

      ),
    );
  }




}