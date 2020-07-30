import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salahly/dsitance.dart';
import 'package:salahly/loginpage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:salahly/subprofile.dart';
import 'package:salahly/image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salahly/myColors.dart' as myColors;
class Edit2 extends StatefulWidget {

  String iDD ;
  Edit2(String idd)
  {
    this.iDD = idd;
  }

  @override
  State<StatefulWidget> createState() => new _Edit2State();

}
class _Edit2State extends State<Edit2> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phone1Controller = new TextEditingController();
  TextEditingController _phone2Controller = new TextEditingController();
  TextEditingController _ageController = new TextEditingController();
  @override
  String prefss;
  String phne_number;
  List<DocumentReference> docref = new List();

  @override
  void initState() {
    super.initState();
    getHighScore();
  }

  getHighScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefss = prefs.getString('email');
      phne_number = prefs.getString('phone');
    });
  }
  String name="" ;
  String email="";
  String phone1="";
  String phone2="";
  String type="";
  String model="";
  String age="";
  String photo="";
  List<String> rphone = new List<String>();
  var selectedCurracy;
  var selectedCurracy2;
  List<String> phone =new List<String>();
  //List<DropdownMenuItem> items2=[];
  Widget build(BuildContext context) {
    var deviceInfo = MediaQuery.of(context);

    updateData()
    {
      setState(() {
        phone.insert(1, _phone2Controller.text);
      });
      //phone = new List();
      Firestore.instance.collection("clients").document(widget.iDD).setData({
        'email':email,
        'profile_pic':photo,
        'name': _nameController.text,
        'phone':phone,
        'car_type':selectedCurracy,
        'car_model':selectedCurracy2,
        'birthday':_ageController.text,
        'favourite_service_owner':docref,
      }
      );
    }
    _showDialogName() async {
      await showDialog<String>(
          context: context,
          child: new AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: new Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    controller :_nameController,
                    autofocus: true,
                    decoration: new InputDecoration(
                        labelText: 'Update your name',labelStyle: TextStyle( color: myColors.red,
                      fontFamily: 'Regular OpenSans',
                      fontSize: 16,), hintText: 'enter your Name',hintStyle: TextStyle(color: myColors.red,
                        fontFamily: 'Regular OpenSans', fontSize: 16)
                    ),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('CANCEL',style: TextStyle(
                    color: myColors.red,
                    fontFamily: 'Regular OpenSans',
                    fontSize: 16,
                  ),),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('Update',style: TextStyle(
                      color: myColors.red,
                      fontFamily: 'Regular OpenSans',
                      fontSize: 16)),
                  onPressed: () {
                    name = _nameController.text;
                    setState(() {
                      updateData();
                    });
                  })
            ],
          )
      );
    }
    _showDialogSphone() async {
      await showDialog<String>(
          context: context,
          child: new AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: new Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    keyboardType: TextInputType.phone,
                    controller :_phone2Controller,
                    autofocus: true,
                    decoration: new InputDecoration(
                        labelText: 'Update your second number',labelStyle: TextStyle( color: myColors.red,
                      fontFamily: 'Regular OpenSans',
                      fontSize: 16,), hintText: 'enter your second number',hintStyle: TextStyle(color: myColors.red,
                        fontFamily: 'Regular OpenSans', fontSize: 16)
                    ),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('CANCEL',style: TextStyle(
                    color: myColors.red,
                    fontFamily: 'Regular OpenSans',
                    fontSize: 16,
                  ),),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('Update',style: TextStyle(
                      color: myColors.red,
                      fontFamily: 'Regular OpenSans',
                      fontSize: 16)),
                  onPressed: () {
                    phone2= _phone2Controller.text;
                    setState(() {
                      updateData();
                    });
                  })
            ],
          )
      );
    }
    _showDialogAge() async {
      await showDialog<String>(
          context: context,
          child: new AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: new Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    controller :_ageController,
                    keyboardType: TextInputType.phone,
                    autofocus: true,
                    decoration: new InputDecoration(
                        labelText: 'Update your age',labelStyle: TextStyle( color: myColors.red,
                      fontFamily: 'Regular OpenSans',
                      fontSize: 16,), hintText: 'enter your Age',hintStyle: TextStyle(color: myColors.red,
                        fontFamily: 'Regular OpenSans', fontSize: 16)
                    ),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('CANCEL',style: TextStyle(
                    color: myColors.red,
                    fontFamily: 'Regular OpenSans',
                    fontSize: 16,
                  ),),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('Update',style: TextStyle(
                      color: myColors.red,
                      fontFamily: 'Regular OpenSans',
                      fontSize: 16)),
                  onPressed: () {
                    age = _ageController.text;
                    setState(() {
                      updateData();
                    });
                  })
            ],
          )
      );
    }

    return Scaffold(
        appBar:  new AppBar(
          backgroundColor: myColors.red,
          centerTitle: true,
          title: Text(
            "S A L A H L Y",
            textAlign: TextAlign.right,
          ),
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection('clients').document(widget.iDD).snapshots(),
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
                  name = docc["name"].toString();
                  email = docc["email"].toString();
                  phone1 = docc["phone"][0].toString();
                  phone2 = docc["phone"][1].toString();
                  age = docc["birthday"].toString();
                  type = docc["car_type"].toString();
                  model = docc["car_model"].toString();
                  photo = docc["profile_pic"].toString();
                  //_phone1Controller.text = phone1;
                  phone.insert(0,phone1.toString() );
                  _phone2Controller.text = phone2;
                  _nameController.text = name;
                  _ageController.text = age;
                  //_phone1Controller.text = widget.phone1;
                  selectedCurracy=type;
                  selectedCurracy2=model;
                  return new StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance.collection('car_types').snapshots(),
                      builder: (context,snapshot) {
                        if (!snapshot.hasData)
                        {
                          return  Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.red),
                              )
                          );
                        }
                        else{
                          List<DropdownMenuItem> items =[];
                          for(int i=0 ; i<snapshot.data.documents.length ; i++)
                          {
                            DocumentSnapshot snap  = snapshot.data.documents[i];
                            //snapshot.data.documents.map((DocumentSnapshot snap)
                            items.add(
                              DropdownMenuItem(
                                child: Text(snap['type'].toString(),style: TextStyle(color: Colors.black),),
                                value: "${snap['type'].toString()}",
                              ),
                            );
                          }
                          return new StreamBuilder<QuerySnapshot>(
                              stream: Firestore.instance.collection('car_model').snapshots(),
                              builder: (context,snapshot) {
                                if (!snapshot.hasData)
                                {
                                  return  Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                            Colors.red),
                                      )
                                  );
                                }
                                else{
                                  List<DropdownMenuItem> items2 =[];
                                  for(int i=0 ; i<snapshot.data.documents.length ; i++)
                                  {
                                    DocumentSnapshot snap  = snapshot.data.documents[i];
                                    //snapshot.data.documents.map((DocumentSnapshot snap)
                                    items2.add(
                                      DropdownMenuItem(
                                        child: Text(snap['model'].toString(),style: TextStyle(color: Colors.black),),
                                        value: "${snap['model'].toString()}",
                                      ),
                                    );
                                  }
                                  return Container(
                                    height: deviceInfo.size.height,
                                      width: deviceInfo.size.width,
                                      padding: EdgeInsets.all(0.0),
                                      child: SingleChildScrollView(
                                          physics: AlwaysScrollableScrollPhysics(),
                                          padding: EdgeInsets.all(15.0),
                                          child: new Column(
                                            children: <Widget>[
                                              new Row(
                                                children: <Widget>[
                                                  CircleAvatar(
                                                    radius: 50.0,
                                                    backgroundImage: NetworkImage(photo),
                                                  ),
                                                  new Padding(
                                                      padding: EdgeInsets.only(left: 7)),
                                                  FlatButton(
                                                    //elevation: 5.0,
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          new MaterialPageRoute(
                                                              builder: (context) =>
                                                              new ImagePage(
                                                                  widget.iDD)));
                                                    },

                                                    padding: EdgeInsets.all(8.0),
                                                    child : Row(children: <Widget>[
                                                      Icon(Icons.photo_camera,size: 16,color: myColors.red,),
                                                      Padding(padding: EdgeInsets.only(left: 7)),
                                                      Text(
                                                        'Change Photo',
                                                        style: TextStyle(
                                                          color:myColors.red,
                                                          letterSpacing: 1.2,
                                                          fontSize: 12.0,
                                                          fontFamily: 'OpenSans Regular',
                                                        ),
                                                      ),
                                                    ],
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5.0),
                                                        side: BorderSide(color: myColors.red)
                                                    ),
                                                    color: myColors.background,
                                                  ),
                                                ],
                                              ),
                                              new Padding(padding: EdgeInsets.all(6)),
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
                                                  email,
                                                  style: new TextStyle(
                                                      color: myColors.secondText,
                                                      fontSize: 16,
                                                      fontFamily: "OpenSans Regular"),
                                                )
                                            ),
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
                                                  child :new Text("phone number", style: new TextStyle(
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
                                                      phone1,
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
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child:Row(
                                              children: <Widget>[
                                                Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child :new Text("Name", style: new TextStyle(
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
                                                      name,
                                                      style: new TextStyle(
                                                          color: myColors.secondText,
                                                          fontSize: 16,
                                                          fontFamily: "OpenSans Regular"),
                                                    )
                                                ),
                                                ]
                                                ),
                                                //new Padding(
                                                  //  padding: EdgeInsets.only(left: 200)),
                                                Align(
                                                    alignment: Alignment.centerLeft,
                                                    child :new FlatButton(
                                                      onPressed: () {
                                                        _showDialogName();
                                                        //Navigator.pop(context);
                                                      },
                                                      child: new Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: myColors.secondText,
                                                        size: 30.0,
                                                      ),
                                                      shape: new CircleBorder(),
                                                      color: myColors.background,
                                                    )
                                                ),
                                          ]
                                                ),
                                      ),
                                              new Padding(padding: EdgeInsets.all(6)),
                                              new Divider(),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child:Row(
                                                    children: <Widget>[
                                                      Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                        Align(
                                                          alignment: Alignment.topLeft,
                                                          child :new Text("Another Phone Number", style: new TextStyle(
                                                              color: myColors.secondText,
                                                              fontSize: 20,
                                                              fontFamily: "OpenSans Bold"),
                                                          ),
                                                        ),
                                                        new Padding(
                                                            padding: EdgeInsets.all(4)),
                                                        Align(
                                                            alignment: Alignment.topLeft,
                                                            child :new Text(
                                                              phone2,
                                                              style: new TextStyle(
                                                                  color: myColors.secondText,
                                                                  fontSize: 16,
                                                                  fontFamily: "OpenSans Regular"),
                                                            )
                                                        ),
                                                      ]
                                                      ),
                                                      //new Padding(
                                                        //  padding: EdgeInsets.only(left: 200)),
                                                          new FlatButton(
                                                            onPressed: () {
                                                              _showDialogSphone();
                                                              //Navigator.pop(context);
                                                            },
                                                            child: new Icon(
                                                              Icons.arrow_forward_ios,
                                                              color: myColors.secondText,
                                                              size: 30.0,
                                                            ),
                                                            shape: new CircleBorder(),
                                                            color: myColors.background,
                                                      ),
                                                    ]
                                                ),
                                              ),
                                              new Padding(padding: EdgeInsets.all(6)),
                                              new Divider(),
                                      new Padding(padding: EdgeInsets.all(6)),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child:Row(
                                                    children: <Widget>[
                                                      Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                                              age,
                                                              style: new TextStyle(
                                                                  color: myColors.secondText,
                                                                  fontSize: 16,
                                                                  fontFamily: "OpenSans Regular"),
                                                            )
                                                        ),
                                                      ]
                                                      ),
                                                      Align(
                                                          alignment: Alignment.centerLeft,
                                                          child :new FlatButton(
                                                            onPressed: () {
                                                              _showDialogAge();
                                                              //Navigator.pop(context);
                                                            },
                                                            child: new Icon(
                                                              Icons.arrow_forward_ios,
                                                              color: myColors.secondText,
                                                              size: 30.0,
                                                            ),
                                                            shape: new CircleBorder(),
                                                            color: myColors.background,
                                                          )
                                                      ),
                                                    ]
                                                ),
                                              ),
                                              new Padding(padding: EdgeInsets.all(6)),
                                              new Divider(),
                                              new Padding(padding: EdgeInsets.all(6)),
                                              //new Future.delayed(const Duration(seconds: 5), () => "5");
                                              Align(
                                                alignment: Alignment.bottomRight,
                                              child :Row( children: <Widget>[
                                              new Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  IconButton(
                                                      icon: SvgPicture
                                                          .asset(
                                                        "assets/icons/car (1).svg",
                                                        width: 15,
                                                        height: 15,)),
                                                  SizedBox(
                                                    width: 0.0,
                                                  ),
                                                  DropdownButton(
                                                    items: items,
                                                    onChanged: (currentValue)
                                                    {
                                                      setState(() {
                                                        selectedCurracy= currentValue;

                                                      });
                                                    },
                                                    value: selectedCurracy,
                                                    isExpanded: false,
                                                    hint: Text("",
                                                      style: TextStyle(color: myColors.primaryText,fontFamily: 'OpenSans Regular'),),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  IconButton(
                                                      icon: SvgPicture
                                                          .asset(
                                                        "assets/icons/car (1).svg",
                                                        width: 15,
                                                        height: 15,)),
                                                  SizedBox(
                                                    width: 1.0,
                                                  ),
                                                  DropdownButton(
                                                    items: items2,
                                                    onChanged: (currentValue)
                                                    {
                                                      setState(() {
                                                        selectedCurracy2= currentValue;
                                                      });
                                                    },
                                                    value: selectedCurracy2,
                                                    isExpanded: false,
                                                    hint: Text("",
                                                      style: TextStyle(color: myColors.primaryText,fontFamily: 'OpenSans Regular'),),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 40.0,
                                              ),

                                            ],
                                          )
                                              ),
                                              Padding(padding: EdgeInsets.all(20.0)),
                                              FlatButton(
                                                //elevation: 5.0,
                                                onPressed: () {
                                                  updateData();
                                                },
                                                padding: EdgeInsets.all(10.0),
                                                child : Row(children: <Widget>[
                                                  Icon(Icons.save,size: 25,color: myColors.green,),
                                                  Padding(padding: EdgeInsets.only(left: 28)),
                                                  VerticalDivider(width: 30,),
                                                  Text(
                                                    'Save changes',
                                                    style: TextStyle(
                                                      color:myColors.green,
                                                      letterSpacing: 1.2,
                                                      fontSize: 22.0,
                                                      fontFamily: 'OpenSans SemiBold',
                                                    ),
                                                  ),
                                                ],
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    side: BorderSide(color: myColors.green)
                                                ),
                                                color: myColors.background,
                                              ),
                                          ]
                                          )
                                      )
                                  );
                                }
                              }
                          );
                        }
                      }
                  );
              }
            }
        )
    );
  }
}