//import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:like_button/like_button.dart';
import 'package:salahly/comment.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:salahly/image.dart';
import 'package:salahly/location.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salahly/utilities.dart';
import 'package:salahly/myColors.dart' as myColors;
import 'package:timeago/timeago.dart' as timeago;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salahly/myColors.dart' as myColors;

class detailsserives2 extends StatefulWidget {
  String catagories;
  String name;
  String idd;
  detailsserives2(String catagoris, String name, String iDD) {
    this.name = name;
    this.catagories = catagoris;
    this.idd = iDD;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Homestate();
  }
}

//final pat=FirebaseDatabase.instance.reference().child("");
class Homestate extends State<detailsserives2> {
  List<String> comments = [];
  bool showHeart = false;
  List<String> sender = [];
  List<int> counter = [];
  List<int> ncounter = [];
  int love = 0;
  Timestamp Y;
  String t;
  List<Timestamp> time2 = [];
  String picc;
  List<String> img = [];
  List<String> rphone = [];
  List<String> rcomment = new List<String>();
  List<String> rsender = new List<String>();
  List<int> rcounter = new List<int>();
  List<Timestamp> rtime = new List<Timestamp>();
  String prefss;
  String phone_number;
  List<String> rimg = new List<String>();
  Timestamp n;
  int Radio = 0;
  String reslut = "";
  TextEditingController name;
  TextEditingController phone;
  TextEditingController email;
  TextEditingController location;
  TextEditingController offdays;
  TextEditingController price;
  TextEditingController img2;
  TextEditingController desc;

  var geolocator;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = new TextEditingController();
    email = new TextEditingController();
    phone = new TextEditingController();
    location = new TextEditingController();
    offdays = new TextEditingController();
    price = new TextEditingController();
    img2 = new TextEditingController();
    desc = new  TextEditingController();

