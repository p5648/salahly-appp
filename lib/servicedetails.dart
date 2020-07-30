//import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:salahly/chat.dart';
import 'package:salahly/location2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salahly/utilities.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:salahly/myColors.dart' as myColors;
import 'package:timeago/timeago.dart' as timeago;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salahly/myColors.dart' as myColors;
import 'package:url_launcher/url_launcher.dart';
import'package:salahly/go.dart';

class detailsserives2 extends StatefulWidget {
  DocumentReference userref;
  DocumentReference serviceref;
  String catagories;
  String name;
  String idd;
  DocumentReference zz ;
  double lat ;
  double lang;
  detailsserives2(String catagoris, String name, String iDD,DocumentReference ZZ,DocumentReference User,  double lat, double lang
      ) {
    this.name = name;
    this.catagories = catagoris;
    this.idd = iDD;
    this.serviceref = ZZ;
    this.userref = User;
    this.lat=lat;
    this.lang=lang;
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
  List<DocumentReference> fav ;
  List<DocumentReference> rfav ;
  List<int> counter = [];
  List<int> ncounter = [];
  int love = 0;
  Timestamp Y;
  String t;
  List<Timestamp> time2 = [];
  String id3;
  bool islike = false;
  String picc;
  List<String> img = [];
  List<String> rphone = [];
  List<String> rcomment = new List<String>();
  List<String> rsender = new List<String>();
  List<int> rcounter = new List<int>();
  List<Timestamp> rtime = new List<Timestamp>();
  DocumentReference servicedoc;
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
  List<GeoPoint> map = new List();

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
      await Geolocator().placemarkFromCoordinates(widget.lat, widget.lang);

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
  String id2;
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
      off_dayslist = List.from(doc["off_days"]);
      priceList = Map.from(doc["price"]);
      time3 = Map.from(doc["time"]);
      docid = doc.documentID;
      servicedoc=doc.reference;
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
      return !isLiked;
    }
    Future<String> onLikeButtonTapped2() async {
       id2 = widget.userref.documentID;
        fav = rfav;
        fav.add(servicedoc);
      Firestore.instance.collection("clients").document(id2).updateData({
        'favourite_service_owner': fav,
      });
    }
    Future<String> ondisLikeButtonTapped2() async {
      id3 = widget.userref.documentID;


        fav = rfav;
        fav.remove(servicedoc);

      String id2 = widget.userref.documentID;
      Firestore.instance.collection("clients").document(id2).updateData({
        'favourite_service_owner': fav,
      }).then((value) {

      });
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
    };
    TextEditingController _text = new TextEditingController();
    _showDialog() async {
      await showDialog<String>(
        context: context,
        child: new AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: new TextField(
                  controller :_text,
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'add comments',labelStyle: TextStyle( color: myColors.green,
                    fontFamily: 'Regular OpenSans',
                    fontSize: 16,), hintText: 'enter your comment',hintStyle: TextStyle(color: myColors.green,
                      fontFamily: 'Regular OpenSans', fontSize: 16)
                  ),
                ),
              )
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('CANCEL',style: TextStyle(
                  color: myColors.red,
                  fontFamily: 'Regular OpenSans',
                  fontSize: 16,
                ),),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('Add',style: TextStyle(
                    color: myColors.red,
                    fontFamily: 'Regular OpenSans',
                    fontSize: 16)),
                onPressed: () {
                  id2 = widget.userref.documentID;
                  fav = rfav;
                  fav.add(servicedoc);
                  Firestore.instance.collection("clients").document(id2).updateData({
                    'favourite_service_owner': fav,
                  });
      }
        ),
      ]
      )
      );
    }
    _showDialogFavourite() async {
      await showDialog<String>(
        context: context,
        child: new AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child : Text("Add to favourite ??",style: TextStyle(fontFamily: 'SemiBold OpenSans',fontSize: 20),)
              )
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('CANCEL',style: TextStyle(
                  color: myColors.red,
                  fontFamily: 'Regular OpenSans',
                  fontSize: 16,
                ),),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('Add',style: TextStyle(
                    color: myColors.green,
                    fontFamily: 'Regular OpenSans',
                    fontSize: 16)),
                onPressed: () {
                  addComment(_text.text,"",love,n,"");
                })
          ],
        ),
      );
    }
