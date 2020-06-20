import 'dart:async';
import 'dart:core';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salahly/editprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salahly/dsitance.dart';
import 'package:salahly/image.dart';
import 'package:salahly/loginpage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:like_button/like_button.dart';
import 'package:timeago/timeago.dart' as timeago;
class Comment extends StatefulWidget {
  String F ;
  Comment(String ff)
  {
    this.F = ff;
  }
  @override
  State<StatefulWidget> createState() => new _CommentState();
}
class _CommentState extends State<Comment> {
  bool showHeart = false;
  List<String> comments = [];
  List<String> sender =[];
  List<int>counter=[];
  List <int>ncounter =[];
  int love=0;
  Timestamp Y;
  String t ;
  List<Timestamp>time =[];
  String picc;
  List<String> img =[];
  List<String> rphone =[];
  List<String> rcomment = new List<String>();
  List<String> rsender = new List<String>();
  List<int> rcounter = new List<int>();
  List<Timestamp> rtime = new List<Timestamp>();
String prefss ;
String phone_number ;
  List<String> rimg = new List<String>();
  Timestamp n;
//String t= "comment";
  @override
  void initState() {
    super.initState();
getHighScore();
  }
  getHighScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefss = prefs.getString('email');
      phone_number = prefs.getString('phone');
    });
  }
  //DateTime currentPhoneDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Future sleep1() {
      return new Future.delayed(const Duration(seconds: 2), () => "2");
    }
    Future<bool> onLikeButtonTapped(bool isLiked) async{
      /// send your request here
      // final bool success= await sendRequest();
        Firestore.instance.collection(
            "service").document(
            widget.F).updateData({
          "comments": {
            'comment': {
              'content': rcomment,
              'sender': rsender,
              'love': rcounter,
              'at': rtime,
              'pic': rimg,
            }
          }
        });
      /// if failed, you can do nothing
      // return success? !isLiked:isLiked;
      return !isLiked;
    }
    Future<void> addComment(String val, String email, int count,
        Timestamp currentPhoneDate, String imge) async {
      SharedPreferences prefs2 = await SharedPreferences.getInstance();
      String email = prefs2.getString("email");
      String phone = prefs2.getString("phone");
      String imge = prefs2.getString("profile_pic") ;
      if(imge == null)
        {
          imge = "https://clipartart.com/images/clipart-person-silhouette.png";
        }
      currentPhoneDate = Timestamp.now();
setState(() {
  //var = new DateTime.fromMicrosecondsSinceEpoch(Timestamp);
  comments = rcomment;
  sender = rsender;
  counter = rcounter;
  time = rtime;
  img = rimg;
  comments.add(val);
  counter.add(count);
  time.add(currentPhoneDate);
  img.add(imge);
        if(phone != null)
        {
          sender.add(phone);
        }
        else{
          sender.add(email);
        }
        Firestore.instance.collection("service").document(widget.F).updateData({
               "comments": {
               'comment':{
                 'content': comments,
                 'sender': sender,
                 'love': counter,
                 'at' : time,
                 'pic' :img,
               }
             }
       });
      }
       );
          };
    TextEditingController _text = new TextEditingController();
//print(prefss);
//_readCommentList();
       try{
         return Scaffold(
            body : Container(
              child : Column(
               children: <Widget>[
                     Expanded(
           child : StreamBuilder(
            stream: Firestore.instance.collection('service').document(widget.F).snapshots(),
               builder:
           (context, AsyncSnapshot snapshot) {
                var doc = snapshot.data;
                 if (!snapshot.hasData)
          return new Center(
           child : Text("No Reviews for this service"),
            );
            switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            return new Text(
            'Loading...',
            textDirection: TextDirection.ltr,
              );
              default:
              print(doc['comments']['comment']['content'].toString());
        //print("dsadad");
              if(doc['comments']['comment']['content'] == null )
              {
               return Container(
                child: Text("No Reviews for this Service",style: TextStyle(color: Colors.black),),
                 );
                }
        else {
          rcomment = List.from(doc['comments']['comment']['content']);
          rsender = List.from(doc['comments']['comment']['sender']);
          rcounter = List.from(doc['comments']['comment']['love']);
          rtime= List.from(doc['comments']['comment']['at']);
          rimg= List.from(doc['comments']['comment']['pic']);
              return ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index){
                if (index < rcomment.length){
                  return new Container(
                      child: Stack(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(bottom: 40.0)),
                            Row(children: <Widget>[
                              CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage(
                                    rimg[index]),
                              ),
                              new Padding(
                                  padding: EdgeInsets.only(left: 7)),
                              (phone_number != null) ? {
                                rsender[index] = phone_number,
                                Text(rsender[index] + ": ", style: TextStyle(
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),)} :
                              Text(rsender[index] + ": ", style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold)),
                              Padding(
                                  padding: EdgeInsets.only(left: 40)),
                              Text(timeago.format(rtime[index].toDate())),
                            ],
                            ),
                            Container(height: 20),
                            Padding(
                              padding: EdgeInsets.all(36),
                              child: Card(color: Color(0xffAD0514),
                                child: ListTile(
                                  title: Text(rcomment[index],
                                    style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),),),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 90, left: 220),
                                child: Column(children: <Widget>[
                                  LikeButton(
                                    onTap: onLikeButtonTapped,
                                    size: 48.0,
                                    circleColor:
                                    CircleColor(start: Color(0xffAD0514), end: Color(0xffAD0514)),
                                    bubblesColor: BubblesColor(
                                      dotPrimaryColor: Color(0xffAD0514),
                                      dotSecondaryColor:Color(0xffAD0514),
                                    ),
                                    likeBuilder: (bool isLiked) {
                                      return Icon(
                                        Icons.favorite_border,
                                        color: isLiked ?  Color(0xffAD0514) : null,
                                        size: 24.0,
                                      );
                                    },
                                    likeCount : rcounter[index],
                                    countBuilder: (int count, bool isLiked, String text) {
                                      var color = isLiked ? Colors.black : Colors.black;
                                      Widget result;
                                      if (count == 0) {
                                      result = Text(
                                                  "love",
                                    style: TextStyle(color: color),
                                         );
                                         }
                                      else
                                        result = Text(
                                          text,
                                          style: TextStyle(color: color),
                                        );
                                      rcounter[index] = count;
                                      sleep1();
                                      return result;
                                    },
                                  ),
                                 // Text("${rcounter[index]} love"),
                                ],
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
        },
        )
),
TextField(
controller: _text,
decoration: InputDecoration(contentPadding: const EdgeInsets.all(20.0),focusColor: Colors.white,hoverColor: Colors.white,
hintText: 'Write your Review..',
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(25),

),
fillColor: Color(0xffAD0514),
filled: true,
suffixIcon: IconButton(
icon:Icon(Icons.send),
color: Colors.white,
onPressed: (){
addComment(_text.text,"",love,n,"");
}
),
hintStyle: TextStyle(
color: Colors.white,
),
//focusedBorder: InputBorder.none,
//enabledBorder: InputBorder.none
),
),
]
)
)
);
} catch (e) {
  print(e.massege);
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
}
  }
}
