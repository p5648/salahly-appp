import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salahly/categories.dart';
import 'package:salahly/myColors.dart' as myColors;
import 'package:salahly/utilities.dart';
import 'package:url_launcher/url_launcher.dart';
class AddPost extends StatefulWidget{
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  final FirebaseMessaging _fcm = FirebaseMessaging();

  void initState()
  {
    super.initState();
    updatePost("p3vjZpKzHL8mybS4aYoB");
    _fcm.getToken().then((token){
      print(_fcm.getToken());
      Firestore.instance.collection('tokens').add({
        'token':token
      });
    });
  }
  final _formkey = GlobalKey<FormState>();
  TextEditingController _post_title = TextEditingController();
  TextEditingController _post_descripition = TextEditingController();
  TextEditingController _phone = TextEditingController();
  final  formKey = GlobalKey<FormState>();
  final  formKey2 = GlobalKey<FormState>();
  final  formKey3 = GlobalKey<FormState>();
  DocumentReference docReference;
  @override
  void dispose()
  {
    _post_title.dispose();
    _post_descripition.dispose();
    _phone.dispose();
    super.dispose();
  }
  updatePost(String ID){
    }

  @override
  Widget build(BuildContext context) {
    var deviceInfo = MediaQuery.of(context);
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

    // TODO: implement build
    return Scaffold(
        appBar:  new AppBar(
          backgroundColor: myColors.red,
          centerTitle: true,
          title: Text(
            "S A L A H L Y",
            textAlign: TextAlign.right,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                      new cata(
                          "")));
            },
          ),
          actions: <Widget>[
          ],
        ),
      body: Container(
    child: SingleChildScrollView(
    physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
          Column(
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
                    child: TextFormField(
                      controller: _post_title,
                      validator: (value2) =>
                      value2.isEmpty ?
                      "enter your name" : null,
                      onSaved: (value2) => _post_title.text = value2,
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
                        hintText: 'name',
                        hintStyle: kHintTextStyle,
                      ),

                    ),
                  )
            ],
          ),
           Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Text(
        'phone number',
          style: kLabelStyle,
        ),
      SizedBox(height: 10.0),
      Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 55.0,

            child: TextFormField(
              controller: _phone,
              validator: validateMobile,
              onSaved:
                  (value3) => _phone.text = value3,
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
      ],
    ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Post',
                  style: kLabelStyle,
                ),
                SizedBox(height: 10.0),
                Container(
                    alignment: Alignment.centerLeft,
                    decoration: kBoxDecorationStyle,
                    height: 100.0,
                      child: TextFormField(
                        controller: _post_descripition,
                        validator: (value2) =>
                        value2.isEmpty ?
                        "enter your  post" : null,
                        onSaved: (value2) => _post_descripition.text = value2,
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
                            Icons.create,
                            color: myColors.primaryText,
                          ),
                          hintText: "name",
                          hintStyle: kHintTextStyle,
                        ),
                      ),
                    )
              ],
            ),
              Padding(padding:
              EdgeInsets.all(10.0)),
              FlatButton(
                //elevation: 5.0,
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    var current_user = await FirebaseAuth.instance
                        .currentUser();
                    final collRef = Firestore.instance.collection('posts');
                     docReference = collRef.document();
                     docReference.setData({
                      'name': _post_title.text,
                      'post_description': _post_descripition.text,
                      'uid': current_user.uid,
                      'email': current_user.email,
                      'phone_number': _phone.text,
                    });
                     print(docReference.documentID);
                  }
                },
                  padding:
                  EdgeInsets.all(10.0),
                  child : Row(children: <Widget>[
                  Icon(Icons.create,size: 25,color: myColors.green,),
                  Padding(padding: EdgeInsets.only(left: 28)),
                  VerticalDivider(width: 60,),
                  Text(
                  'Add post',
                  style: TextStyle(
                  color:myColors.green,
                  letterSpacing: 1.2,
                  fontSize: 22.0,
                  fontFamily: 'OpenSans SemiBold',
                  )
                  ,
                  )
                  ,
                  ]
                  ,
                  ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: myColors.green)
                ),
                color: myColors.background,
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                onPressed: () async{
                  if(_formkey.currentState.validate()){
                    Firestore.instance.collection('posts').document(docReference.documentID).delete().then((onValue){
                      print('Post Deleted Successfully');
                    });
                  }
                },
                padding:
                EdgeInsets.all(10.0),
                child : Row(children: <Widget>[
                  Icon(Icons.delete,size: 25,color: myColors.red,),
                  Padding(padding: EdgeInsets.only(left: 28)),
                  VerticalDivider(width: 40,),
                  Text(
                    'Delete post',
                    style: TextStyle(
                      color:myColors.red,
                      letterSpacing: 1.2,
                      fontSize: 22.0,
                      fontFamily: 'OpenSans SemiBold',
                    )
                    ,
                  ),
                ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: myColors.red)
                ),
                color: myColors.background,
              ),
    StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('posts').snapshots(),
    builder: (context,snapshot) {
      if (!snapshot.hasData) {
        return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.red),
            )
        );
      }
      else {
        List<String> items1 = [];
        List<String> items2 = [];
        List<String> items3 = [];
        List<String> items4 = [];
        List<String> items5 = [];
        for (int i = 0; i < snapshot.data.documents.length; i++) {
          DocumentSnapshot snap = snapshot.data.documents[i];
          //snapshot.data.documents.map((DocumentSnapshot snap)
          items1.add(
              snap['name'].toString(),
          );
          items2.add(
            snap['phone_number'].toString(),
          );
          items3.add(
            snap['email'].toString(),
          );
          items4.add(
            snap['post_description'].toString(),
          );
          //items2 = List.from(
               //   snap['user']['email']);
        }
        return
           ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                if (index < items2.length) {
                  return new Container(
                      child: Stack(children: <
                          Widget>[
                        Container(height: 20),
                        Padding(
                            padding:
                            EdgeInsets.all(36),
                            child:(
                              new Container(
                                height: deviceInfo.size.height*0.35,
                                decoration: BoxDecoration(
                                    color: myColors.background,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)
                                    ),
                                    boxShadow: [
                                BoxShadow(
                                color: myColors.green.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                                ]
                                ),
                              child: Column(
                                  mainAxisSize: MainAxisSize
                                      .min,
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                        items1[index],
                                        style: TextStyle(
                                            color: Colors
                                                .black,
                                            fontFamily: "Regular OpenSans"),
                                      ),
                                      subtitle: Text(
                                        "email : " +
                                            items3[index].toString(),
                                        style: TextStyle(
                                            color: myColors
                                                .primaryText,
                                            fontFamily: "Regular OpenSans"),),
                                    ),
                                     Row(children: <Widget>[
                                       IconButton(
                                           icon: SvgPicture
                                               .asset(
                                             "assets/icons/phone.svg",
                                             width: 20,
                                             height: 20,
                                           ),
                                           color: Colors
                                               .white,
                                           onPressed: () {
                                             launch("tel:${items2[index]}");
                                           }),
                                       Text(
                                             items2[index].toString(),
                                         style: TextStyle(
                                             color: myColors
                                                 .primaryText,
                                             fontFamily: "Regular OpenSans"),),
                                     ],),
                                    Column(children: <Widget>[
                                      Padding(
                                        padding:
                                        EdgeInsets.all(10)),
                                      Text(
                                        "Post",
                                        style: TextStyle(
                                            color: myColors
                                                .secondText,
                                            fontFamily: "SemiBold OpenSans"),),
                                      Text(
                                            items4[index].toString(),
                                        style: TextStyle(
                                            color: myColors
                                                .primaryText,
                                            fontFamily: "Regular OpenSans"),),
                                    ],),

                                  ]
                              ),
                            )

                            )

                )

                      ]
                      )
                );
              }
              }
              );
      }
    }
    ),
            ],
          ),
        ),
      ),
      )
    );
  }
}