import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salahly/loginpage.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    return Scaffold(
        body: Center(
          child : Form(
        key: formkey,
          child: new Padding(padding: EdgeInsets.only(top: 50,left: 20,right: 20),

          child: Column(children: <Widget>[
            Text("enter your email and we will send you link to reset your password",style: TextStyle(color: Colors.black,fontSize: 22),),
Theme(
  data: ThemeData(
hintColor: Colors.red,
  ),
   child :  Padding(padding: EdgeInsets.only(top: 50,left: 20,right: 20),
     child: TextFormField(
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
       style: TextStyle(color : Colors.black),
       decoration: InputDecoration(labelText: "Email",border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(20),
       )),
     ),
     ),

),
              Padding(padding: EdgeInsets.only(top: 50,left: 20,right: 20),
child: Container(
  padding: EdgeInsets.symmetric(vertical: 25.0),
  width: double.infinity,
  child: RaisedButton(
    elevation: 5.0,
    onPressed: () {
      if(formkey.currentState.validate()) {
        FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value)=>print("check your email"));
      }
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
        color: Colors.black,
        letterSpacing: 1.5,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
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
    );
  }
}
