import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:salahly/location.dart';
import 'package:provider/provider.dart';
//import 'package:salahly/categories.dart';
//import 'package:salahly/location2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salahly/myColors.dart' as myColors;
//import 'listchat.dart';
import 'chat.dart';
import 'location2.dart';
//import 'package:salahly/profile1.dart';
class Subcatagories extends StatefulWidget {
  static  String id= "Subcatagories";
  DocumentReference k;
  DocumentReference clint;
  Subcatagories(k,clint) {
    this.k = k;
    this.clint=clint;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new subcata(k);
  }
}

class subcata extends State<Subcatagories> {
  SharedPreferences mm;
  findShared()
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    return email;
  }
  subcata(var k);
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position   _currentPosition;

  Future<Position> _getCurrentLocation() async {

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      print('pos: ${position}');
      _currentPosition = position;
    }).catchError((e) {
      print(e.toString());
    });
    return _currentPosition;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('ref: ' + widget.k.path);
    _getCurrentLocation();
    SharedPreferences preferences;
    return new Scaffold(
        appBar:  new AppBar(

          //  title: new Text('Flutter Demo'),
          backgroundColor: myColors.red,
          centerTitle: true,

          title: Text(

            "S A L A H L Y",
            textAlign: TextAlign.right,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
              //_select(choices[0]);
            },
          ),

        ),
        body: StreamBuilder<QuerySnapshot>(
//          where('service_type',isEqualTo:widget.k).
            stream: Firestore.instance
                .collection('specialization')
                .where('service_type', isEqualTo: widget.k).where('active',isEqualTo:true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return new Text(
                  'Error: ${snapshot.error.toString()}',
                  textDirection: TextDirection.ltr,
                );
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return  Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.red),
                      )
                  );
                default:
                  return new ListView(
                    children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                      return new Center(
                          child: new Padding(padding: EdgeInsets.all(13),child:
                          Container(
                            alignment: Alignment.center,
                            height: 170,
                            width: 950,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              image: DecorationImage(
                                image: NetworkImage(document["image"].toString()),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child:
                            new Column(
                              children: <Widget>[
                                new Padding(padding: EdgeInsets.all(17),),
                                new FlatButton(
                                    onPressed: () async{
                                      print("g");
                                      SharedPreferences prefs2 = await SharedPreferences.getInstance();
                                      double  lat2 = prefs2.getDouble("lat");
                                      double  long2 = prefs2.getDouble("long");
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                              new location2(document.reference,lat2,long2,widget.clint)));
                                      print("ll${document.reference}");
                                    },
                                    child: new Text(
                                      document["name"],
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )),
                                new Text(
                                  " اقرب ${document["name"]} لديك في اسرع وقت     ",
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100),
                                )
                              ],
                            ),
                          ),
                          ));
                    }).toList(),
                  );
              }
            }),

    );
  }
}