import'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salahly/choice.dart';
import 'package:salahly/loginpage.dart';
import 'package:salahly/lo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salahly/utilities.dart';
import 'package:salahly/myColors.dart' as myColors;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:salahly/categories.dart';
import 'package:email_validator/email_validator.dart';
import 'package:salahly/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salahly/user_to_database.dart';
import 'package:salahly/categories.dart';
import 'dart:io';
import 'package:path/path.dart' ;
import 'package:salahly/profile1.dart';
class Editprofile extends StatefulWidget {
  String X;
  String Y;
  String Z;
  Editprofile(String x,String y,String z){
    this.X=x;
    this.Y=y;
    this.Z=z;
  }
  @override
  State<StatefulWidget> createState() => new _EditprofileState();
}
class _EditprofileState extends State<Editprofile> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phone1Controller = new TextEditingController();
  TextEditingController _phone2Controller = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _birthdayController = new TextEditingController();

  // bool _isTextFieldVisible = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey4 = GlobalKey<FormState>();
  bool _autovalidate = false;
  var selectedCurracy;
  var selectedCurracy2;
  List<String> phonne = [];
  List<DocumentReference> docref = new List();
  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))'
        r'@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])'
        r'|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    }
    else {
      return null;
    }
  }

  String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    var deviceInfo = MediaQuery.of(context);
    Widget _buildEmailTF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Email',
            style: kLabelStyle,
          ),
          SizedBox(height: 10.0),
          Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 55.0,
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller: _emailController,
                  validator: validateEmail,
                  onSaved: (value1) => _emailController.text = value1,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: myColors.secondText,
                    fontFamily: 'OpenSans Regular',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorStyle: TextStyle(
                        color: myColors.red,
                        fontSize: 15.0,
                        fontFamily: 'OpenSans Regular'
                    ),
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.email,
                      color: myColors.primaryText,
                    ),
                    hintText: 'الايميل',
                    hintStyle: kHintTextStyle,
                  ),

                ),
              )
          ),
        ],
      );
    }

    Widget _buildnameTF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Name',
            style: kLabelStyle,
          ),
          SizedBox(height: 10.0),
          Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 55.0,
              child: Form(key: formKey2,
                child: TextFormField(
                  controller: _nameController,
                  validator: (value2) =>
                  value2.isEmpty ?
                  "enter your name" : null,
                  onSaved: (value2) => _nameController.text = value2,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: myColors.secondText,
                    fontFamily: 'OpenSans Regular',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorStyle: TextStyle(
                        color: myColors.red,
                        fontSize: 15.0,
                        fontFamily: 'OpenSans Regular'
                    ),
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.person,
                      color: myColors.primaryText,
                    ),
                    hintText: 'name',
                    hintStyle: kHintTextStyle,
                  ),
                ),
              )
          ),
        ],
      );
    }

    Widget _phone1TF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'first phone number',
            style: kLabelStyle,
          ),
          SizedBox(height: 10.0),
          Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 55.0,
              child: Form(
                key: formKey3,
                child: TextFormField(
                  controller: _phone1Controller,
                  validator: validateMobile,
                  onSaved:
                      (value3) => _phone1Controller.text = value3,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    color: myColors.secondText,
                    fontFamily: 'OpenSans Regular',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorStyle: TextStyle(
                        color: myColors.red,
                        fontSize: 15.0,
                        fontFamily: 'OpenSans Regular'
                    ),
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: myColors.primaryText,
                    ),
                    hintText: 'phone number',
                    hintStyle: kHintTextStyle,
                  ),


                ),
              )

          ),
        ],
      );
    }

    Widget _phone2TF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'second phone number',
            style: kLabelStyle,
          ),
          SizedBox(height: 10.0),
          Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 55.0,
              child: Form(
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    color: myColors.secondText,
                    fontFamily: 'OpenSans Regular',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorStyle: TextStyle(
                        color: myColors.red,
                        fontSize: 15.0,
                        fontFamily: 'OpenSans Regular'
                    ),
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: myColors.primaryText,
                    ),
                    hintText: 'second phone number',
                    hintStyle: kHintTextStyle,
                  ),
                  controller: _phone2Controller,
                ),
              )
          ),
        ],
      );
    }
    Widget _buildbirthdayTF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Age',
            style: kLabelStyle,
          ),
          SizedBox(height: 10.0),
          Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 55.0,
              child: Form(
                key: formKey4,
                child: TextFormField(
                  controller: _birthdayController,
                  validator: (value4) =>
                  value4.isEmpty ?
                  "enter your age" : null,
                  onSaved: (value4) => _birthdayController.text = value4,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    color: myColors.secondText,
                    fontFamily: 'OpenSans Regular',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorStyle: TextStyle(
                        color: myColors.red,
                        fontSize: 15.0,
                        fontFamily: 'OpenSans Regular'
                    ),
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.calendar_today,
                      color: myColors.primaryText,
                    ),
                    hintText: "السن",
                    hintStyle: kHintTextStyle,
                  ),

                ),
              )
          ),
        ],
      );
    }
    Future<void> doc() async {
      setState(() {
        phonne.insert(0,_phone1Controller.text);
        phonne.insert(1,_phone2Controller.text);
      });
      if (  formKey2.currentState.validate() &&
          formKey3.currentState.validate()
          && formKey4.currentState.validate()) {
        formKey2.currentState.save();
        formKey3.currentState.save();
        formKey4.currentState.save();
//    If all data are not valid then start auto validation.
        DocumentReference docRef = await
        Firestore.instance.collection('clients').add(
            {
              'email': widget.X,
              'profile_pic': "https://clipartart.com/images/clipart-person-silhouette.png",
              'phone': phonne,
              'name': _nameController.text,
              'birthday': _birthdayController.text,
              'car_type': selectedCurracy,
              'car_model': selectedCurracy2,
              'favourite_service_owner':docref,
            });
        //print(docRef.documentID);
        String doc1 = docRef.documentID;
        SharedPreferences prefs1 = await SharedPreferences.getInstance();
        prefs1.setString('email', widget.X);
        Navigator.of(context).pushNamed('/categories');
      }
      else {
        setState(() {
          _autovalidate = true;
        });
      }
    }
    Future<void> doc2() async {
      setState(() {
        phonne.insert(0,widget.Z);
        phonne.insert(1, _phone2Controller.text);
      });
      if ( formKey.currentState.validate() &&
          formKey2.currentState.validate()
          && formKey4.currentState.validate()) {
        formKey.currentState.save();
        formKey2.currentState.save();
        formKey4.currentState.save();
//    If all data are not valid then start auto validation.
        DocumentReference docRef = await
        Firestore.instance.collection('clients').add(
            {
              'email': _emailController.text,
              'phone': phonne,
              "profile_pic" : "https://clipartart.com/images/clipart-person-silhouette.png",
              'name': _nameController.text,
              'birthday': _birthdayController.text,
              'car_type': selectedCurracy,
              'car_model': selectedCurracy2,
              'favourite_service_owner':docref,
            });
        String doc1 = docRef.documentID;
        SharedPreferences prefs2 = await SharedPreferences.getInstance();
        prefs2.setString('phone', widget.Z);
        Navigator.of(context).pushNamed('/categories');
      }
      else {
      setState(() {
      _autovalidate = true;
      });
      }
    }
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(
                  children: <Widget>[
                    Container(
                      //height: double.infinity,
                      width: deviceInfo.size.width,
                      decoration: BoxDecoration(
                      color: myColors.background
                      ),
                    ),
                    Container(
                      height: deviceInfo.size.height,
                      width: deviceInfo.size.width,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 80.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Complete your data',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            ((widget.X != "" || widget.Y != "") || (widget
                                .X != "" && widget.Y != "")) ?
                            Column(children: <Widget>[
                              Text(
                                " YOUR EMAIL  ${widget.X}", style: TextStyle(
                                color: myColors.secondText,
                                fontFamily: 'OpenSans Regular',
                                fontSize: 20.0,
                                ),
                              ),
                              Image.network(widget.Y, height: 50,
                                  width: 50,
                                  fit: BoxFit.fill)
                            ],) :
                            _buildEmailTF(),
                            _buildnameTF(),
                            new Padding(padding: EdgeInsets.all(10)),
                            widget.Z != "" ?
                            Text("YOUR PHONE NUMBER ${widget.Z}",
                              style: TextStyle(
                                color: myColors.primaryText,
                                fontFamily: 'OpenSans Regular',
                                fontSize: 15.0,
                              ),):
                            _phone1TF(),
                            new Padding(padding: EdgeInsets.all(10)),
                            _phone2TF(),
                            _buildbirthdayTF(),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: <Widget>[
                            StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance.collection(
                                    'car_types').snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Text("loading");
                                  }
                                  else {
                                    List<DropdownMenuItem> items = [];
                                    for (int i = 0; i <
                                        snapshot.data.documents.length; i++) {
                                      DocumentSnapshot snap = snapshot.data
                                          .documents[i];
                                      //snapshot.data.documents.map((DocumentSnapshot snap)
                                      items.add(
                                        DropdownMenuItem(
                                          child: Text(snap['type'].toString(),
                                            style: TextStyle(
                                                color: Colors.black),),
                                          value: "${snap['type'].toString()}",
                                        ),
                                      );
                                    }
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        IconButton(
                                            icon: SvgPicture
                                                .asset(
                                              "assets/icons/car (1).svg",
                                              width: 14,
                                              height: 14,)),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        DropdownButton(
                                          items: items,
                                          onChanged: (currentValue) {
                                            setState(() {
                                              selectedCurracy = currentValue;
                                            });
                                          },
                                          value: selectedCurracy,
                                          isExpanded: false,
                                          hint: Text("car type",
                                            style: TextStyle(
                                                color: myColors.primaryText),),
                                          focusColor: myColors.red,
                                        )
                                      ],
                                    );
                                  }
                                }
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance.collection(
                                    'car_model').snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Text("loading");
                                  }
                                  else {
                                    List<DropdownMenuItem> items = [];
                                    for (int i = 0; i <
                                        snapshot.data.documents.length; i++) {
                                      DocumentSnapshot snap = snapshot.data
                                          .documents[i];
                                      //snapshot.data.documents.map((DocumentSnapshot snap)
                                      items.add(
                                        DropdownMenuItem(
                                          child: Text(
                                            snap['model'].toString(),
                                            style: TextStyle(
                                                color: Colors.black),),
                                          value: "${snap['model']
                                              .toString()}",
                                        ),
                                      );
                                    }
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        IconButton(
                                            icon: SvgPicture
                                                .asset(
                                              "assets/icons/car (1).svg",
                                              width: 14,
                                              height: 14,)),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        DropdownButton(
                                          items: items,
                                          onChanged: (currentValue) {
                                            setState(() {
                                              selectedCurracy2 = currentValue;
                                            });
                                          },
                                          value: selectedCurracy2,
                                          isExpanded: false,
                                          hint: Text("car model",
                                            style: TextStyle(
                                                color: myColors.primaryText),),
                                          focusColor: myColors.red,
                                        )
                                      ],
                                    );
                                  }
                                }
                            ),
                      ]
                    ),
                            SizedBox(
                              height: 35.0,
                            ),
                            FlatButton(
                              //elevation: 5.0,
                              onPressed: () {
                                if (widget.X == "" && widget.Y == "") {
                                  doc2();
                                }
                                else {
                                  doc();
                                }
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
                          ],
                        ),
                      ),
                    )
                  ],
                )
            )
        )
    );
  }
}