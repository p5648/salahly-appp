//import 'dart:html';
//import 'dart:html';

import'package:flutter/material.dart';
import 'package:salahly/choice.dart';
import 'package:salahly/loginpage.dart';
import 'package:salahly/lo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salahly/utilities.dart';
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
              height: 60.0,
              child: Form(

                key: formKey,
                child: TextFormField(
                  controller: _emailController,
                  validator: validateEmail,
                  onSaved: (value1) => _emailController.text = value1,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 15.0,
                        fontFamily: 'OpenSans'
                    ),
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color(0xffAD0514),
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
              height: 60.0,
              child: Form(key: formKey2,
                child: TextFormField(
                  controller: _nameController,
                  validator: (value2) =>
                  value2.isEmpty ?
                  "enter your name" : null,
                  onSaved: (value2) => _nameController.text = value2,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 15.0,
                        fontFamily: 'OpenSans'
                    ),
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xffAD0514),
                    ),
                    hintText: 'الاسم',
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
              height: 60.0,
              child: Form(
                key: formKey3,
                child: TextFormField(
                  controller: _phone1Controller,
                  validator: validateMobile,
                  onSaved:
                      (value3) => _phone1Controller.text = value3,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 15.0,
                        fontFamily: 'OpenSans'
                    ),
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Color(0xffAD0514),
                    ),
                    hintText: 'رقم التليفون',
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
              height: 60.0,
              child: Form(
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 15.0,
                        fontFamily: 'OpenSans'
                    ),
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Color(0xffAD0514),
                    ),
                    hintText: 'رقم التليفون الثاني',
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
              height: 60.0,
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
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 15.0,
                        fontFamily: 'OpenSans'
                    ),
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.calendar_today,
                      color: Color(0xffAD0514),
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
      if (formKey2.currentState.validate()) {
        formKey2.currentState.save();
      }
      if (formKey3.currentState.validate()) {
        formKey3.currentState.save();
      }
      if (formKey4.currentState.validate()) {
        formKey4.currentState.save();
      }
      else {
        setState(() {
          _autovalidate = true;
        });
//    If all data are not valid then start auto validation.
        setState(() {
          phonne.add(_phone1Controller.text);
          phonne.add(_phone2Controller.text);
        });

        DocumentReference docRef = await
        Firestore.instance.collection('clients').add(
            {
              'email': widget.X,
              'profile_pic': widget.Y,
              'phone': phonne,
              'name': _nameController.text,
              'birthday': _birthdayController.text,
              'car_type': selectedCurracy,
              'car_model': selectedCurracy2,
            });
        //print(docRef.documentID);
        String doc1 = docRef.documentID;
        SharedPreferences prefs1 = await SharedPreferences.getInstance();
        prefs1.setString('email', widget.X);
        Navigator.of(context).pushNamed('/categories');
      }
    }
      Future<void> doc2() async {
        if (formKey.currentState.validate() ||
            formKey2.currentState.validate()
            || formKey4.currentState.validate()
        ) {
          // formKey.currentState.save();
          formKey.currentState.save();
          formKey2.currentState.save();
          formKey4.currentState.save();
        }
        else {
//    If all data are not valid then start auto validation.
          setState(() {
            _autovalidate = true;
          });
        }
        setState(() {
          phonne.add(widget.Z);
          phonne.add(_phone2Controller.text);
        });
        DocumentReference docRef = await
        Firestore.instance.collection('clients').add(
            {
              'email': _emailController.text,
              'phone': phonne,
              'name': _nameController.text,
              'birthday': _birthdayController.text,
              'car_type': selectedCurracy,
              'car_model': selectedCurracy2,
            });
        //print(docRef.documentID);
        String doc1 = docRef.documentID;
        SharedPreferences prefs2 = await SharedPreferences.getInstance();
        prefs2.setString('phone', widget.Z);
        Navigator.of(context).pushNamed('/categories');
      } //if ((widget.Z == "") && (widget.X == "")) {
      //setState(() => _isTextFieldVisible = true);
      //}
      return Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white30,
                              Colors.white,

                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: double.infinity,
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 120.0,
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
                              ((widget.X != "" || widget.Y != "") || (widget
                                  .X != "" && widget.Y != "")) ?
                              Column(children: <Widget>[
                                Text(
                                  " YOUR EMAIL ${widget.X}", style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,),
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
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,),) :
                              _phone1TF(),
                              new Padding(padding: EdgeInsets.all(10)),
                              _phone2TF(),
                              _buildbirthdayTF(),
                              SizedBox(
                                height: 10.0,
                              ),
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
                                          Icon(Icons.directions_car, size: 25.0,
                                            color: Color(0xffAD0514),),
                                          SizedBox(
                                            width: 50.0,
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
                                            hint: Text("ادخل نوع السياره",
                                              style: TextStyle(
                                                  color: Colors.black),),
                                            focusColor: Color(0xffAD0514),
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
                                          Icon(Icons.directions_car, size: 25.0,
                                            color: Color(0xffAD0514),),
                                          SizedBox(
                                            width: 50.0,
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
                                            hint: Text("ماركة السياره",
                                              style: TextStyle(
                                                  color: Colors.black),),
                                            focusColor: Color(0xffAD0514),
                                          )
                                        ],
                                      );
                                    }
                                  }
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              RaisedButton(
                                elevation: 5.0,
                                onPressed: () {
                                  if (widget.X == "" && widget.Y == "") {
                                    doc2();
                                  }
                                  else {
                                    doc();
                                  }
                                  // Navigator.of(context).pushNamed('/categories');
                                  //Navigator.push(context, new MaterialPageRoute(builder: (context)=>new Home() ));
                                },
                                padding: EdgeInsets.all(15.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Color(0xffAD0514),
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
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


