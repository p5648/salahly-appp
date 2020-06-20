import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salahly/dsitance.dart';
import 'package:salahly/loginpage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:salahly/subprofile.dart';
import 'package:salahly/image.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String phone2;
  String type="";
  String model="";
  String age="";
  String photo="";
  List<String> rphone = new List<String>();
  var selectedCurracy;
  var selectedCurracy2;
  List<String> phone =[];
  //List<DropdownMenuItem> items2=[];
  Widget build(BuildContext context) {
    updateData()
    {
      setState(() {
        phone.add(_phone1Controller.text);
        phone.add(_phone2Controller.text);
      });
      Firestore.instance.collection("clients").document(widget.iDD).setData({
          'email':email,
        'profile_pic':photo,
            'name': _nameController.text,
        'phone':phone,
            //'first phone number': _phone1Controller.text,
            //'second phone number': _phone2Controller.text,
        'car_type':selectedCurracy,
        'car_model':selectedCurracy2,
        'birthday':_ageController.text,
          }
      );
        }
    return Scaffold(
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
              Text('Edit profile',style:TextStyle(fontStyle:FontStyle.normal,fontWeight: FontWeight.bold,fontSize:22,color: Colors.white),),
            ]
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
    return new Text(
    'Loading...',
    textDirection: TextDirection.ltr,
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
    _phone1Controller.text = phone1;
    _phone2Controller.text = phone2;
    _nameController.text = name;
    _ageController.text = age;
    //_phone1Controller.text = widget.phone1;
    //selectedCurracy=type;
    //selectedCurracy2=model;
    return new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('car_types').snapshots(),
        builder: (context,snapshot) {
          if (!snapshot.hasData)
          {
            return Text("loading");
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
          return Text("loading");
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
           return Center(
    child: SingleChildScrollView(
    physics: AlwaysScrollableScrollPhysics(),
    padding: EdgeInsets.all(15.0),
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
    RaisedButton(
    elevation: 5.0,
    onPressed: () {
    Navigator.push(
    context,
    new MaterialPageRoute(
    builder: (context) =>
    new ImagePage(
    widget.iDD)));
    },
    padding: EdgeInsets.all(15.0),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
    ),
    color:Color(0xffAD0514),
    child: Text(
    "Change photo",
    style: TextStyle(
    color:Colors.white,
    letterSpacing: 1.5,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
    ),
    ),
    ),
    ],
    ),
    new Padding(padding: EdgeInsets.all(8)),
    new Text("email : "+email,
    style: new TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
      new Padding(padding: EdgeInsets.all(6)),
      new Text("phone number : " + phone1,
          style: new TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
      new Padding(padding: EdgeInsets.all(10)),

    TextField(
    controller:_nameController,
    decoration: InputDecoration(
    prefixIcon: Icon(Icons.person),
    )
    ),
    new Padding(padding: EdgeInsets.all(8)),
    TextField(
    controller:_phone2Controller,
    decoration: InputDecoration(
    prefixIcon: Icon(Icons.add_call),
    )
    ),
    new Padding(padding: EdgeInsets.all(8)),
    TextField(
    controller:_ageController,
    decoration: InputDecoration(
    prefixIcon: Icon(Icons.calendar_today),
    )
    ),
    SizedBox(
    height: 10.0,
    ),
    //new Future.delayed(const Duration(seconds: 5), () => "5");
    new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.directions_car,size: 25.0,color: Colors.black,),
          SizedBox(
            width: 50.0,
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
            hint: Text("car_type",style: TextStyle(color: Colors.black),),focusColor: Colors.black,
          )
        ],
      ),
    SizedBox(
    height: 10.0,
    ),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Icon(Icons.directions_car,size: 25.0,color: Colors.black,),
          SizedBox(
          width: 50.0,
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
          hint: Text("car model",style: TextStyle(color: Colors.black),),focusColor: Colors.black,
          )
          ],
          ),
      SizedBox(
        height: 40.0,
      ),
      RaisedButton(
        elevation: 5.0,
        onPressed: () {
          updateData();
          Navigator.of(context).pushNamed('/categories');
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xffAD0514),
        child: Text(
          'Update',
          style: TextStyle(
            color:Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    ],
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