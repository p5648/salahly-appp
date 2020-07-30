
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salahly/profile1.dart';
import 'package:salahly/lo.dart';
import 'package:salahly/loginpage.dart';
import 'package:salahly/myColors.dart' as myColors;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salahly/user_to_database.dart';
import 'package:salahly/categories.dart';
import 'package:salahly/location2.dart';
import 'package:salahly/utilities.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:salahly/image.dart';
import 'package:path/path.dart' ;
class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {
  SharedPreferences mm;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phone1Controller = new TextEditingController();
  TextEditingController _phone2Controller = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _birthdayController = new TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey4 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey5 = GlobalKey<FormState>();
  //final GlobalKey<FormState> formKey6 = GlobalKey<FormState>();
  bool _autovalidate = false;
  var selectedCurracy;
  var url ="https://clipartart.com/images/clipart-person-silhouette.png";
 // File image;
  //String filename;
  var selectedCurracy2;
  String doc1;
  List<String> phonne = [];
  String photo = "";
  List<Car> cartypes = new List();
  List<DocumentReference> docref = new List();
  List<Car> carmodels = new List();
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
  void initState() {
    super.initState();
    uploadImage();
  }
  Future _getImage() async {
    var selectedImage = await ImagePicker.pickImage(
        source: ImageSource.gallery);
    setState(() {
      image = selectedImage;
      filename = image.path;
    });
  }
  Future<String> uploadImage() async {
    final StorageReference ref = FirebaseStorage.instance.ref().child(filename);
    final StorageUploadTask up= ref.putFile(image);
    String downloadUrl = await (await up.onComplete).ref.getDownloadURL();
    ref.getDownloadURL().then((file) async {

      filename=file;
      url = downloadUrl.toString();
      SharedPreferences prefs2 =await  SharedPreferences.getInstance();
      prefs2.setString('profile_pic', url.toString());
    }
    );
  }
 /* returnFav()
  async {
    await Firestore.instance.collection('specialization').snapshots();
    builder:
    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
    DocumentReference d;
    String x;
    snapshot.data.documents.forEach((DocumentSnapshot doc) {
    if(doc["name"]=="سمكري") {
    d = doc.reference;
    x=doc["name"];
    }
    });
    }
    }
  }*/
  @override
  Widget build(BuildContext context) {
    var deviceInfo = MediaQuery.of(context);
    final FirebaseAuth auth = FirebaseAuth.instance;
    Future<FirebaseUser> handleSignUp(email, password) async {
uploadImage();
try {
  phonne.insert(0,_phone1Controller.text);
  phonne.insert(0,_phone2Controller.text);
  if (formKey.currentState.validate() && formKey2.currentState.validate() &&
      formKey3.currentState.validate()
      && formKey4.currentState.validate() &&
      formKey5.currentState.validate()) {
    formKey.currentState.save();
    formKey2.currentState.save();
    formKey3.currentState.save();
    formKey4.currentState.save();
    formKey5.currentState.save();
    AuthResult result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final FirebaseUser user = result.user;
    assert (user != null);
    assert (await user.getIdToken() != null);
    DocumentReference docRef = await
    Firestore.instance.collection('clients').add(
        {
          'name': _nameController.text,
          'email': user.email,
          'phone': phonne,
          'birthday': _birthdayController.text,
          'car_type': selectedCurracy,
          'car_model': selectedCurracy2,
          "profile_pic": url,
          "favourite_service_owner":docref,

        });
    //print(docRef.documentID);
    doc1 = docRef.documentID;
    Firestore.instance.collection("clients").document(doc1)
        .snapshots()
        .listen((onData) async {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
              new cata(
                  "")));
      SharedPreferences prefs2 = await SharedPreferences.getInstance();
      prefs2.setString('email', user.email);
    });
    return user;
  }
//    If all data are not valid then start auto validation.
  else {
//    If all data are not valid then start auto validation.
    setState(() {
      _autovalidate = true;
      //ok = true;
    });
  }
}
catch (e) {
  if (e.code == "ERROR_EMAIL_ALREADY_IN_USE") {
    Fluttertoast.showToast(
        msg: 'Email already in use',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: myColors.red,
        textColor: Colors.white
    );
  }
}
    }
    Widget _buildSignupBtn() {
      return GestureDetector(
        onTap: () =>  Navigator.of(context).pushNamed('/loginpage'),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'You have an Account? ',
                style: TextStyle(
                    color: myColors.secondText,
                    fontSize: 16.0,
                    fontFamily: 'OpenSans Regular'
                ),
              ),
              TextSpan(
                text: 'Sign In',
                style: TextStyle(
                  color: myColors.red,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }
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
              //width: deviceInfo.size.height,
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
                        color:  myColors.red,
                        fontSize: 15.0,
                        fontFamily: 'OpenSans'
                    ),
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.email,
                      color: myColors.primaryText ,
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
    Widget _buildpasswordTF() {
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
              height: 55.0,
              child: Form(
                key: formKey2,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: (val2) =>
                  val2.length < 4 ?
                  "short password" : null,
                  onSaved: (val2) => _passwordController.text = val2,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorStyle: TextStyle(
                        color: myColors.red,
                        fontSize: 15.0,
                        fontFamily: 'Regular OpenSans'
                    ),
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: myColors.primaryText,
                    ),
                    hintText: 'كلمة السر',
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
            'name',
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
                        color: myColors.red,
                        fontSize: 15.0,
                        fontFamily: 'OpenSans'
                    ),
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.person,
                      color: myColors.primaryText,
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
              height: 55.0,
              child: Form(
                key: formKey4,
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
                        color: myColors.red,
                        fontSize: 15.0,
                        fontFamily: 'OpenSans'
                    ),
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.phone,
                      color:myColors.primaryText,
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
                //key: formKey5,
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorStyle: TextStyle(
                        color: myColors.red,
                        fontSize: 15.0,
                        fontFamily: 'OpenSans'
                    ),
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: myColors.primaryText,
                    ),
                    hintText: 'رقم تليفون اخر',
                    hintStyle: kHintTextStyle,
                  ),
                  controller: _phone2Controller,
                ),
              )
          ),
        ],
      );
    }
    Widget _birthdayTF() {
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
                key: formKey5,
                child: TextFormField(
                  validator: (String value4) =>
                  value4.isEmpty ?
                  "enter your age"
                      : null,
                  onSaved: (value4) => _birthdayController.text = value4,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorStyle: TextStyle(
                        color: myColors.red,
                        fontSize: 15.0,
                        fontFamily: 'OpenSans'
                    ),
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.today,
                      color: myColors.primaryText,
                    ),
                    hintText: 'السن',
                    hintStyle: kHintTextStyle,
                  ),
                  controller: _birthdayController,
                ),
              )
          ),
        ],
      );
    }
    Widget _buildLoginBtn() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 6.0,
          onPressed: () {
            handleSignUp(_emailController.text, _passwordController.text)
                .then((FirebaseUser u) {});
            // Navigator.of(context).pushNamed('/categories');
          },
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: myColors.red,
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 25.0,
              //fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans SemiBold',
            ),
          ),
        ),
      );
    }
    uploadImage();
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height:deviceInfo.size.height,
                width: deviceInfo.size.width,
                decoration: BoxDecoration(
                  color: myColors.background,
                ),
              ),
              Container(
                  height: deviceInfo.size.height,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 100.0,
                  ),
                  child : Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Align(
                            alignment: Alignment(1.0,6.0),
                            child :  new FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: new Icon(
                                Icons.arrow_back_ios,
                                color: myColors.secondText,
                                size: 30.0,
                              ),
                              shape: new CircleBorder(),
                              color: Colors.black12,
                            )
                        ),
                        new Padding(padding: EdgeInsets.only(left: 14)),
                      Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ]
                      ),
                      SizedBox(
                        height:20.0,
                      ),
                  new Column(
                  children: <Widget>[
                    url == null ?   CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage("https://clipartart.com/images/clipart-person-silhouette.png"),
                      child :  Align(
                          alignment: Alignment(6.0, 1.0),
                          child :  new FlatButton(
                            onPressed: () {
                              _getImage();
                            },
                            child: new Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            shape: new CircleBorder(),
                            color: myColors.green,
                          )
                      ),
                    ):
                        Column(
                            children: <Widget>[
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(url.toString()),
                    child :  Align(
                          alignment: Alignment(6.0, 1.0),
                          child :  new FlatButton(
                            onPressed: () {
                              _getImage();
                            },
                            child: new Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            shape: new CircleBorder(),
                            color: myColors.green,
                          )
                      ),
                    )
                      ]
                    ),
                ]
                  ),
                  new Padding(padding: EdgeInsets.all(8)),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildEmailTF(),
                      _buildpasswordTF(),
                      _buildnameTF(),
                      _phone1TF(),
                      _phone2TF(),
                      _birthdayTF(),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(children: <Widget>[
                      StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance.collection('car_types')
                              .snapshots(),
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

                                //cartypes.add(snap.reference,snap["type"].toString());

                                //snapshot.data.documents.map((DocumentSnapshot snap)

                                items.add(
                                  DropdownMenuItem(
                                    child: Text(snap['type'].toString(),
                                      style: TextStyle(color: myColors.primaryText,fontFamily: 'OpenSans Regular',fontSize: 14),),
                                    value: "${snap['type'].toString()}",
                                  ),
                                );
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                              IconButton(
                              icon: SvgPicture
                                  .asset(
                                  "assets/icons/car (1).svg",
                                  width: 20,
                                  height: 20,)),
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
                                      style: TextStyle(color: myColors.primaryText,fontFamily: 'OpenSans Regular',fontSize: 14),),
                                    focusColor: myColors.red,
                                  )
                                ],
                              );
                            }
                          }
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance.collection('car_model')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text("loading");
                            }
                            else {
                              //List<Car> car = new List();
                              List<DropdownMenuItem> items = [];
                              for (int i = 0; i <
                                  snapshot.data.documents.length; i++) {
                                DocumentSnapshot snap = snapshot.data
                                    .documents[i];
                                //car.add(snap["car_types"]);
                                //car.add(snap["car_types"]);
                                //snapshot.data.documents.map((DocumentSnapshot snap)
                                items.add(
                                  DropdownMenuItem(
                                    child: Text(snap['model'].toString(),
                                      style: TextStyle(color: myColors.primaryText,fontFamily: 'OpenSans Regular'),),
                                    value: "${snap['model'].toString()}",
                                  ),
                                );
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                      icon: SvgPicture
                                          .asset(
                                        "assets/icons/car (1).svg",
                                        width: 20,
                                        height: 20,)),
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
                                      style: TextStyle(color: myColors.primaryText,fontFamily: 'OpenSans Regular'),),
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
                        height: 15.0,
                      ),
                      _buildLoginBtn(),
                      _buildSignupBtn(),
                    ],
                  ),
                )
                )
              ]
              )
              )
      )
          );
  }

}
class Car extends RegisterPage
{
  DocumentReference x;
  String g;
  Car(DocumentReference X , String G) {
    this.x = X;
    this.g = G;
    
  }
 returnX()
 {
   return x;
  
  }
  returnG()
  {
    return g;

  }
}


