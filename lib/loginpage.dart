//import 'dart:convert';
import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salahly/dsitance.dart';
import 'package:salahly/loginpage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salahly/profile1.dart';
import 'package:salahly/editprofile.dart';
import 'package:salahly/categories.dart';
import 'package:salahly/profile1.dart';
import 'package:salahly/utilities.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:salahly/categories.dart';
import 'package:email_validator/email_validator.dart';
import 'package:salahly/categories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as JSON;
class LoginPage extends StatefulWidget {

  String x;

  LoginPage(String X) {
    this.x = X;
  }

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {

  //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //GoogleSignIn googleAuth = new GoogleSignIn();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoggedIn = false;
  bool ok = false;
  Map userProfile;
  //bool ok = false ;
  final facebookLogin = FacebookLogin();
  _loginWithFB() async {
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        setState(() async {
          userProfile = profile;
          _isLoggedIn = true;
          if(_auth.currentUser() !=null) {
            SharedPreferences prefs2 = await SharedPreferences.getInstance();
            prefs2.setString('email', userProfile["email"]);
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new cata(
                       "")));
          }
          else {
            AuthCredential credential = FacebookAuthProvider.getCredential(
                accessToken: token);
            FirebaseUser firebaseUser = (
                await FirebaseAuth.instance.signInWithCredential(credential)
            ).user;
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new Editprofile(
                        userProfile["email"],
                        userProfile["picture"]["data"]["url"], "")));
          }
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false);
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false);
        break;
    }
  }
  _logout() {
    facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }
  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser
        .authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    if (FirebaseAuth.instance.currentUser() != null) {
      final FirebaseUser user = (await _auth.signInWithCredential(credential))
          .user;
      SharedPreferences prefs2 = await SharedPreferences.getInstance();
      prefs2.setString('email', user.email);
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
              new cata(
                  "")));
    }
    else {
      final FirebaseUser user = (await _auth.signInWithCredential(credential))
          .user;
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
              new Editprofile(
                  user.email, user.photoUrl,"")));
    }
  }
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
 bool _autovalidate = false;
  //final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    Future<FirebaseUser> handleSignInEmail(String email,
        String password) async {
      if (formKey.currentState.validate() &&
          formKey2.currentState.validate()) {
          formKey.currentState.save();
          formKey2.currentState.save();

          //Scaffold
          //ok=false;
          //  .of(context)
          // .showSnackBar(SnackBar(content: Text('saved')));
        }


      else {
//    If all data are not valid then start auto validation.
        setState(() {
          _autovalidate = true;
          //ok = true;
        });
      }
      try {
      AuthResult result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;
      assert(user != null);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await auth.currentUser();
      Fluttertoast.showToast(
          msg: 'succeeded',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white
      );
      SharedPreferences prefs2 = await SharedPreferences.getInstance();
      prefs2.setString('email', user.email);
      assert(user.uid == currentUser.uid);
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
              new cata(
                  "")));
      print('signInEmail succeeded: $user');
      //ok = true;
      //validateEmail("");
      //if (user.uid != currentUser.uid) {
      return user;
    }
      catch (e) {
      if (e.code == "ERROR_USER_NOT_FOUND") {
        Fluttertoast.showToast(
            msg: 'wrong email or password',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Color(0xffAD0514),
            textColor: Colors.white
        );
      }
      else if(e.code == "ERROR_WRONG_PASSWORD") {
        Fluttertoast.showToast(
            msg: 'wrong password',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Color(0xffAD0514),
            textColor: Colors.white
        );
      }
      else {
        Fluttertoast.showToast(
            msg: 'A prooblem occured ,, try later',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Color(0xffAD0514),
            textColor: Colors.white
        );
      }
      }
    }
