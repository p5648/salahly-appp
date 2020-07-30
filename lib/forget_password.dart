import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salahly/loginpage.dart';
import 'package:salahly/myColors.dart' as myColors;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Forget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ForgetState();
}
class _ForgetState extends State<Forget> {
  String email = "";
  var formkey = GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {

          //Navigator.push(context, new MaterialPageRoute(builder: (context)=>new Home() ));
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color:Color(0xffAD0514),
        child: Text(
          'Rest password',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    var deviceInfo = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: myColors.background,
          leading:
             IconButton(
              icon: Icon(Icons.arrow_back_ios,color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          title:Align(
              alignment: Alignment.center,
              //children:<Widget>[
                child :Text('Forgotten Password',style:TextStyle(fontFamily: 'OpenSans Bold',fontSize:20,color: myColors.secondText),),
          //mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        body: Container(
          height: deviceInfo.size.height,
          width: deviceInfo.size.width,
          alignment: Alignment.center,
    child: SingleChildScrollView(
    physics: AlwaysScrollableScrollPhysics(),
          child : Form(
        key: formkey,
          child: new Padding(padding: EdgeInsets.only(top: 10,left: 10,right: 10),
          child: Column(children: <Widget>[

     Padding(padding: EdgeInsets.only(top: 30,left: 20,right: 20),
     child: TextFormField(decoration: (InputDecoration(
         //border: InputBorder.none,
         hintText: 'Enter your email')),
       //controller: _emailController,
       validator: (value)
     {
       if(value.isEmpty)
         {
           return "please enter your email " ;
         }
       else {
         email = value;

       }
       return null;
     },
       style: TextStyle(color : myColors.primaryText,),
     ),

),
              Padding(padding: EdgeInsets.only(top: 30,left: 10,right: 10),
child: Container(
  padding: EdgeInsets.symmetric(vertical: 20.0),
  width: deviceInfo.size.width,
  child: RaisedButton(
    elevation: 3.0,
    onPressed: () {
      if(formkey.currentState.validate()) {
        FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value)=>Fluttertoast.showToast(
            msg: 'check your Email',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: myColors.red,
            textColor: Colors.white
        ));
      }
      //Navigator.push(context, new MaterialPageRoute(builder: (context)=>new Home() ));
    },
    padding: EdgeInsets.all(15.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    color:myColors.red,
    child: Text(
      'Send',
      style: TextStyle(
        color: myColors.background,
        letterSpacing: 1.5,
        fontSize: 25.0,
        fontFamily: 'OpenSans SemiBold',
      ),
    ),
  ),
),
              )
                ],
              ),
        )
        )
        )
        )
    );
  }
}
