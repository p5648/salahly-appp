import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salahly/loginpage.dart';
import 'package:salahly/categories.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salahly/editphone1.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salahly/choice.dart';
import 'package:salahly/editprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Phone extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _PhoneState();
}
class _PhoneState extends State<Phone> {
  String phoneNum;
  String smsCode;
  String verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future <void> verifyPhone()async{
    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId){
      this.verificationId = verId;

    };
    final PhoneCodeSent smsCodeSent = (String verId,[int forceCodeRecend])
    {
      this.verificationId = verId;
      smsCodeDialog(context).then((value)
      {
        print("signed in");
      });
    };
    final PhoneVerificationCompleted verificationSuccess = (AuthCredential credential) {
      print("verified");
    };
    final PhoneVerificationFailed verificationFailed=(AuthException exception){
      print("${exception.message}");
    };
    await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: this.phoneNum,
        timeout: const Duration(seconds: 5),
        verificationCompleted:verificationSuccess,
        verificationFailed: verificationFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout:autoRetrievalTimeout);
  }
  Future<bool> smsCodeDialog(BuildContext context)
  {
    return showDialog(context: context,barrierDismissible: false,
      builder: (BuildContext context)
        {
          return new AlertDialog(
            title: Text("enter sms code "),
            content: TextField(
              onChanged: (value){
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(onPressed: (){
                FirebaseAuth.instance.currentUser().then((user
                ) async {
                  if(user !=null)
                    { SharedPreferences prefs2 = await SharedPreferences.getInstance();
                    prefs2.setString('phone', phoneNum);
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed("/categories");

                    }
                  else{
                    Navigator.of(context).pop();
                    signIn();
                  }
                });
              },
                  child:Text("Done") )
            ],
          );
        }
    );
  }
  signIn()async{
    AuthCredential credential= PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsCode
    );
    await  FirebaseAuth.instance.signInWithCredential(credential).then((user){
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
              new Editprofile(
                  "","",phoneNum)));

    }).catchError((onError){
      print(onError);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('phone login'),
          backgroundColor: Color(0xffAD0514),
        ),
      body:  new Center(
        child: Container(
        padding: EdgeInsets.all(25.5),
          child: Column(children: <Widget>[
            TextField(
              decoration:InputDecoration(
                hintText: "enter your phone number with your country code"
              ),
              onChanged: (value)
              {
                this.phoneNum = value;
              },
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              onPressed: verifyPhone,
              child: Text("verify"),
              textColor: Colors.white,
              elevation: 7.0,
              color:Color(0xffAD0514),
            )
          ],
          ),
      ),
    ),
    );
  }
}