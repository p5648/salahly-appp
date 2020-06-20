import 'dart:async';
import 'dart:io';
import 'dart:ui';
//import 'dart:html';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
//import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salahly/wensh.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salahly/subcategories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:salahly/listchat.dart';
import 'package:salahly/profile1.dart';
import 'location.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
//import 'listchat.dart';
class cata extends StatefulWidget {
 // String prefss;
  String D;
  cata(String d)
  {
    this.D = d;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new cataa();
  }
}
SharedPreferences sharedPrefs;
class cataa extends State<cata> {
  @override
  DocumentReference cllient;
  List <String> names=new List();
  List <String> image=new List();
  GeoPoint pos  ;
  String photo="";
String prefss;
String phone_number ;
List <String> rt = new List() ;
@override
      void initState() {
      super.initState();
      getHighScore();
      }
  getHighScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefss = prefs.getString('email');
      phone_number = prefs.getString('phone');
    });
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    List<String> service = new List();
    List<DocumentReference> servicee = new List();
    GeoPoint j;
    String phoneidd;
    List<String> rphone = new List<String>();


    //final widg = widget.D ;

    //sleep1();
    return new Scaffold(
      appBar: new AppBar(
        title: Text("salahly"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>
                        [
                          Color(0xffAD0514),
                         Colors.red,
                        ]
                    )
                ),
                child :
                        StreamBuilder<QuerySnapshot>(
    stream:Firestore.instance.collection('clients').where("email",isEqualTo:prefss).snapshots(),
    builder:
    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (prefss == null) {
      return StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('clients').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text(
                  'Loading...',
                  textDirection: TextDirection.ltr,
                );
              default:
                snapshot.data.documents.forEach((DocumentSnapshot client) {
                rphone=List.from(client["phone"]);
                  if (rphone.elementAt(0) == phone_number) {
                    photo = client["profile_pic"];
                     phoneidd = client.documentID;
                  }
                });
                return new Container(
                    child: Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            CircleAvatar(
                              radius: 40.0,
                              backgroundImage: NetworkImage(photo.toString()),
                            ),
                            new Padding(
                                padding: EdgeInsets.only(left: 7)),
                            Text(phone_number.toString(), style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),),
                          ]
                          )
                        ]
                    )
                );
            }
          });
    }
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return new Text(
            'Loading...',
            textDirection: TextDirection.ltr,
          );
        default:
          snapshot.data.documents.forEach((DocumentSnapshot client) {
            if(client["email"]==prefss){
    photo=client["profile_pic"];
    }});
  return  new  Container(
    child : Column(
    children: <Widget>[
    Row(children: <Widget>[
    CircleAvatar(
    radius: 40.0,
    backgroundImage: NetworkImage(photo.toString()),
    ),
    new Padding(
    padding: EdgeInsets.only(left: 7)),
    Text(prefss.toString(), style: TextStyle(
    color: Colors.black,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold),),
    ]
    )
    ]
    )
    );
          }})
            ),
            ListTile(
              leading: Icon(Icons.person,
                color:Color(0xffAD0514),),
              title: Text("my Profile",style: TextStyle(
                  fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 18,color:Color(0xffAD0514),)),
              onTap: ()=>{
              Navigator.push(
              context,
              new MaterialPageRoute(
              builder: (context) =>
              new Profile1(phoneidd))),
              },
            ),
                ListTile(
                  leading: Icon(Icons.explore,
                    color: Color(0xffAD0514),),
                  title: Text("Explore",style: TextStyle(
                      fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 18,color:Color(0xffAD0514),)),
                  onTap: ()=>{},
                ),
                ListTile(
                  leading: Icon(Icons.chat,color:Color(0xffAD0514),),
                  title: Text("chat list",style: TextStyle(
                      fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 18,color: Color(0xffAD0514),
                  ),),
                  onTap: () =>
                  Navigator.push(
                  context,
                  new MaterialPageRoute(
                  builder: (context) =>
                  new Listchat(cllient))),

                ),
                ListTile(
                    leading: Icon(Icons.notifications,color: Color(0xffAD0514),),
                    title: Text("Notifications",style: TextStyle(
                        fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 18,color: Color(0xffAD0514),
                    ),),
                    onTap: () async =>
                    {
                    }
                ),
                ListTile(
                  leading: Icon(Icons.location_on,color: Color(0xffAD0514),),
                  title: Text("Location",style: TextStyle(
                      fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 18,color: Color(0xffAD0514),
                  ),),
                  onTap: () async =>{
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings,color:Color(0xffAD0514),),
                  title: Text("Settings",style: TextStyle(
                      fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 18,color: Color(0xffAD0514),
                  ),),
                  onTap: () async =>{
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app,color: Color(0xffAD0514),),
                  title: Text("Logout",style: TextStyle(
                      fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 18,color: Color(0xffAD0514),
                  ),),
                  onTap: () async =>{
                    sharedPrefs = await SharedPreferences.getInstance(),
                    await sharedPrefs.clear(),
                    Navigator.of(context).pushNamed('/loginpage'),
                  },
                )
              ],
            ),
        ),
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('clients').snapshots(),
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
                String favourite_service0;
                String favourite_service1;
                String favourite_service3;
                snapshot.data.documents.forEach((DocumentSnapshot client) {
                  if(client.documentID=="0kaT3HKG975Pq7Uh2Kqo"){
                    favourite_service0=client["favourite_service"][0];
                    favourite_service1=client["favourite_service"][1];
                    favourite_service3=client["favourite_service"][2];
                    cllient=client.reference;
                    return;}
                });
                print('before sleep');
                new Future.delayed(const Duration(seconds: 5), () => "5");
                print('After sleep');
                print('before sort sleep');
                new Future.delayed(const Duration(seconds: 5), () => "5");
                //  print('After sort sleep ${c.toString()} ');
                return new ListView(
                    children: <Widget>[
                      new Container(
                          height: 500,
                          alignment: Alignment.center,
                          child: new Column(
                            children: <Widget>[
                              new Padding(padding: EdgeInsets.all(5)),
                              new Container(
                                  color: Color.fromRGBO(232, 232, 232, 1),
                                  height: 50,
                                  width: 330,
                                  child:
                                    new FlatButton(
                                      // color: Color.fromRGBO(31, 58, 147, 1),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                new ClientSearch(rt,names,pos)));
                                      },
                                      child: new Icon(
                                        Icons.search,
                                        color:  Color.fromRGBO(31, 58, 147, 1),
                                        size: 25,
                                      ),
                                    ),
                                  ),
                              new Padding(padding: EdgeInsets.all(2)),
                              new Row(children: <Widget>[
                                new Padding(padding: EdgeInsets.only(left: 250)),
                                new Text(
                                  "اقرب ${favourite_service0} لك",
                                  style: new TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.right,
                                )
                              ]),
                              StreamBuilder<QuerySnapshot>(
                                  stream:Firestore.instance.collection('specialization').where("name",isEqualTo:favourite_service0).limit(1).snapshots(),
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
                                        DocumentReference d;
                                        snapshot.data.documents.forEach((DocumentSnapshot doc) {
                                          d=doc.reference;
                                        });

                                        return new StreamBuilder<QuerySnapshot>(
                                            stream: Firestore.instance.collection('service').where("specialization",isEqualTo: d).snapshots(),
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
                                                  List <Pair> f=new List();
                                                  String image;
                                                  snapshot.data.documents.forEach((DocumentSnapshot doc) {
                                                    j =doc["location"];
                                                    String name=doc["name"].toString();
                                                    String phone=doc["phone"][0].toString();
                                                    DocumentReference reg=doc.reference;
                                                    image=doc["image"];
                                                    f.add(new Pair(calculateDistance(44.240309,-91.493619 , j.latitude, j.longitude),
                                                        j.latitude,j.longitude,name,reg,phone
                                                    ));
                                                  });
                                                  f.sort();
                                                  return
                                                    new Container(
                                                        child:  new Row(
                                                          children: <Widget>[
                                                            new FlatButton(
                                                              // color: Color.fromRGBO(31, 58, 147, 1),
                                                              onPressed: () {
                                                              },
                                                              child: new Icon(
                                                                Icons.chat,
                                                                color:  Color.fromRGBO(31, 58, 147, 1),
                                                                size: 25,
                                                              ),
                                                            ),
                                                            new Padding(padding: EdgeInsets.only(left: 1)),
                                                            new FlatButton(
                                                              //color: Colors.white,
                                                              onPressed: () => launch("0899"),
                                                              child: new Icon(
                                                                Icons.call,
                                                                color:  Color.fromRGBO(31, 58, 147, 1),
                                                                size: 25,
                                                              ),
                                                            ),
                                                            new Padding(padding: EdgeInsets.only(left: 20)),
                                                            new Column(
                                                              children: <Widget>[
                                                                new FlatButton(
                                                                    onPressed: () {
                                                                      print('ay 7aga 1');

                                                                      setState() {
                                                                        print('ay 7aga 2');
                                                                      }
                                                                    },
                                                                    child: new Text(
                                                                      //allMessages.keys.toList()[index],
                                                                      //       serivees[index].toString()
                                                                      //               messege[index].getrang().toString()
                                                                      f[0].name.toString(),
                                                                      style: new TextStyle(
                                                                          color: Colors.black,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 10),
                                                                    )),
                                                                new Text(
                                                                  f[0].phone.toString(),
                                                                  style: new TextStyle(
                                                                      color: Colors.grey,
                                                                      fontWeight: FontWeight.w100),
                                                                )
                                                              ],
                                                            ),

                                                            new  ClipOval(

                                                              //borderRadius: BorderRadius.circular(100),

                                                              child: Image.network(

                                                                image,
                                                                fit: BoxFit.cover,
                                                                height: 40.0,
                                                                width: 40.0,
                                                                //color: Color.fromRGBO(31, 58, 147, 1),
                                                              ),
                                                            ),
                                                            new Padding(padding: EdgeInsets.only(left: 12)),
                                                          ],
                                                        )            );

                                              }}
                                        );

                                    }}),
                              new Divider(),
                              new Row(children: <Widget>[
                                new Padding(padding: EdgeInsets.only(left: 250)),
                                new Text(
                                  "اقرب ورشه لك",
                                  style: new TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.right,
                                )
                              ]),
                              StreamBuilder<QuerySnapshot>(
                                  stream:Firestore.instance.collection('specialization').where("name",isEqualTo:favourite_service1).limit(1).snapshots(),
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
                                        DocumentReference d;
                                        snapshot.data.documents.forEach((DocumentSnapshot doc) {
                                          d=doc.reference;
                                        });
                                        return new StreamBuilder<QuerySnapshot>(
                                            stream: Firestore.instance.collection('service').where("specialization",isEqualTo: d).snapshots(),
                                            builder:
                                                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (!snapshot.hasData)
                                                return new Text(
                                                  "بببببببببببببببب",
                                                  textDirection: TextDirection.ltr,
                                                );
                                              switch (snapshot.connectionState) {
                                                case ConnectionState.waiting:
                                                  return new Text(
                                                    'Loading...',
                                                    textDirection: TextDirection.ltr,
                                                  );
                                                default:
                                                  List <Pair> f=new List();
                                                  String image;
                                                  snapshot.data.documents.forEach((DocumentSnapshot doc) {
                                                    j =doc["location"];
                                                    String name=doc["name"].toString();
                                                    String phone=doc["phone"][0].toString();
                                                    image=doc["image"];
                                                    DocumentReference reg=doc.reference;
                                                    f.add(new Pair(calculateDistance(44.240309,-91.493619 , j.latitude, j.longitude),
                                                        j.latitude,j.longitude,name,reg,phone
                                                    ));
                                                  });
                                                  f.sort();
                                                  String phone=f[0].phone;
                                                  return                 new Row(
                                                    children: <Widget>[
                                                      new FlatButton(
                                                        //color: Color.fromRGBO(31, 58, 147, 1),
                                                        onPressed: () {

                                                        },
                                                        child: new Icon(
                                                          Icons.chat,
                                                          color:  Color.fromRGBO(31, 58, 147, 1),
                                                          size: 25,
                                                        ),
                                                      ),
                                                      new Padding(padding: EdgeInsets.only(left: 1)),
                                                      new FlatButton(
                                                        // color: Color.fromRGBO(31, 58, 147, 1),
                                                        onPressed: () => launch("0899"),
                                                        child: new Icon(
                                                          Icons.call,
                                                          color:  Color.fromRGBO(31, 58, 147, 1),
                                                          size: 25,
                                                        ),
                                                      ),
                                                      new Padding(padding: EdgeInsets.only(left: 20)),
                                                      new Column(
                                                        children: <Widget>[
                                                          new FlatButton(
                                                              onPressed: () {

                                                                setState() {
                                                                  print('ay 7aga 2');
                                                                }
                                                              },
                                                              child: new Text(
                                                                //allMessages.keys.toList()[index],
                                                                //       serivees[index].toString()
                                                                //               messege[index].getrang().toString()
                                                                f[0].name.toString(),
                                                                style: new TextStyle(
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 10),
                                                              )),
                                                          new Text(
                                                            phone.toString(),
                                                            style: new TextStyle(
                                                                color: Colors.grey,
                                                                fontWeight: FontWeight.w100),
                                                          )
                                                        ],
                                                      ),

                                                      new  ClipOval(

                                                        //borderRadius: BorderRadius.circular(100),

                                                        child: Image.network(

                                                          image,
                                                          fit: BoxFit.cover,
                                                          height: 40.0,
                                                          width: 40.0,
                                                          //color: Color.fromRGBO(31, 58, 147, 1),
                                                        ),
                                                      ),
                                                      new Padding(padding: EdgeInsets.only(left: 12)),
                                                    ],
                                                  );

                                              }}


                                        );

                                    }}),
                              new Divider(),
                              new Row(children: <Widget>[
                                new Padding(padding: EdgeInsets.only(left: 250)),
                                new Text(
                                  "اقرب ورشه لك",
                                  style: new TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.right,
                                )
                              ]),
                              StreamBuilder<QuerySnapshot>(
                                  stream:Firestore.instance.collection('specialization').where("name",isEqualTo: favourite_service3).limit(1).snapshots(),
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
                                        DocumentReference d;
                                        snapshot.data.documents.forEach((DocumentSnapshot doc) {
                                          d=doc.reference;
                                        });

                                        return new StreamBuilder<QuerySnapshot>(
                                            stream: Firestore.instance.collection('service').where("specialization",isEqualTo: d).snapshots(),
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
                                                  List <Pair> g=new List();
                                                  String image;
                                                  snapshot.data.documents.forEach((DocumentSnapshot doc) {
                                                    j =doc["location"];
                                                    String name=doc["name"].toString();
                                                    String phone=doc["phone"][0].toString();
                                                    DocumentReference reg=doc.reference;
                                                    image=doc["image"];
                                                    g.add(new Pair(calculateDistance(44.240309,-91.493619 , j.latitude, j.longitude),
                                                        j.latitude,j.longitude,name,reg,phone
                                                    ));
                                                  });
                                                  g.sort();
                                                  return                 new Row(
                                                    children: <Widget>[
                                                      new FlatButton(
                                                        //  color: Color.fromRGBO(31, 58, 147, 1),
                                                        onPressed: () {

                                                        },
                                                        child: new Icon(
                                                          Icons.chat,
                                                          color:  Color.fromRGBO(31, 58, 147, 1),
                                                          size: 25,
                                                        ),
                                                      ),
                                                      new Padding(padding: EdgeInsets.only(left: 1)),
                                                      new FlatButton(
                                                        //  color: Color.fromRGBO(31, 58, 147, 1),
                                                        onPressed: () => launch("0899"),
                                                        child: new Icon(
                                                          Icons.call,
                                                          color:  Color.fromRGBO(31, 58, 147, 1),
                                                          size: 25,
                                                        ),
                                                      ),
                                                      new Padding(padding: EdgeInsets.only(left: 20)),
                                                      new Column(
                                                        children: <Widget>[
                                                          new FlatButton(
                                                              onPressed: () {
                                                                print('ay 7aga 1');

                                                                setState() {
                                                                  print('ay 7aga 2');
                                                                }
                                                              },
                                                              child: new Text(
                                                                //allMessages.keys.toList()[index],
                                                                //       serivees[index].toString()
                                                                //               messege[index].getrang().toString()
                                                                g[0].name.toString(),
                                                                style: new TextStyle(
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 10),
                                                              )),
                                                          new Text(
                                                            g[0].phone.toString(),
                                                            style: new TextStyle(
                                                                color: Colors.grey,
                                                                fontWeight: FontWeight.w100),
                                                          )
                                                        ],
                                                      ),


                                                      new  ClipOval(

                                                        //borderRadius: BorderRadius.circular(100),

                                                        child: Image.network(

                                                          image,
                                                          fit: BoxFit.cover,
                                                          height: 40.0,
                                                          width: 40.0,
                                                          //color: Color.fromRGBO(31, 58, 147, 1),
                                                        ),
                                                      ),



                                                      new Padding(padding: EdgeInsets.only(left: 8)),
                                                    ],
                                                  );

                                              }}


                                        );

                                    }}),
                              new Container(
                                child: new Row(
                                  children: <Widget>[
                                    new Padding(padding: EdgeInsets.only(left: 20)),
                                    new Text(
                                      "Services",
                                      textAlign: TextAlign.left,
                                      style: new TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(31, 58, 147, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              new Padding(padding: EdgeInsets.all(2)),
                              new Flexible(
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: Firestore.instance.collection('service_type').snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                            List <String>ser=new List();
                                            List<DocumentReference> serrefernc=new List();
                                            snapshot.data.documents
                                                .forEach((DocumentSnapshot doc) {
                                              ser.add(doc["name"]);
                                              serrefernc.add(doc.reference);
                                              rt.add(doc.reference.toString());
                                              names.add(doc["name"]);
                                              image.add(doc["image"]);
                                            });
                                            return new ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              //  physics: const NeverScrollableScrollPhysics(),
                                              reverse: true,
                                              itemBuilder: (context, index) {
                                                return new Container(

                                                    child:
                                                    new Row(children: <Widget>[
                                                      new Column(
                                                        children: <Widget>[
                                                          new Text(ser[index]),
                                                          new Padding(

                                                              padding:
                                                              EdgeInsets.all(1)),
                                                          new Container(
                                                            width: 120.0,
                                                            height: 70.0,
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      8.0)),
                                                            ),
                                                            child:
                                                            new FlatButton(
                                                                onPressed: () {
                                                                  print('ay 7aga 1');
                                                                  Navigator.push(
                                                                      context,
                                                                      new MaterialPageRoute(

                                                                          builder: (context) =>
                                                                          new Subcatagories(
                                                                              serrefernc[index],cllient)));
                                                                  setState() {
                                                                    print('ay 7aga 2');
                                                                  }
                                                                },
                                                                /*        child: Image.network(
                                                          "https://w...content-available-to-author-only...k.com/wp-content/uploads/2015/09/البوم-صور-عربيات-1.jpg",
                                                          height: 70,
                                                          width: 100.0,
                                                        ),*/
                                                                child :  Container(
                                                                  //: BorderRadius.circular(15.0),
                                                                  //fit: BoxFit.cover,

                                                                  height:50.0,
                                                                  width: 240.0,
                                                                  decoration: BoxDecoration(

                                                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                    image: DecorationImage(
                                                                      image: NetworkImage(image[index]),
                                                                      fit: BoxFit.cover,

                                                                    ),
                                                                  ),

                                                                )
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      new Padding(
                                                          padding:
                                                          EdgeInsets.only(left: 3))
                                                    ]));
                                              },
                                              itemCount: serrefernc
                                                  .length,
                                            );
                                        }
                                      })),
                            ],
                          ))]);
            }
          }),
      bottomNavigationBar: BottomNavigationBar(
        //fixedColor: Colors.grey,
          backgroundColor: Colors.white,
          selectedItemColor: Color.fromRGBO(31, 58, 147, 1),
          unselectedItemColor: Colors.grey,

          currentIndex: 0,

          // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home,),
              title: new Text(
                'Home',
                style: new TextStyle(color: Colors.grey),
              ),

            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.favorite),
              title: new Text('favorites', style: new TextStyle(color: Colors.grey)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('chat', style: new TextStyle(color: Colors.grey)),),
          ],
          onTap: (index){
            _onItemTapped(index);
          }
      ),
    );
  }
SharedPreferences v;
  void _onItemTapped(int index) {
    setState(() {
      switch(index){
        case 0: {

        }
        break;
        case 1: {
        }
        break;
        case 2: {
          DocumentReference g;
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new Listchat(cllient)));
        }
        break;
        default: {
          //statements;
        }
        break;

      }

    });
  }

  void lx() {
    Firestore.instance.collection('service').snapshots().listen((onData) {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;

    return 12742 * asin(sqrt(a));
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