String validateEmail(String value)  {
   //    ok2 = ok;
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Email is required";
  }  else if (!regExp.hasMatch(value)) {
    return "Invalid Email";

  }
  else {
    return null;
  }
}
    bool _rememberMe = false;


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
          child:Form(
            key: formKey,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                errorStyle: TextStyle(
                  color:  Color(0xffFF0000),
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
              controller: _emailController,
              validator :validateEmail,
              onSaved: (value1)=>   _emailController.text = value1,
            ),
          )
      ),
      ],
      );
    }
    Widget _buildPasswordTF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'password',
            style: kLabelStyle,
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
      child:Form(
        key: formKey2,
            child: TextFormField(
              validator: (val2)=>val2.length<4 ?
              "short password" :null,
              onSaved: (val2)=> _passwordController.text = val2,
              obscureText: true,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                errorStyle: TextStyle(
                    color: Color(0xffFF0000),
                    fontSize: 15.0,
                    fontFamily: 'OpenSans'
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
                  color:  Color(0xffAD0514),
                ),
                hintText: 'ادخل كلمة السر',
                hintStyle: kHintTextStyle,
              ),
              controller: _passwordController,
            ),
          ),
          )
        ],
      );
    }
    Widget _buildForgotPasswordBtn() {
      return Container(
        alignment: Alignment.centerRight,
        child: FlatButton(
          onPressed: (){
            Navigator.of(context).pushNamed('/forgetpasswordpage');
          },
          padding: EdgeInsets.only(right: 0.0),
          child: Text(
            'Forgot Password?',
            style: kLabelStyle,
          ),
        ),
      );
    }
    Widget _buildRememberMeCheckbox() {
      return Container(
        height: 20.0,
        child: Row(
          children: <Widget>[
            Theme(
              data: ThemeData(unselectedWidgetColor: Colors.white),
              child: Checkbox(
                value: _rememberMe,
                checkColor: Colors.green,
                activeColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value;
                  });
                },
              ),
            ),
            Text(
              'Remember me',
              style: kLabelStyle,
            ),
          ],
        ),
      );
    }
    Widget _buildLoginBtn() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () {
            handleSignInEmail(
                _emailController.text, _passwordController.text);
            //Navigator.push(context, new MaterialPageRoute(builder: (context)=>new Home() ));
          },
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color:Color(0xffAD0514),
          child: Text(
            'LOGIN',
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
    Widget _buildSignInWithText() {
      return Column(
        children: <Widget>[
          Text(
            '- OR -',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Sign in with',
            style: kLabelStyle,

          ),
        ],
      );
    }
    Widget _buildSocialBtn(Function onTap, AssetImage logo) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
            image: DecorationImage(
              image: logo,
            ),
          ),
        ),
      );
    }
    Widget _buildSocialBtnRow() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildSocialBtn(
                  () {
                    _loginWithFB();
                  },
              AssetImage(
                'assets/facebook.jpg',
              ),
            ),
            _buildSocialBtn(
                  () {
      _handleSignIn().then((FirebaseUser user) => print(user))
          .catchError((e) => print(e));
      }, AssetImage(
                'assets/google.jpg',
              ),
            ),
            _buildSocialBtn(
                  () {
                    Navigator.of(context).pushNamed('/phonepage');
              }, AssetImage(
              'assets/images.jpg',
            ),
            ),
          ],
        ),
      );
    }
    Widget _buildSignupBtn() {
      return GestureDetector(
        onTap: () =>  Navigator.of(context).pushNamed('/register'),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Don\'t have an Account? ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Sign Up',
                style: TextStyle(
                  color: Color(0xffAD0514),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      //key: scaffoldKey,
     // key:formKey,
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
                      Colors.transparent,
                    Colors.white30,
                      Colors.white,
                    ],
                    stops: [0.1, 0.4,0.9]
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
                        'Sign In to Salahly',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 20.0,
                      ),
                      _buildPasswordTF(),
                      _buildForgotPasswordBtn(),
                      _buildLoginBtn(),
                      _buildSignInWithText(),
                      _buildSocialBtnRow(),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}