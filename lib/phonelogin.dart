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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:salahly/myColors.dart' as myColors;

class Phone extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _PhoneState();
}
class _PhoneState extends State<Phone> {
  String phoneNum;
  String smsCode;
  String verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'EG';
  PhoneNumber number = PhoneNumber(isoCode: 'EG');
  bool valdation = false;
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
                FirebaseAuth.instance.currentUser().then((user)
                async {
                  if(user !=null)
                    {
                      SharedPreferences prefs2 = await SharedPreferences.getInstance();
                    prefs2.setString('phone', phoneNum);
                    await Firestore.instance
                        .collection('clients').where('phone',arrayContains:phoneNum).limit(1)
                        .snapshots()
                        .listen((data) {
                      //print(data.documents.length);
                      print(phoneNum);
                      //bool x =false;
                      if (data.documents.length==1) {
                        Navigator.of(context).pushNamed('/categories');
                      }
                      else if (data.documents.length !=1) {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                new Editprofile(
                                    "", "", phoneNum)));
                        return;
                      }
                    });
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
        centerTitle: true,
        title: Text('Phone Number',style: TextStyle(color:myColors.secondText),),
    leading:  IconButton(
    icon: Icon(Icons.arrow_back, color: myColors.secondText),
    onPressed: () => Navigator.of(context).pop(),
    ),
          backgroundColor: Colors.grey.shade100,
            ),
    body: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Form(
    key: formKey,
    child: Container(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
    InternationalPhoneNumberInput(
    onInputChanged: (PhoneNumber number) {
      this.phoneNum =number.phoneNumber;
    //print(phoneNum);
    print(number.phoneNumber);
    },
    ignoreBlank: false,
    autoValidate: true,
    selectorTextStyle: TextStyle(color: Colors.black),
    initialValue: number,
    textFieldController: controller,
    onInputValidated: (value) {
    if (value==null) {
    return 'Enter Your Phone Number';
    }
    return null;
    },
    ),
            SizedBox(height: 10.0),
      FlatButton(
        //elevation: 5.0,
        onPressed: () {
          verifyPhone();
        },
        padding: EdgeInsets.all(10.0),
        child : Row(children: <Widget>[
          Icon(Icons.phone_android,size: 25,color: myColors.green,),
          Padding(padding: EdgeInsets.only(left: 75)),
          VerticalDivider(width: 30,),
          Text(
            'Verify',
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
      ),
    ),
    )
    )
    );
  }
}