    _getAddressFromLatLng(xx);
  }

  void Raioonchanges() {}
  GeoPoint _currentPosition;
  String _currentAddress;
  List<String> phonelist = new List<String>();
  List<String> off_dayslist = new List();

  _getAddressFromLatLng(GeoPoint x) async {
    try {
      List<Placemark> p =
          await Geolocator().placemarkFromCoordinates(30.074450, 31.214590);

      Placemark place = p[0];

      setState(() {
        location.text =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
      return location.text;
    } catch (e) {
      print(e.toString());
    }
  }

  GeoPoint xx;
  var x;
  double readrating;
  double newrating;
  Map<String, dynamic> priceList = new Map();
  Map<String, dynamic> time3 = new Map();
  var documentReferencee;
  String splization;
  String docid;
  String description ;
  Future<String> submitAll() async {
    await Firestore.instance
        .collection('service')
        .where("name", isEqualTo: widget.name)
        .snapshots()
        .listen((data) => data.documents.forEach((doc) {
              name.text = doc["name"];
              img2.text = doc["image"];
              desc.text = doc["description"];
              xx = doc['location'];
              //   x = doc.documentID;
              phonelist = List.from(doc["phone"]);
              phonelist = List.from(doc["phone"]);
              off_dayslist = List.from(doc["off_days"]);
              priceList = Map.from(doc["price"]);
              time3 = Map.from(doc["time"]);
              docid = doc.documentID;
              print("Name while submitAll: ${name.text}");
              documentReferencee = doc["specialization"];
            }));
    await Firestore.instance
        .collection('specialization')
        .reference()
        .snapshots()
        .listen((data) => data.documents.forEach((df) {
              if (documentReferencee == df.reference) {
                splization = df["name"];
              }
            }));
  }

  int starCount = 5;
  int counter2;
  double rating = 0.0;
  Future<void> rate() async {
    if (counter2 == 0) {
      newrating = rating;
      counter2++;
      Firestore.instance.collection("service").document(widget.idd).updateData({
        'rating': newrating,
        'counter': counter,
      });
    } else if (counter2 != 0) {
      newrating = (newrating * counter2 + rating) / (counter2 + 1);
      counter2++;
      Firestore.instance.collection("service").document(widget.idd).updateData({
        'rating': newrating,
        'counter': counter2,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var deviceInfo = MediaQuery.of(context);
    submitAll();
    // rate();
    Future sleep1() {
      return new Future.delayed(const Duration(seconds: 2), () => "2");
    }

    Future<bool> onLikeButtonTapped(bool isLiked) async {
      /// send your request here
      // final bool success= await sendRequest();
      Firestore.instance.collection("service").document(widget.idd).updateData({
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
      String imge = prefs2.getString("profile_pic");
      if (imge == null) {
        imge = "https://clipartart.com/images/clipart-person-silhouette.png";
      }
      currentPhoneDate = Timestamp.now();
      setState(() {
        //var = new DateTime.fromMicrosecondsSinceEpoch(Timestamp);
        comments = rcomment;
        sender = rsender;
        counter = rcounter;
        time2 = rtime;
        img = rimg;
        comments.add(val);
        counter.add(count);
        time2.add(currentPhoneDate);
        img.add(imge);
        if (phone != null) {
          sender.add(phone);
        } else {
          sender.add(email);
        }
        Firestore.instance
            .collection("service")
            .document(widget.idd)
            .updateData({
          "comments": {
            'comment': {
              'content': comments,
              'sender': sender,
              'love': counter,
              'at': time2,
              'pic': img,
            }
          }
        });
      });
    }

    ;
    TextEditingController _text = new TextEditingController();
//_getAddressFromLatLng(xx);
    print("Name after submitAll: ${name.text}");
    return new Scaffold(
        //backgroundColor: Colors.white,
        body: new Container(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('service')
                        .document(widget.idd)
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      var doc = snapshot.data;
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
                          counter2 = doc["counter"];
                          newrating = doc["rating"];
                          print(doc['comments']['comment']['content']
                              .toString());
                          //print("dsadad");
                          if (doc['comments']['comment']['content'] ==
                              null) {
                            return Container(
                              child: Text(
                                "No Reviews for this Service",
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          } else {
                            rcomment = List.from(doc['comments']
                            ['comment']['content']);
                            rsender = List.from(
                                doc['comments']['comment']['sender']);
                            rcounter = List.from(
                                doc['comments']['comment']['love']);
                            rtime = List.from(
                                doc['comments']['comment']['at']);
                            rimg = List.from(
                                doc['comments']['comment']['pic']);
                            // description = doc["description"];
                            return  Column(children: <Widget>[
                              Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                 image: NetworkImage(
                                  img2.text,),
                                  fit: BoxFit.cover,
                                ),
                              ),
                                //new Padding(padding: EdgeInsets.all(50)),
                                //alignment: Alignment.center,
                       //alignment: Alignment.centerRight,
                       child : new Container
                         (child : Padding(padding: EdgeInsets.all(15)),
                        height: deviceInfo.size.height * 0.62,
                        width: deviceInfo.size.width * 0.8,
                                    //margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        //color: myColors.background, //background color of box
                                        BoxShadow(
                                          color: myColors.primaryText,
                                          blurRadius: 12.0, // soften the shadow
                                          spreadRadius: 3.0, //extend the shadow
                                          offset: Offset(
                                            15.0,
                                            // Move to right 10  horizontally
                                            15.0, // Move to bottom 10 Vertically
                                          ),
                                        )
                                      ],
                                      color: myColors.background,
                                      // border: Border.all(color: myColors.primaryText),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                     Column(
                                        children: <Widget>[
                                          Text(name.text,
                                              style: new TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'SemiBold OpenSans',
                                                  fontSize: 24)),
                                          Text(
                                            splization.toString(),
                                            style: new TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: ' Regular OpenSans'),
                                          ),
                                          new StarRating(
                                            size: 25.0,
                                            rating: newrating,
                                            color: myColors.green,
                                            borderColor: myColors.primaryText,
                                            starCount: starCount,
                                          ),
                                          //SizedBox(height: 10),
                                          new Padding(
                                              padding: EdgeInsets.only(
                                                  right: 10)),
                                          Row(
                                            children: <Widget>[
                                              new Icon(
                                                Icons.location_on,
                                                color: myColors.primaryText,
                                              ),
                                              new Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10)),
                                              new Text(
                                                location.text,
                                                style: new TextStyle(
                                                    color: myColors
                                                        .primaryText),
                                              )
                                            ],
                                          ),
                                          new Row(
                                            children: <Widget>[
                                              new Icon(
                                                Icons.access_time,
                                                color: myColors.primaryText,
                                              ),
                                              new Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15)),
                                              new Text(
                                                time3.toString(),
                                                style: new TextStyle(
                                                    color: myColors.primaryText,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              new Icon(
                                                Icons.work,
                                                color: myColors.primaryText,
                                              ),
                                              new Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15)),
                                              new Text(
                                                off_dayslist[0].toString() +
                                                    ",," +
                                                    off_dayslist[1].toString(),
                                                style: new TextStyle(
                                                    color: myColors.primaryText,
                                                    fontSize: 14),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Align(
                                            alignment: Alignment(-0.9, -0.5),
                                            child: Text(
                                              "Description",
                                              style: new TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontFamily: 'Bold OpenSans'),
                                            ),
                                          ),

                                          SizedBox(height: 10),
                                          Align(
                                            alignment: Alignment(-0.4, -0.8),
                                            child: Text(
                                              desc.text,
                                              style: new TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: 'Bold OpenSans'),
                                            ),
                                          ),
                                          LikeButton(
                                            //onTap:
                                            size: 60.0,
                                            circleColor: CircleColor(
                                                start: myColors.red,
                                                end: myColors.red),
                                            bubblesColor:
                                            BubblesColor(
                                                dotPrimaryColor:
                                                myColors.red,
                                                dotSecondaryColor:
                                                myColors.red
                                            ),
                                            likeBuilder: (bool
                                            isLiked) {
                                              return Icon(
                                                Icons
                                                    .favorite_border,
                                                color: isLiked
                                                    ? myColors.red
                                                    : null,
                                                size: 34.0,
                                              );
                                            },
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            "Add to Favourites",
                                            style: new TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontFamily: 'SemiBold OpenSans'),
                                          ),
                                          Divider(),
                                          Row(
                                            children: <Widget>[
                                              Column(children: <Widget>[
                                                IconButton(
                                                    icon: SvgPicture.asset(
                                                      "assets/icons/chat.svg",
                                                      width: 20,
                                                      height: 20,
                                                      //color: myColors.green,
                                                    ),
                                                    color: Colors.white,
                                                    onPressed: () {}),
                                                Text(
                                                  "chat",
                                                  style: new TextStyle(
                                                      color: myColors.red,
                                                      fontSize: 14,
                                                      fontFamily: 'SemiBold OpenSans'),
                                                ),
                                              ],),
                                              VerticalDivider(
                                                  color: Colors.red, width: 70),
                                              Column(children: <Widget>[
                                                IconButton(
                                                    icon: SvgPicture.asset(
                                                      "assets/icons/phone.svg",
                                                      width: 20,
                                                      height: 20,
                                                      //color: myColors.green,
                                                    ),
                                                    color: Colors.white,
                                                    onPressed: () {}),
                                                Text(
                                                  "call",
                                                  style: new TextStyle(
                                                      color: myColors.green,
                                                      fontSize: 14,
                                                      fontFamily: 'SemiBold OpenSans'),
                                                ),
                                              ],),
                                              VerticalDivider(
                                                  color: Colors.black,
                                                  width: 70),
                                              Column(children: <Widget>[
                                                IconButton(
                                                    icon: SvgPicture.asset(
                                                      "assets/icons/location-arrow.svg",
                                                      width: 20,
                                                      height: 20,
                                                      //color: myColors.green,
                                                    ),
                                                    color: Colors.white,
                                                    onPressed: () {}),
                                                Text(
                                                  "Go",
                                                  style: new TextStyle(
                                                      color: myColors.red,
                                                      fontSize: 14,
                                                      fontFamily: 'SemiBold OpenSans'),
                                                ),
                                              ],),
                                            ],
                                          )
                                        ]
                                    )
                                    )
                                ),

                              new Padding(
                                  padding: EdgeInsets.all(15)),
                              StarRating(
                                size: 35.0,
                                rating: rating,
                                color: myColors.green,
                                borderColor: myColors.primaryText,
                                starCount: starCount,
                                onRatingChanged: (rating) =>
                                    setState(
                                          () {
                                        this.rating = rating;
                                        rate();
                                      },
                                    ),
                              ),
                              new Padding(
                                  padding: EdgeInsets.all(20)),
                              Container(
                                height : 260,
                              child : ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    if (index < rcomment.length) {
                                      return new Container(
                                          child: Stack(children: <
                                              Widget>[
                                            Padding(
                                                padding:
                                                EdgeInsets.only(
                                                    bottom: 40.0)),
                                            Row(
                                              children: <Widget>[
                                                CircleAvatar(
                                                  radius: 20.0,
                                                  backgroundImage:
                                                  NetworkImage(
                                                      rimg[index]),
                                                ),
                                                new Padding(
                                                    padding:
                                                    EdgeInsets.only(
                                                        left: 7)),
                                                (phone_number != null)
                                                    ? {
                                                  rsender[index] =
                                                      phone_number,
                                                  Text(
                                                    rsender[index] +
                                                        ": ",
                                                    style: TextStyle(
                                                        color: myColors
                                                            .secondText,
                                                        fontFamily: 'Regular OpenSans'),
                                                  )
                                                }
                                                    : Text(
                                                    rsender[index],
                                                    style: TextStyle(
                                                        color: myColors
                                                            .secondText,
                                                        fontFamily: 'Regular OpenSans')),
                                              ],
                                            ),
                                            Container(height: 20),
                                            Padding(
                                                padding:
                                                EdgeInsets.all(36),
                                                child: Card(
                                                  color:
                                                  Colors.grey[100],
                                                  child: Column(
                                                      mainAxisSize: MainAxisSize
                                                          .min,
                                                      children: <Widget>[
                                                        ListTile(
                                                          title: Text(
                                                            rcomment[index],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily: "Regular OpenSans"),
                                                          ),
                                                          subtitle: Text(
                                                            "from " +
                                                                timeago.format(
                                                                    rtime[index]
                                                                        .toDate()),
                                                            style: TextStyle(
                                                                color: myColors
                                                                    .primaryText,
                                                                fontFamily: "Regular OpenSans"),),
                                                        )
                                                      ]
                                                  ),
                                                )
                                            ),
                                            Padding(
                                                padding:
                                                EdgeInsets.only(
                                                    top: 110,
                                                    left: 260),
                                                child: Column(
                                                  children: <Widget>[
                                                    LikeButton(
                                                      onTap:
                                                      onLikeButtonTapped,
                                                      size: 48.0,
                                                      circleColor: CircleColor(
                                                          start: Color(
                                                              0xffAD0514),
                                                          end: Color(
                                                              0xffAD0514)),
                                                      bubblesColor:
                                                      BubblesColor(
                                                        dotPrimaryColor:
                                                        Color(
                                                            0xffAD0514),
                                                        dotSecondaryColor:
                                                        Color(
                                                            0xffAD0514),
                                                      ),
                                                      likeCount:
                                                      rcounter[
                                                      index],
                                                      likeBuilder: (bool
                                                      isLiked) {
                                                        return Icon(
                                                          Icons
                                                              .favorite_border,
                                                          color: isLiked
                                                              ? Color(
                                                              0xffAD0514)
                                                              : null,
                                                          size: 24.0,
                                                        );
                                                      },
                                                      countBuilder: (int
                                                      count,
                                                          bool isLiked,
                                                          String text) {
                                                        var color = isLiked
                                                            ? Colors
                                                            .black
                                                            : Colors
                                                            .black;
                                                        int result2;
                                                        if (count ==
                                                            0) {
                                                          result2 = 0;
                                                        }
                                                        else
                                                          rcounter[
                                                          index] =
                                                              count;
                                                        sleep1();
                                                        //return result;
                                                      },
                                                    ),
                                                    // Text("${rcounter[index]} love"),
                                                  ],
                                                ))
                                          ]));
                                    }
                                  }),
                              ),
                              TextField(
                                controller: _text,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(20.0),
                                  focusColor: Colors.white,
                                  hoverColor: Colors.white,
                                  hintText: 'Write your Review..',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),

                                  ),
                                  fillColor: Color(0xffAD0514),
                                  filled: true,
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.send),
                                      color: Colors.white,
                                      onPressed: () {
                                        addComment(_text.text, "", love, n, "");
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
                            );
                          }
                      }
                    }
        ),

        )

        )
    );
  }
}

