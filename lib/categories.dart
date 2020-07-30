import 'dart:async';
//import 'dart:html';
import 'dart:io';
//import 'dart:ui';
//import 'dart:html';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:salahly/myColors.dart' as myColors;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
//import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salahly/wensh.dart';
import 'package:flutter/material.dart';
import 'package:salahly/phonelogin.dart';
import 'package:salahly/splash.dart';
import 'package:salahly/subcategories.dart';
import 'package:salahly/listchat.dart';
import 'package:salahly/chat.dart';
import 'package:salahly/wensh.dart';
import 'package:salahly/gad3ana.dart';
import 'package:salahly/profile1.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:salahly/subcategories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:salahly/listchat.dart';
//import 'package:salahly/profile1.dart';
//import 'location.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:salahly/tawkelat.dart';
//import 'listchat.dart';
class cata extends StatefulWidget {
  static String id= "cata";
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
  String f;
  bool active = false ;
  DocumentReference cllient;
  DocumentReference client2;
  DocumentReference client3;
  List <String> names=new List();
  List <String> image=new List();
  GeoPoint pos  ;
  String docc2;
  String photo="";
  String prefss;
  String tokendocemnyid;
  String phone_number ;
  List <DocumentReference> rt = new List() ;
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
    FirebaseMessaging xnm=new FirebaseMessaging();
    GeoPoint j;
    String phoneidd;
    List<String> rphone = new List<String>();
    var deviceInfo = MediaQuery.of(context);
    String phone ;
    String documrntids;
    //final widg = widget.D ;

