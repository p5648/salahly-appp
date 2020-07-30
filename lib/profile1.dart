import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:salahly/loginpage.dart';
import 'package:salahly/myColors.dart' as myColors;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:salahly/editprofile2.dart';
import 'package:salahly/listchat.dart';
import'package:salahly/tawkelat.dart';
import'package:salahly/wensh.dart';
class Profile1 extends StatefulWidget {

  String k;
  String name ;
  String phone1 ;
  String phone2 ;
  //   x = doc.documentID;
  String emaill ;
  String car_type ;
  String car_model ;
  String birthday ;
  DocumentReference g;
  List<DocumentReference>rt = new List();
  List<String>names = new List();
  GeoPoint pos  ;

  Profile1(String z,List rt,List names,GeoPoint pos ,DocumentReference g)
  {
    this.k = z;
    this.g=g;
    this.rt=rt;
    this.names=names;
    this.pos=pos;
  }
  @override
  State<StatefulWidget> createState() => new _Profile1State();
}
TextEditingController _emailController = new TextEditingController();
TextEditingController _passwordController = new TextEditingController();
TextEditingController _nameController = new TextEditingController();
TextEditingController _phone1Controller = new TextEditingController();
TextEditingController _phone2Controller = new TextEditingController();
TextEditingController _addressController = new TextEditingController();
TextEditingController _birthdayController = new TextEditingController();

