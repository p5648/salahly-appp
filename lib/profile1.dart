import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:salahly/loginpage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salahly/editprofile2.dart';
import 'package:salahly/subprofile.dart';
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
  Profile1(String z)
  {
    this.k = z;
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
  String phone_number;
  List<String> rphone = new List<String>();

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
    return new Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffAD0514),
        leading: Padding(
          padding: EdgeInsets.only(left: 12),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              Text('profile',style:TextStyle(fontStyle:FontStyle.normal,fontWeight: FontWeight.bold,fontSize:22,color: Colors.white),),
            ]
        ),
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
                      return new Text(
                        'Loading...',
                        textDirection: TextDirection.ltr,
                      );
                    default:
                      String name = docc["name"].toString();
                     String  email = docc["email"].toString();
                     String  phone1 = docc["phone"][0].toString();
                      String phone2 = docc["phone"][1].toString();
                      String age = docc["birthday"].toString();
                      String type = docc["car_type"].toString();
                      String model = docc["car_model"].toString();
                      String photo = docc["profile_pic"].toString();
                      return new Container(
                          height: double.infinity,
                          width: double.infinity,
                          padding: EdgeInsets.all(15.0),
                          alignment: Alignment.center,
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
                                            style: new TextStyle(color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24)),
                                        new Padding(padding: EdgeInsets.all(6)),
                                        new Row(
                                          children: <Widget>[
                                            new Icon(
                                              Icons.phone,
                                              color: Colors.black38,
                                            ),
                                            new Padding(
                                                padding: EdgeInsets.only(left: 10)),
                                            new Text(phone1.toString(),
                                              style: new TextStyle(
                                                  color: Colors.black26),
                                            )
                                          ],
                                        ),
                                        new Padding(padding: EdgeInsets.all(6)),
                                        new Row(
                                          children: <Widget>[
                                            new Icon(
                                              Icons.directions_car,
                                              color: Colors.black38,
                                            ),
                                            new Padding(
                                                padding: EdgeInsets.only(left: 10)),
                                            new Text(
                                              type.toString(),
                                              style: new TextStyle(
                                                  color: Colors.black26),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                new Padding(padding: EdgeInsets.all(25)),
                                new Row(
                                  children: <Widget>[
                                    new Text("email", style: new TextStyle(
                                        color: Colors.black54,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    ),
                                    new Padding(
                                        padding: EdgeInsets.only(left: 15)),
                                    new Text(
                                      email.toString(),
                                      style: new TextStyle(
                                          color: Colors.black26, fontSize: 14),
                                    )
                                  ],
                                ),
                                new Padding(padding: EdgeInsets.all(6)),
                                new Divider(),
                                new Padding(padding: EdgeInsets.all(6)),
                                new Row(
                                  children: <Widget>[
                                    new Text("second phone number ", style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    ),
                                    new Padding(
                                        padding: EdgeInsets.only(left: 15)),
                                    new Text(
                                      phone2.toString(),
                                      style: new TextStyle(
                                          color: Colors.black26, fontSize: 14),
                                    )
                                  ],
                                ),
                                new Padding(padding: EdgeInsets.all(6)),
                                new Divider(),
                                new Padding(padding: EdgeInsets.all(6)),
                                new Row(
                                  children: <Widget>[
                                    new Text("car model", style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    ),
                                    new Padding(
                                        padding: EdgeInsets.only(left: 15)),
                                    new Text(
                                      model.toString(),
                                      style: new TextStyle(
                                          color: Colors.black26, fontSize: 12),
                                    )
                                  ],
                                ),
                                new Padding(padding: EdgeInsets.all(6)),
                                new Divider(),
                                new Padding(padding: EdgeInsets.all(6)),
                                new Row(
                                  children: <Widget>[
                                    new Text("age", style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)
                                    ),
                                    new Padding(
                                        padding: EdgeInsets.only(left: 15)),
                                    new Text(
                                      age.toString(),
                                      style: new TextStyle(
                                          color: Colors.black26, fontSize: 14),
                                    ),
                                  ],
                                ),
                                new Padding(padding: EdgeInsets.all(15)),

                                RaisedButton(
                                  elevation: 5.0,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                            new Edit2(
                                                widget.k)));
                                  },
                                  padding: EdgeInsets.all(15.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  color: Color(0xffAD0514),
                                  child: Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                      color:Colors.white,
                                      letterSpacing: 1.5,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                ),
                              ]
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
      String dicid = snapshot.data.documents[0].documentID;

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

      default :
        return new Container(
            height: double.infinity,
            width: double.infinity,

            padding: EdgeInsets.all(15.0),
            alignment: Alignment.center,
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
                              style: new TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24)),
                          new Padding(padding: EdgeInsets.all(6)),
                          new Row(
                            children: <Widget>[
                              new Icon(
                                Icons.phone,
                                color: Colors.black38,
                              ),
                              new Padding(
                                  padding: EdgeInsets.only(left: 10)),
                              new Text(phone1.toString(),
                                style: new TextStyle(
                                    color: Colors.black26),
                              )
                            ],
                          ),
                          new Padding(padding: EdgeInsets.all(6)),
                          new Row(
                            children: <Widget>[
                              new Icon(
                                Icons.directions_car,
                                color: Colors.black38,
                              ),
                              new Padding(
                                  padding: EdgeInsets.only(left: 10)),
                              new Text(
                                type.toString(),
                                style: new TextStyle(
                                    color: Colors.black26),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  new Padding(padding: EdgeInsets.all(25)),
                  new Row(
                    children: <Widget>[
                      new Text("email", style: new TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      ),
                      new Padding(
                          padding: EdgeInsets.only(left: 15)),
                      new Text(
                        email.toString(),
                        style: new TextStyle(
                            color: Colors.black26, fontSize: 14),
                      )
                    ],
                  ),
                  new Padding(padding: EdgeInsets.all(6)),
                  new Divider(),
                  new Padding(padding: EdgeInsets.all(6)),
                  new Row(
                    children: <Widget>[
                      new Text("second phone number ", style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      ),
                      new Padding(
                          padding: EdgeInsets.only(left: 15)),
                      new Text(
                        phone2.toString(),
                        style: new TextStyle(
                            color: Colors.black26, fontSize: 14),
                      )
                    ],
                  ),
                  new Padding(padding: EdgeInsets.all(6)),
                  new Divider(),
                  new Padding(padding: EdgeInsets.all(6)),
                  new Row(
                    children: <Widget>[
                      new Text("car model", style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      ),
                      new Padding(
                          padding: EdgeInsets.only(left: 15)),
                      new Text(
                        model.toString(),
                        style: new TextStyle(
                            color: Colors.black26, fontSize: 12),
                      )
                    ],
                  ),
                  new Padding(padding: EdgeInsets.all(6)),
                  new Divider(),
                  new Padding(padding: EdgeInsets.all(6)),
                  new Row(
                    children: <Widget>[
                      new Text("age", style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)
                      ),
                      new Padding(
                          padding: EdgeInsets.only(left: 15)),
                      new Text(
                        age.toString(),
                        style: new TextStyle(
                            color: Colors.black26, fontSize: 14),
                      ),
                    ],
                  ),
                  new Padding(padding: EdgeInsets.all(6)),
                  new Divider(),
                  new Padding(padding: EdgeInsets.all(15)),
    RaisedButton(
    elevation: 5.0,
    onPressed: () {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
              new Edit2(
                  dicid)));
    },
    padding: EdgeInsets.all(15.0),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
    ),
    color:  Color(0xffAD0514),
    child: Text(
    'Edit Profile',
    style: TextStyle(
    color:Colors.white,
    letterSpacing: 1.5,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
    ),
    ),
    ),
                ]
            )
        );
    }
    }
        ),
    );
  }

}