//_getAddressFromLatLng(xx);
    print("Name after submitAll: ${name.text}");
    return new Scaffold(
      //backgroundColor: Colors.white,
        body:
        StreamBuilder<QuerySnapshot>(
//          where('service_type',isEqualTo:widget.k).
        stream: Firestore.instance
        .collection('clients')
        .snapshots(),
    builder:
    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshoth) {
    if (!snapshoth.hasData)
    return new Text(
    'Error: ${snapshoth.error.toString()}',
    textDirection: TextDirection.ltr,
    );
    switch (snapshoth.connectionState) {
    case ConnectionState.waiting:
    return Center(
    child: CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(
    Colors.red),
    )
    );
    default:
      snapshoth.data.documents.forEach((element) {
        if(element.reference==widget.userref){
          rfav=List.from(element["favourite_service_owner"]);
        }
      });

    return new Container(
    child: SingleChildScrollView(
    physics: AlwaysScrollableScrollPhysics(),
    child:
    StreamBuilder(
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
    return new Center(
    child: CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(
    myColors.red),
    )
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
    return Column(children: <Widget>[
    new Stack(
    children: <Widget>[
    // The containers in the background
    new Column(
    children: <Widget>[
    new Container(
    height: MediaQuery
        .of(context)
        .size
        .height * .65,
    child :Align(
    alignment: Alignment(-1.0, -0.8),
    child : new FlatButton(
    onPressed: () {
    Navigator.pop(context);
    },
    child: new Icon(
    Icons.arrow_back_ios,
    color: Colors.white,
    size: 30.0,
    ),
    shape: new CircleBorder(),
    color: Colors.black12,
    )
    ),
    //color: Colors.blue,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: NetworkImage(
    img2.text,),
    fit: BoxFit.cover,
    ),
    ),
    ),

    new Container(
    height: MediaQuery
        .of(context)
        .size
        .height * .35,
    color: Colors.white,
    )
    ],
    ),
    // The card widget with top padding,
    // incase if you wanted bottom padding to work,
    // set the `alignment` of container to Alignment.bottomCenter
    new Container(
    alignment: Alignment.topCenter,
    padding: new EdgeInsets.only(
    top: MediaQuery
        .of(context)
        .size
        .height * .58,
    right: 20.0,
    left: 20.0),
    child: new Container(
    height: deviceInfo.size.height *0.68,
    child: new Card(
    //color: Colors.green,
    elevation: 4.0,
    child: Container(
    width: deviceInfo.size.width *
    0.8,
    decoration: BoxDecoration(
    boxShadow: [
    //color: myColors.background, //background color of box
    BoxShadow(
    color: myColors
        .primaryText,
    blurRadius: 12.0,
    // soften the shadow
    spreadRadius: 2.0,
    //extend the shadow
    offset: Offset(
    11.0,
    // Move to right 10  horizontally
    11.0, // Move to bottom 10 Vertically
    ),
    )
    ],
    color: myColors.background,
    // border: Border.all(color: myColors.primaryText),
    borderRadius: BorderRadius
        .all(
    Radius.circular(10.0),
    ),
    ),
    child: Column(
    children: <Widget>[
    Text(name.text,
    style: new TextStyle(
    color: Colors
        .black,
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
    borderColor: myColors
        .primaryText,
    starCount: starCount,
    ),
    //SizedBox(height: 10),
    new Padding(
    padding: EdgeInsets
        .only(
    right: 10)),
    Row(
    children: <Widget>[
    new Icon(
    Icons.location_on,
    color: myColors
        .primaryText,
    ),
    new Padding(
    padding: EdgeInsets
        .only(
    left: 10)),
    new Text(
    location.text,
    style: new TextStyle(
    color: myColors
        .primaryText),
    )
    ],
    ),
    Row(
    children: <Widget>[
    new Icon(
    Icons.monetization_on,
    color: myColors
        .primaryText,
    ),
    new Padding(
    padding: EdgeInsets
        .only(
    left: 10)),
    new Text(
    priceList.toString()
    ,style: new TextStyle(
    color: myColors
        .primaryText),
    )
    ],
    ),
    new Row(
    children: <Widget>[
    new Icon(
    Icons.access_time,
    color: myColors
        .primaryText,
    ),
    new Padding(
    padding: EdgeInsets
        .only(
    left: 15)),
    new Text(
    time3.toString(),
    style: new TextStyle(
    color: myColors
        .primaryText,
    fontSize: 12),
    )
    ],
    ),
    Row(
    children: <Widget>[
    new Icon(
    Icons.work,
    color: myColors
        .primaryText,
    ),
    new Padding(
    padding: EdgeInsets
        .only(
    left: 15)),
    new Text(
    off_dayslist[0]
        .toString() +
    ",," +
    off_dayslist[1]
        .toString(),
    style: new TextStyle(
    color: myColors
        .primaryText,
    fontSize: 14),
    )
    ],
    ),
    SizedBox(height: 10),
    Align(
    alignment: Alignment(
    -0.9, -0.5),
    child: Text(
    "Description",
    style: new TextStyle(
    color: Colors
        .black,
    fontSize: 18,
    fontFamily: 'Bold OpenSans'),
    ),
    ),
    SizedBox(height: 10),
    Align(
    alignment: Alignment(
    -0.4, -0.8),
    child: Text(
    desc.text,
    style: new TextStyle(
    color: Colors
        .black,
    fontSize: 12,
    fontFamily: 'Bold OpenSans'),
    ),
    ),
    IconButton(
    icon:islike==true ?
    Icon(Icons.favorite,color: myColors.red,):
    Icon(Icons.favorite_border,),
    onPressed: () {

     _showDialogFavourite();

    }
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
    Column(
    children: <Widget>[
    IconButton(
    icon: SvgPicture
        .asset(
    "assets/icons/chat.svg",
    width: 20,
    height: 20,
    //color: myColors.green,
    ),
    color: Colors
        .white,
    onPressed: () {
    Navigator.push(
    context,
    new MaterialPageRoute(
    builder: (context) => new Chat(
    serivce_owner:widget.serviceref,
    user: widget.userref,
    )));
    }),
    Text(
    "chat",
    style: new TextStyle(
    color: myColors
        .red,
    fontSize: 14,
    fontFamily: 'SemiBold OpenSans'),
    ),
    ],),
    VerticalDivider(
    color: myColors.secondText,
    thickness: 1, width: 65,
    indent:20,
    endIndent: 20, ),
    Column(children: <Widget>[
    ],),
    Column(
    children: <Widget>[
    IconButton(
    icon: SvgPicture
        .asset(
    "assets/icons/phone.svg",
    width: 20,
    height: 20,
    //color: myColors.green,
    ),
    color: Colors
        .white,
    onPressed: ()=>
    launch("tel:${phonelist[0]}"),
    ),
    Text(
    "call",
    style: new TextStyle(
    color: myColors
        .green,
    fontSize: 14,
    fontFamily: 'SemiBold OpenSans'),
    ),
    ],),
    VerticalDivider(
    color: Colors
        .black,
    width: 70),
    Column(
    children: <Widget>[
    IconButton(
    icon: SvgPicture
        .asset(
    "assets/icons/location-arrow.svg",
    width: 20,
    height: 20,
    //color: myColors.green,
    ),
    color: Colors
        .white,
    onPressed: () => {
    MapUtils.openMap(widget.lat,widget.lang)
    }),
    Text(
    "Go",
    style: new TextStyle(
    color: myColors
        .red,
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
    ),
    ),
    ]
    ),
    new Padding(
    padding: EdgeInsets.all(25)),
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
    child : rcomment.length==0 || rsender.length==0 ||rcounter.length==0
    ||rtime.length==0 || rimg.length==0?
    Text("No reviews for this page",style: TextStyle(fontSize: 20,fontFamily: 'SemiBold OpenSans'),):
    ListView.builder(
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
    ClipOval(
    child: Material(
    color: myColors.green, // button color
    child: InkWell(
    splashColor: myColors.primaryText, // inkwell color
    child: SizedBox(width: 56, height: 56, child: Icon(Icons.create,color: Colors.white,)),
    onTap: () {setState(() {
    _showDialog();
    });},
    ),
    ),
    )]
    );
    }
    }
    }
    ),
    )
    );
    }}
    ),
    );
  }
}