class _Profile1State extends State<Profile1> {
  String x;
  @override
  String prefss;
  DocumentReference docref;
  String phone_number;
  List<String> rphone = new List<String>();
  int _page = 0;
  DocumentReference cllient;
  GlobalKey _bottomNavigationKey = GlobalKey();

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
    var deviceInfo = MediaQuery.of(context);
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar:  new AppBar(
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
          },
        ),
        actions: <Widget>[
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('clients').where("email",isEqualTo: prefss).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(prefss == null) {
              return StreamBuilder(
                  stream: Firestore.instance.collection('clients').document(widget.k).snapshots(),
                  builder:
                      ( context, AsyncSnapshot snapshot) {
                    var docc = snapshot.data;
                    if (!snapshot.hasData)
                      return new Text(
                        'Error: ${snapshot.error.toString()}',
                        textDirection: TextDirection.ltr,
                      );
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new  Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.red),
                            )
                        );
                      default:
                        String name = docc["name"].toString();
                        String email = docc["email"].toString();
                        String phone1 = docc["phone"][0].toString();
                        String phone2 = docc["phone"][1].toString();
                        String age = docc["birthday"].toString();
                        String type = docc["car_type"].toString();
                        String model = docc["car_model"].toString();
                        String photo = docc["profile_pic"].toString();
                        docref = snapshot.data.documents[0].reference;
                        return new Container(
                          //height: double.infinity,
                          //width: double.infinity,
                            color: myColors.background,
                            height: deviceInfo.size.height,
                            width: deviceInfo.size.width,
                            alignment: Alignment.center,
                            child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.all(14.0),
                                //alignment: Alignment.center,
                                child: new Column(
                                    children: <Widget>[
                                      new Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            radius: 50.0,
                                            backgroundImage: NetworkImage(photo.toString()),
                                          ),
                                          new Padding(
                                              padding: EdgeInsets.only(left: 7)),
                                          new Column(
                                            children: <Widget>[
                                              new Text(
                                                  name.toString(),
                                                  style: new TextStyle(color: myColors.secondText,
                                                      fontFamily: 'OpenSans Bold',
                                                      fontSize: 24)),
                                              new Padding(padding: EdgeInsets.all(6)),
                                              new Row(
                                                children: <Widget>[
                                                  new Icon(
                                                    Icons.phone,
                                                    color: Colors.black38,
                                                    size: 20,
                                                  ),
                                                  new Padding(
                                                      padding: EdgeInsets.only(left: 10)),
                                                  new Text(phone1.toString(),
                                                    style: new TextStyle(
                                                        color: myColors.primaryText,fontFamily: "OpenSans SemiBold",fontSize: 18),
                                                  )
                                                ],
                                              ),
                                              new Padding(padding: EdgeInsets.all(1)),
                                              FlatButton(
                                                //elevation: 5.0,
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      new MaterialPageRoute(
                                                          builder: (context) =>
                                                          new Edit2(
                                                              widget.k)));
                                                },
                                                padding: EdgeInsets.all(8.0),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    side: BorderSide(color: myColors.red)
                                                ),

                                                color: myColors.background,
                                                child: Text(
                                                  'Edit Profile',
                                                  style: TextStyle(
                                                    color:myColors.red,
                                                    letterSpacing: 1.2,
                                                    fontSize: 12.0,
                                                    fontFamily: 'OpenSans Regular',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      new Padding(padding: EdgeInsets.all(12)),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child :new Text("Email", style: new TextStyle(
                                                  color: myColors.secondText,
                                                  fontSize: 20,
                                                  fontFamily: "OpenSans Bold"),
                                              ),
                                            ),
                                            new Padding(
                                                padding: EdgeInsets.all(4)),
                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child :new Text(
                                                  email.toString(),
                                                  style: new TextStyle(
                                                      color: myColors.secondText,
                                                      fontSize: 16,
                                                      fontFamily: "OpenSans Regular"),
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                      new Padding(padding: EdgeInsets.all(6)),
                                      new Divider(),
                                      new Padding(padding: EdgeInsets.all(6)),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child :new Text("Another phone number", style: new TextStyle(
                                                  color: myColors.secondText,
                                                  fontSize: 20,
                                                  fontFamily: "OpenSans Bold"),
                                              ),
                                            ),
                                            new Padding(
                                                padding: EdgeInsets.all(4)),
                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child :new Text(
                                                  phone2.toString(),
                                                  style: new TextStyle(
                                                      color: myColors.secondText,
                                                      fontSize: 16,
                                                      fontFamily: "OpenSans Regular"),
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                      new Padding(padding: EdgeInsets.all(6)),
                                      new Divider(),
                                      new Align(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                              children: <Widget>[
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child :new Text("Car type", style: new TextStyle(
                                                      color: myColors.secondText,
                                                      fontSize: 20,
                                                      fontFamily: "OpenSans Bold"),
                                                  ),
                                                ),
                                                new Padding(
                                                    padding: EdgeInsets.all(4)),
                                                Align(
                                                    alignment: Alignment.centerLeft,
                                                    child :new Text(
                                                      type.toString(),
                                                      style: new TextStyle(
                                                          color: myColors.secondText,
                                                          fontSize: 16,
                                                          fontFamily: "OpenSans Regular"),
                                                    )
                                                ),
                                              ]
                                          )
                                      ),
                                      new Padding(padding: EdgeInsets.all(6)),
                                      new Divider(),
                                      new Align(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                              children: <Widget>[
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child :new Text("Car Model", style: new TextStyle(
                                                      color: myColors.secondText,
                                                      fontSize: 20,
                                                      fontFamily: "OpenSans Bold"),
                                                  ),
                                                ),
                                                new Padding(
                                                    padding: EdgeInsets.all(4)),
                                                Align(
                                                    alignment: Alignment.centerLeft,
                                                    child :new Text(
                                                      model.toString(),
                                                      style: new TextStyle(
                                                          color: myColors.secondText,
                                                          fontSize: 16,
                                                          fontFamily: "OpenSans Regular"),
                                                    )
                                                ),
                                              ]
                                          )
                                      ),
                                      new Padding(padding: EdgeInsets.all(6)),
                                      new Divider(),
                                      new Padding(padding: EdgeInsets.all(6)),
                                      new Align(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                              children: <Widget>[
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child :new Text("Age", style: new TextStyle(
                                                      color: myColors.secondText,
                                                      fontSize: 20,
                                                      fontFamily: "OpenSans Bold"),
                                                  ),
                                                ),
                                                new Padding(
                                                    padding: EdgeInsets.all(4)),
                                                Align(
                                                    alignment: Alignment.centerLeft,
                                                    child :new Text(
                                                      age.toString(),
                                                      style: new TextStyle(
                                                          color: myColors.secondText,
                                                          fontSize: 16,
                                                          fontFamily: "OpenSans Regular"),
                                                    )
                                                ),
                                                new Padding(padding: EdgeInsets.all(6)),
                                              ]
                                          )
                                      )
                                    ]
                                )
                            )
                        );
                    }
                  }
              );
            }
            String name = snapshot.data.documents[0]["name"];
            String email = snapshot.data.documents[0]["email"];
            String phone1 = snapshot.data.documents[0]["phone"][0];
            String phone2 = snapshot.data.documents[0]["phone"][1];
            String age = snapshot.data.documents[0]["birthday"];
            String type = snapshot.data.documents[0]["car_type"];
            String model = snapshot.data.documents[0]["car_model"];
            String photo = snapshot.data.documents[0]["profile_pic"];
            docref = snapshot.data.documents[0].reference;
            print(docref);
            String dicid = snapshot.data.documents[0].documentID;
            //print(dicid);
            if (!snapshot.hasData)
              return new Text(
                'Error: ${snapshot.error.toString()}',
                textDirection: TextDirection.ltr,
              );
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.red),
                    )
                );
              default :
                return new Container(
                  //height: double.infinity,
                  //width: double.infinity,
                    color: myColors.background,
                    height: deviceInfo.size.height,
                    width: deviceInfo.size.width,
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.all(14.0),
                        //alignment: Alignment.center,
                        child: new Column(

                            children: <Widget>[
                              new Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: NetworkImage(photo.toString()),
                                  ),
                                  new Padding(
                                      padding: EdgeInsets.only(left: 7)),
                                  new Column(
                                    children: <Widget>[
                                      new Text(
                                          name.toString(),
                                          style: new TextStyle(color: myColors.secondText,
                                              fontFamily: 'OpenSans Bold',
                                              fontSize: 24)),
                                      new Padding(padding: EdgeInsets.all(6)),
                                      new Row(
                                        children: <Widget>[
                                          new Icon(
                                            Icons.phone,
                                            color: Colors.black38,
                                            size: 20,
                                          ),
                                          new Padding(
                                              padding: EdgeInsets.only(left: 10)),
                                          new Text(phone1.toString(),
                                            style: new TextStyle(
                                                color: myColors.primaryText,fontFamily: "OpenSans SemiBold",fontSize: 18),
                                          )
                                        ],
                                      ),
                                      new Padding(padding: EdgeInsets.all(1)),
                                      FlatButton(
                                        //elevation: 5.0,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                  new Edit2(
                                                      dicid)));
                                        },
                                        padding: EdgeInsets.all(8.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                            side: BorderSide(color: myColors.red)
                                        ),

                                        color: myColors.background,
                                        child: Text(
                                          'Edit Profile',
                                          style: TextStyle(
                                            color:myColors.red,
                                            letterSpacing: 1.2,
                                            fontSize: 12.0,
                                            fontFamily: 'OpenSans Regular',
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              new Padding(padding: EdgeInsets.all(12)),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child :new Text("Email", style: new TextStyle(
                                          color: myColors.secondText,
                                          fontSize: 20,
                                          fontFamily: "OpenSans Bold"),
                                      ),
                                    ),
                                    new Padding(
                                        padding: EdgeInsets.all(4)),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child :new Text(
                                          email.toString(),
                                          style: new TextStyle(
                                              color: myColors.secondText,
                                              fontSize: 16,
                                              fontFamily: "OpenSans Regular"),
                                        )
                                    )
                                  ],
                                ),
                              ),
                              new Padding(padding: EdgeInsets.all(6)),
                              new Divider(),
                              new Padding(padding: EdgeInsets.all(6)),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child :new Text("Another phone number", style: new TextStyle(
                                          color: myColors.secondText,
                                          fontSize: 20,
                                          fontFamily: "OpenSans Bold"),
                                      ),
                                    ),
                                    new Padding(
                                        padding: EdgeInsets.all(4)),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child :new Text(
                                          phone2.toString(),
                                          style: new TextStyle(
                                              color: myColors.secondText,
                                              fontSize: 16,
                                              fontFamily: "OpenSans Regular"),
                                        )
                                    )
                                  ],
                                ),
                              ),
                              new Padding(padding: EdgeInsets.all(6)),
                              new Divider(),
                              new Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child :new Text("Car type", style: new TextStyle(
                                              color: myColors.secondText,
                                              fontSize: 20,
                                              fontFamily: "OpenSans Bold"),
                                          ),
                                        ),
                                        new Padding(
                                            padding: EdgeInsets.all(4)),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child :new Text(
                                              type.toString(),
                                              style: new TextStyle(
                                                  color: myColors.secondText,
                                                  fontSize: 16,
                                                  fontFamily: "OpenSans Regular"),
                                            )
                                        ),
                                      ]
                                  )
                              ),
                              new Padding(padding: EdgeInsets.all(6)),
                              new Divider(),
                              new Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child :new Text("Car Model", style: new TextStyle(
                                              color: myColors.secondText,
                                              fontSize: 20,
                                              fontFamily: "OpenSans Bold"),
                                          ),
                                        ),
                                        new Padding(
                                            padding: EdgeInsets.all(4)),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child :new Text(
                                              model.toString(),
                                              style: new TextStyle(
                                                  color: myColors.secondText,
                                                  fontSize: 16,
                                                  fontFamily: "OpenSans Regular"),
                                            )
                                        ),
                                      ]
                                  )
                              ),
                              new Padding(padding: EdgeInsets.all(6)),
                              new Divider(),
                              new Padding(padding: EdgeInsets.all(6)),
                              new Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child :new Text("Age", style: new TextStyle(
                                              color: myColors.secondText,
                                              fontSize: 20,
                                              fontFamily: "OpenSans Bold"),
                                          ),
                                        ),
                                        new Padding(
                                            padding: EdgeInsets.all(4)),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child :new Text(
                                              age.toString(),
                                              style: new TextStyle(
                                                  color: myColors.secondText,
                                                  fontSize: 16,
                                                  fontFamily: "OpenSans Regular"),
                                            )
                                        ),
                                        new Padding(padding: EdgeInsets.all(6)),

                                      ]
                                  )
                              )
                            ]
                        )
                    )
                );
            }
          }
      ),
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
              color:Colors.grey,
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
  void _onItemTapped(int index) {
    setState(() {
      switch(index){
        case 0: {
          Navigator.of(context).pushNamed('/categories');
        }
        break;
        case 1: {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new Listchat(widget.rt,widget.names,widget.pos,widget.g,widget.k)));
        }
        break;
        case 2: {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new ListPage(widget.rt,widget.names,widget.pos,widget.g,widget.k)));

        }
        break;
        case 3: {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new ClientSearch(widget.rt,widget.names,widget.pos,widget.g)));
        }

        break;
        default: {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new Profile1(widget.k,widget.rt,widget.names,widget.pos,widget.g)));
        }
      }
    });
  }
}