    //sleep1();
    return new Scaffold(
      appBar:  new AppBar(
        backgroundColor: myColors.red,
        centerTitle: true,
        title: Text(
          "S A L A H L Y",
          textAlign: TextAlign.right,
        ),
      ),
      drawer :Drawer(
        child: StreamBuilder<QuerySnapshot>(
//          where('service_type',isEqualTo:widget.k).
        stream: Firestore.instance
        .collection('tokens')

        .snapshots(),
    builder:
    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshotm) {
    if (!snapshotm.hasData)
    return new Text(
    'Error: ${snapshotm.error.toString()}',
    textDirection: TextDirection.ltr,
    );
    switch (snapshotm.connectionState) {
      case ConnectionState.waiting:
        return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.red),
            )
        );
      default:
        snapshotm.data.documents.forEach((element) {
          if(cllient==element["client"]){
            tokendocemnyid=element.documentID;
            active=true;
          }
        });
        return ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                    color: myColors.background
                ),
                child:
                StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection('clients').where(
                        "email", isEqualTo: prefss).snapshots(),
                    builder:
                        (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (prefss == null) {
                        return StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance.collection('clients')
                                .snapshots(),
                            builder:
                                (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<
                                            Color>(
                                            myColors.red),
                                      )
                                  );
                                default:
                                  snapshot.data.documents.forEach((
                                      DocumentSnapshot client) {
                                    rphone = List.from(client["phone"]);
                                    if (rphone.elementAt(0) == phone_number) {
                                      photo = client["profile_pic"];
                                      phoneidd = client.documentID;
                                    }
                                  });
                                  return new
                                  Container(
                                      height: deviceInfo.size.height * 0.6,
                                      width: deviceInfo.size.width * 0.8,
                                      child: Column(
                                          children: <Widget>[
                                            Row(children: <Widget>[
                                              CircleAvatar(
                                                radius: 35.0,
                                                backgroundImage: NetworkImage(
                                                    photo.toString()),
                                              ),
                                              new Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 7)),
                                              Text(phone_number.toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'OpenSans Bold'),),
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
                          snapshot.data.documents.forEach((
                              DocumentSnapshot client) {
                            rphone = List.from(client['phone']);
                            if (client["email"] == prefss) {
                              photo = client["profile_pic"];
                              phone = rphone.elementAt(0);
                            }
                          });
                          return new Container(
                              height: deviceInfo.size.height * 0.8,
                              width: deviceInfo.size.width * 0.8,
                              color: myColors.background,
                              child: Column(
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      CircleAvatar(
                                        radius: 35.0,
                                        backgroundImage: NetworkImage(
                                            photo.toString()),
                                      ),
                                      new Padding(
                                          padding: EdgeInsets.only(left: 7)),
                                      Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            Text(prefss.toString(),
                                              style: TextStyle(
                                                color: myColors.secondText,
                                                fontFamily: 'OpenSans Bold',
                                              ),),
                                            new Padding(
                                                padding: EdgeInsets.all(3)),
                                            Align(
                                              //alignment: Alignment(-1.0, 1.0),
                                              child: Text(phone.toString(),
                                                style: TextStyle(
                                                  color: myColors.primaryText,
                                                  fontFamily: 'OpenSans Regular',
                                                ),),
                                            )
                                          ]
                                      )
                                    ]
                                    )
                                  ]
                              )
                          );
                      }
                    })
            ),
            ListTile(
              leading: IconButton(
                  icon: SvgPicture
                      .asset(
                    "assets/icons/home.svg",
                    width: 24,
                    height: 24,)),
              title: Text("Home", style: TextStyle(
                fontFamily: 'OpenSans SemiBold',
                fontSize: 12,
                color: Colors.black,)),
              onTap: () =>
              {
              },
            ),
            ListTile(
              leading: IconButton(
                  icon: SvgPicture
                      .asset(
                    "assets/icons/profile (1).svg",
                    width: 24,
                    height: 24,)),
              title: Text("My profile", style: TextStyle(
                fontFamily: 'OpenSans SemiBold',
                fontSize: 12,
                color: Colors.black,)),
              onTap: () =>
              {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                        new Profile1(phoneidd, rt, names, pos, cllient))),
              },
            ),
            ListTile(
              leading: IconButton(
                  icon: SvgPicture
                      .asset(
                    "assets/icons/setting.svg",
                    width: 24,
                    height: 24,)),
              title: Text("Settings", style: TextStyle(
                fontFamily: 'OpenSans SemiBold',
                fontSize: 12,
                color: Colors.black,)),
              onTap: () => {},
            ),
            ListTile(
                leading: IconButton(
                  icon: active == true ?
                  Icon(Icons.notifications_active, color: myColors.green,) :
                  Icon(Icons.notifications_off, color: myColors.red),
                ),
                title: Text("Active notification", style: TextStyle(
                  fontFamily: 'OpenSans SemiBold',
                  fontSize: 12,
                  color: Colors.black,)),
                onTap: () {
                  if (active == false) {
                    xnm.getToken().then((value) =>
                    {
                      Firestore.instance.collection('tokens').add({
                        'token': value,
                        'client': cllient,
                      }).then((value) {
                        setState(() {
                          active = true;
                        });
                      }),
                    }
                    );
                  }
                  else {

                      Firestore.instance.collection("tokens")
                          .document(tokendocemnyid)
                          .delete()
                          .then((value) {
                        setState(() {
                          active = false;
                        });
                      });
                  }
                }
            ),
            ListTile(
                leading: IconButton(
                    icon: SvgPicture
                        .asset(
                      "assets/icons/search.svg",
                      width: 22,
                      height: 22,)),
                title: Text("Gad3ana", style: TextStyle(
                  fontFamily: 'OpenSans SemiBold',
                  fontSize: 12,
                  color: Colors.black,)),
                onTap: () =>
                {
                  //Navigator.push(
                  //context,
                  //new MaterialPageRoute(
                  // builder: (context) =>
                  //   new H(cllient,pos.latitude,pos.longitude,
                  //      ))
                  //),
                }
            ),
            ListTile(
                leading: IconButton(
                    icon: SvgPicture
                        .asset(
                      "assets/icons/search.svg",
                      width: 22,
                      height: 22,)),
                title: Text("Search", style: TextStyle(
                  fontFamily: 'OpenSans SemiBold',
                  fontSize: 12,
                  color: Colors.black,)),
                onTap: () =>
                {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                          new ClientSearch(rt, names, pos, cllient))),
                }
            ),
            ListTile(
              leading: IconButton(
                  icon: SvgPicture
                      .asset(
                    "assets/icons/logout (1).svg",
                    width: 24,
                    height: 24,)),
              title: Text("Log Out", style: TextStyle(
                fontFamily: 'OpenSans SemiBold',
                fontSize: 12,
                color: Colors.black,)),
              onTap: () async =>
              {
                sharedPrefs = await SharedPreferences.getInstance(),
                await sharedPrefs.clear(),
                Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                        new Splash(
                        ))),
              },
            ),
          ],
        );
    }})
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream:Firestore.instance.collection('clients').where("email",isEqualTo:prefss).snapshots(),
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
                DocumentReference favourite_service0;
                DocumentReference favourite_service1;
                DocumentReference favourite_service3;
                snapshot.data.documents.forEach((DocumentSnapshot client) {
                  print(client["name"]);
                  if(prefss != null)
                  {
                    if(client["email"]==prefss || client["phone"][0]==phone_number){
                      cllient=client.reference;
                      print(client["email"]);
                      return;
                    }
                  }
                  else{
                    print("m shared ");
                  }
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
                          height: MediaQuery.of(context).size.height-80,
                          width: MediaQuery.of(context).size.width*.9,
                          alignment: Alignment.center,
                          child: new Column(
                            children: <Widget>[
                              new Padding(padding: EdgeInsets.all(6)),
                              new Text("الخدمه الاقرب لك", style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),//TextStyle(fontWeight: FontWeight.bold)),
                              new SizedBox(height: 4,),
                              StreamBuilder<QuerySnapshot>(
                                  stream:Firestore.instance.collection('specialization').snapshots(),
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
                                        String x;
                                        snapshot.data.documents.forEach((DocumentSnapshot doc) {
                                          if(doc["name"] == "سمكري") {
                                            d = doc.reference;
                                            x=doc["name"];

                                          }
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
                                                        j.latitude,j.longitude,name,reg,phone,doc["service_owner"]
                                                    ));
                                                  });
                                                  f.sort();
                                                  return
                                                    new Container(
                                                        child:
                                                        Column(
                                                            children: <Widget>[
                                                              new Padding(padding: EdgeInsets.all(1)),
                                                              new Row(children: <Widget>[
                                                                new Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width-120)),
                                                                new Text(
                                                                  "اقرب ميكانيكي لك ",
                                                                  style: new TextStyle(
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  textAlign: TextAlign.right,
                                                                )
                                                              ]),

                                                              new Row(
                                                                children: <Widget>[
                                                                  new FlatButton(
                                                                    onPressed: () {
                                                                      Navigator.push(
                                                                          context,
                                                                          new MaterialPageRoute(
                                                                              builder: (context) => new Chat(
                                                                                serivce_owner:f[0].getServiceOwner(),
                                                                                user: cllient,
                                                                              )));
                                                                    },
                                                                    child: SvgPicture.asset(
                                                                      "assets/icons/chat.svg",
                                                                      width: 24,
                                                                      height: 24,
                                                                      color: myColors.green,
                                                                    ),
                                                                  ),
                                                                  new Padding(padding: EdgeInsets.only(left: 1)),
                                                                  new FlatButton(

                                                                    onPressed: () => launch("tel:${f[0].getphone()}"),
                                                                    child:  SvgPicture.asset(
                                                                      "assets/icons/phone.svg",
                                                                      width: 24,
                                                                      height: 24,
                                                                      color: myColors.red,
                                                                    ),),
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
                                                              ),
                                                            ])            );

                                              }}
                                        );

                                    }}),
                              new Divider(),
                              new SizedBox(height: 17,),
                              StreamBuilder<QuerySnapshot>(
                                  stream:Firestore.instance.collection('specialization').snapshots(),
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
                                        String x;
                                        snapshot.data.documents.forEach((DocumentSnapshot doc) {
                                          if(doc["name"]=="مغسله") {
                                            d = doc.reference;
                                            x=doc["name"];
                                          }
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
                                                        j.latitude,j.longitude,name,reg,phone,doc["service_owner"]
                                                    ));
                                                  });
                                                  f.sort();
                                                  return
                                                    new Container(
                                                        child:
                                                        Column(
                                                            children: <Widget>[
                                                              new Padding(padding: EdgeInsets.all(1)),
                                                              new Row(children: <Widget>[
                                                                new Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width-120)),
                                                                new Text(
                                                                  "اقرب مغسله لك",
                                                                  style: new TextStyle(
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  textAlign: TextAlign.right,
                                                                )
                                                              ]),

                                                              new Row(
                                                                children: <Widget>[
                                                                  new FlatButton(
                                                                    // color: Color.fromRGBO(31, 58, 147, 1),
                                                                    onPressed: () {
                                                                      Navigator.push(
                                                                          context,
                                                                          new MaterialPageRoute(
                                                                              builder: (context) => new Chat(
                                                                                serivce_owner:f[0].getServiceOwner(),
                                                                                user: cllient,
                                                                              )));
                                                                    },
                                                                    child:SvgPicture.asset(
                                                                      "assets/icons/chat.svg",
                                                                      width: 24,
                                                                      height: 24,
                                                                      color: myColors.green,
                                                                    ),
                                                                  ),
                                                                  new Padding(padding: EdgeInsets.only(left: 1)),
                                                                  new FlatButton(
                                                                    onPressed: () => launch("tel:${f[0].getphone()}"),
                                                                    child:  SvgPicture.asset(
                                                                      "assets/icons/phone.svg",
                                                                      width: 24,
                                                                      height: 24,
                                                                      color: myColors.red,
                                                                    ),),
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
                                                                  new Padding(padding: EdgeInsets.only(left: 5)),
                                                                  new SizedBox(width: 20,)
                                                                ],
                                                              ),
                                                            ])            );

                                              }}
                                        );

                                    }}),
                              new Divider(),
                              new SizedBox(height: 17,),
                              StreamBuilder<QuerySnapshot>(
                                  stream:Firestore.instance.collection('specialization').snapshots(),
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
                                        String x;
                                        snapshot.data.documents.forEach((DocumentSnapshot doc) {
                                          if("سمكري"==doc["name"]) {
                                            d = doc.reference;
                                            x=doc["name"];
                                          }
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
                                                        j.latitude,j.longitude,name,reg,phone,doc["service_owner"]
                                                    ));
                                                  });
                                                  f.sort();
                                                  return
                                                    new Container(
                                                        child:
                                                        Column(
                                                            children: <Widget>[
                                                              new Padding(padding: EdgeInsets.all(1)),
                                                              new Row(children: <Widget>[
                                                                new Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width-110)),
                                                                new Text(
                                                                  "اقرب سمكري لك",
                                                                  style: new TextStyle(
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold),
                                                                  textAlign: TextAlign.right,
                                                                )
                                                              ]),
                                                              new Row(
                                                                children: <Widget>[
                                                                  new FlatButton(
                                                                    // color: Color.fromRGBO(31, 58, 147, 1),
                                                                    onPressed: () {
                                                                      Navigator.push(
                                                                          context,
                                                                          new MaterialPageRoute(
                                                                              builder: (context) => new Chat(
                                                                                serivce_owner:f[0].getServiceOwner(),
                                                                                user: cllient,
                                                                              )));
                                                                    },
                                                                    child: SvgPicture.asset(
                                                                      "assets/icons/chat.svg",
                                                                      width: 24,
                                                                      height: 24,
                                                                      color: myColors.green,
                                                                    ),
                                                                  ),
                                                                  new Padding(padding: EdgeInsets.only(left: 1)),
                                                                  new FlatButton(
                                                                    onPressed: () => launch("tel:${f[0].getphone()}"),
                                                                    child:  SvgPicture.asset(
                                                                      "assets/icons/phone.svg",
                                                                      width: 24,
                                                                      height: 24,
                                                                      color: myColors.red,
                                                                    ),),
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
                                                              ),
                                                            ])            );

                                              }}
                                        );

                                    }}),
                              new Divider(),
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
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              new Padding(padding: EdgeInsets.all(2)),
                              new SizedBox(height: 5,),
                              new Flexible(
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: Firestore.instance.collection('service_type').where("active",isEqualTo:true)
                                      .snapshots(),
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
                                              rt.add(doc.reference);
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

                                                          GestureDetector(onTap: (){

                                                          },
                                                            child: new Text(ser[index],style: new TextStyle(fontWeight: FontWeight.bold,
                                                                fontSize: 15),),
                                                          ),
                                                          new SizedBox(height: 10,),
                                                          new Padding(
                                                              padding:
                                                              EdgeInsets.all(1)),
                                                          new Container(
                                                            width: 150.0,
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

                                                                  height:100.0,
                                                                  width: 310.0,
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
        backgroundColor: Colors.grey,
        selectedItemColor: myColors.red,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        // this will be set when a new tab is tapped
        onTap: (index) {
          setState(() {
            _onItemTapped(index);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              width: 24,
              height: 24,
              color: myColors.red,
            ),
            title: new Text(
              '',
              style: new TextStyle(color: Colors.grey),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/chat.svg",
              width: 24,
              height: 24,
              color: Colors.grey,
            ),
            title: new Text('', style: new TextStyle(color: Colors.grey)),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('', style: new TextStyle(color: Colors.grey))),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('', style: new TextStyle(color: Colors.grey))),
          BottomNavigationBarItem(
              icon:SvgPicture.asset(
                "assets/icons/profile (1).svg",
                width: 24,
                height: 24,
              ),
              title: Text('', style: new TextStyle(color: Colors.grey))),
        ],
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
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new Listchat(rt,names,pos,cllient,f)));
        }
        break;
        case 2: {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new ListPage(rt,names,pos,cllient,f)));
        }
        break;
        case 3: { Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                new ClientSearch(rt,names,pos,cllient)));


        }
        break;
        default: {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new Profile1(f,rt,names,pos,cllient)));
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
  DocumentReference serviceowner ;
  Pair(double distance, double lat, double lang, String name,
      DocumentReference t,String phone,DocumentReference serviceOwner) {
    this.distance = distance;
    this.lat = lat;
    this.lang = lang;
    this.name = name;
    this.Re = t;
    this.phone=phone;
    this.serviceowner = serviceOwner;
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
  DocumentReference getServiceOwner()
  {
    return serviceowner;
  }

}