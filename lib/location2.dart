//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salahly/servicedetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' show cos, sqrt, asin;
import 'chat.dart';
import 'package:url_launcher/url_launcher.dart';
List<Pair> c;
List data = new List();
List<GeoPoint> listcour = new List();
List<String> listname = new List();
List <String> phone=new List();
List <String> img=new List();
List <double> rating=new List();
bool check=true;


List <DocumentReference>fav=new List();

class location2 extends StatefulWidget {
  double lat2;
  double long2;
  DocumentReference Splz;
  DocumentReference g;
  Position jk;
  location2(DocumentReference f,this.lat2,this.long2,DocumentReference g){
    this.Splz=f;
    this.g=g;
  }

  @override
  _location2State createState() => _location2State();
}


String _currentAddress;

Position _currentPosition;
class _location2State extends State<location2> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  data=cx();

//    c = new List();
    // submitAll();
    // sortList();
  }
  SharedPreferences preferences;
  String g ;

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
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

    // _getCurrentLocation();
//    submitAll();
//    sortList();
//    print('list c: ${c.length}');

    /*return ListView.builder(
      itemCount: c.length,
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
    );*/
    var z;

int starCount = 5;
    Color cc=Color.fromRGBO(31, 58, 147, 1);
    return new Scaffold(
      appBar: new AppBar(
        //  title: new Text('Flutter Demo'),
        backgroundColor: Color.fromRGBO(31, 58, 147, 1),
        centerTitle: true,

        title: Text(
          "salahly",
          textAlign: TextAlign.right,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            //_select(choices[0]);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              //_select(choices[0]);
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('service').where("specialization",isEqualTo: widget.Splz).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return new Text(
                'Error: ${snapshot.error.toString()}',
                textDirection: TextDirection.ltr,
              );
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text(
                  'Loading...',
                  textDirection: TextDirection.ltr,
                );
              default:
//                  List sortedList = new List();
                print("outside");
                List<String> listid = [];
                listname = new List();
                listcour = new List();
                snapshot.data.documents.forEach((DocumentSnapshot doc) async {
                  String pp = doc.documentID;
                  print(pp);
                  print("Inside");
                  GeoPoint x = doc["location"];
                    rating.add(doc["rating"]);
                  listname.add(doc["name"]);
                  img.add(doc["image"]);
                  phone.add(doc["phone"].toString());
                  listid.add(doc.documentID);
                  Re.add(doc["service_owner"]);
//            listcour.add(x.latitude.toString() + " " + x.longitude.toString());
                  listcour.add(x);
                });
                print('before sleep');
                new Future.delayed(const Duration(seconds: 5), () => "5");
                print('After sleep');
                sortList();
                print('before sort sleep');
                new Future.delayed(const Duration(seconds: 5), () => "5");
                print('After sort sleep ${c.toString()} ');
                return new ListView.builder(
                    itemCount: c.length,
                    itemBuilder: (context, index) {
                      return new Padding(padding: EdgeInsets.all(12),child:
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            image: DecorationImage(
                              image: NetworkImage(img[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child:
                          new Container(
                            //color: Colors.white,
                            child:
                            new Column(
                              children: <Widget>[
                                new Padding(padding: EdgeInsets.all(50)),
                                new Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 4,
                                        )),
                                    child:new Column(
                                      children: <Widget>[
                                        new Row(
                                          children: <Widget>[
                                            new Padding(
                                                padding: EdgeInsets.only(left: 10)),
                                            new CircleAvatar(
                                              child: new Icon(Icons.person),
                                              backgroundColor:  Color.fromRGBO(31, 58, 147, 1),
                                            ),
                                            new Padding(
                                                padding: EdgeInsets.only(left: 12)),
                                            new FlatButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      new MaterialPageRoute(
                                                          builder: (context) =>
                                                          new detailsserives2(c[index].toString(), c[index].toString(),listid[index].toString())));
                                                },
                                                child: new Text(
                                                  c[index].toString(),
                                                  style: new TextStyle(
                                                      color:  Color.fromRGBO(31, 58, 147, 1),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13),
                                                )),
                                            new Padding(
                                                padding: EdgeInsets.only(left: 1)),

                                            new FlatButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    new MaterialPageRoute(
                                                        builder: (context) => new Chat(
                                                          serivce_owner:c[index].reference() ,
                                                          user: widget.g,


                                                        )));
                                              },
                                              child: new Icon(
                                                Icons.chat,
                                                color:  Color.fromRGBO(31, 58, 147, 1),
                                              ),
                                            ),
                                            new Padding(
                                                padding: EdgeInsets.only(left: 1)),
                                            new FlatButton(

                                              onPressed: () => launch("tel:${c[index].getphone()}"),
                                              child: new Icon(
                                                Icons.call,
                                                color:  Color.fromRGBO(31, 58, 147, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        new Padding(padding: EdgeInsets.all(10)),
                                        new Row(
                                          children: <Widget>[
                                            //new RaisedButton.icon(onPressed: ()=>"d", icon:new Icon( Icons.favorite_border,color: Colors.grey,), )
                                            new FlatButton(
                                                onPressed: (){
                                                  check=true;


                                                  Firestore.instance.collection('clients')
                                                      .snapshots().listen((data) => data.documents.forEach((doc) {
                                                    if(widget.g==doc.reference) {
                                                      print(doc["favourite_service_owner"].toString());
                                                      for(int i=0;i<fav.length;i++) {
                                                        if (fav[i] == c[index].reference()){

                                                        }

                                                      }

                                                      fav = List.from(doc["favourite_service_owner"]);
                                                      if (check == true) {
                                                        fav.add(c[index].reference());
                                                        print(fav.length);
                                                        if (fav .length>0) {

                                                          Firestore.instance.collection("clients")
                                                              .document(doc.documentID)
                                                              .updateData(({
                                                            "favourite_service_owner": fav
                                                          }));

                                                          check = false;
                                                        }
                                                        else {
                                                          fav=new List();
                                                          Firestore.instance.collection("clients")
                                                              .document(doc.documentID)
                                                              .setData(
                                                              ({
                                                                "favourite_service_owner": fav
                                                              }));
                                                          check = false;
                                                        }
                                                      }
                                                    }
                                                  }

                                                  ));

                                                  /*else{

    Firestore.instance.collection('clients').where("email",isEqualTo: widget.g).limit(1).snapshots().listen((onData) {
      onData.documents.forEach((f) {
        fav = List.from(f["favourite_service_owner"]);
        if (fav != null) {
          fav.add(c[index].reference());
          for(int i=0;i<fav.length;i++){
            if(fav[i]==c[index].reference()){
              fav.removeAt(i);
            }
          }
          Firestore.instance.collection("clients")
              .document(f.documentID)
              .updateData(({
            "favourite_service_owner": fav
          }));
        }
      });
    });
    cc=Color.fromRGBO(31, 58, 147, 1);
                                                check=true;
                                              }*/

                                                },
                                                child: new Icon(
                                                    Icons.favorite,
                                                    color:check==true?     Colors.red:cc//Color.fromRGBO(31, 58, 147, 1),
                                                )),
                                            new Padding(
                                                padding: EdgeInsets.only(left: 20)),
                                            new StarRating(
                                              size: 25.0,
                                              rating:rating[index],
                                              color: Colors.orange,
                                              borderColor: Colors.grey,
                                              starCount: starCount,
                                            ),
                                            new Padding(
                                                padding: EdgeInsets.only(left: 30)),
                                            new Text(
                                              c[index].getDistance() + " " + "km",
                                              style: new TextStyle(color:  Color.fromRGBO(31, 58, 147, 1)),
                                            )
                                          ],
                                        )
                                      ],
                                    )),
                              ],
                            ),

                          )));
                    });
            }
          })
      ,
      bottomNavigationBar: BottomNavigationBar(
        //fixedColor: Colors.grey,
        backgroundColor: Colors.grey,
        selectedItemColor: Color.fromRGBO(31, 58, 147, 1),
        unselectedItemColor: Colors.grey,

        currentIndex: 0,
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text(
              'Home',
              style: new TextStyle(color: Colors.grey),
            ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.favorite),
            title: new Text('person', style: new TextStyle(color: Colors.grey)),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('chat', style: new TextStyle(color: Colors.grey))),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('person', style: new TextStyle(color: Colors.grey))),
        ],
      ),);
  }




  List sortList( ) {


    //SharedPreferences prefs2 = await SharedPreferences.getInstance();
    //double lat = prefs2.getDouble("lat");
    //double long = prefs2.getDouble("long");
    c = new List();

    print('at sort list court: ${listcour.toString()}');
    print('at sort litst pos: ${_currentPosition}');
//    _currentPosition = new Position(29.9604603, )
    //c = new List();
    for (int i = 0; i < listcour.length; i++) {
      GeoPoint v = listcour[i];
      c.add(
        new Pair(
            calculateDistance(widget.lat2,
              widget.long2, v.latitude, v.longitude),
            v.latitude,
            v.longitude,
            listname[i],
            Re[i],phone[i]),
      );
    }
    c.sort();
    for (int i = 0; i < c.length; i++) {
      print(c[i].toString());
    }
    return c;
  }
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;

    return 12742 * asin(sqrt(a));
  }



  List<DocumentReference> Re = new List();

  Future<String> submitAll() async {
    await Firestore.instance
        .collection('service')
        .snapshots()
        .listen((data) => data.documents.forEach((doc) {
      // print(data.documents.length);
      GeoPoint x = doc["location"];
      //listname=new List();
      listname.add(doc["name"]);
      Re.add(doc.reference);
      //  listcour=new List();
//            listcour.add(x.latitude.toString() + " " + x.longitude.toString());
      listcour.add(x);

      //return 'success';
    }));
    return "sucesss";
  }
}

class Pair implements Comparable<Pair> {
  double distance;
  double lat;
  double lang;
  String placemark;
  String name;
  DocumentReference Re;
  String  phone;

  String toString() => "${name}";

  String getDistance() {
    int distancr = distance.toInt();
    return distancr.toString();
  }

  DocumentReference reference() {
    return Re;
  }

  Pair(double distance, double lat, double lang, String name,
      DocumentReference t,String phone) {
    this.distance = distance;
    this.lat = lat;
    this.lang = lang;
    this.name = name;
    this.Re = t;
    this.phone=phone;
  }

  @override
  int compareTo(Pair p) {
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
  String getphone(){
    return phone;
  }
}



class StarRating2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Text("hi"
    );
  }
}

