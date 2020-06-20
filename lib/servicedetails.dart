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
import 'package:timeago/timeago.dart' as timeago;
import 'package:shared_preferences/shared_preferences.dart';
class detailsserives2 extends StatefulWidget {
  String catagories;
  String name;
  String idd ;
  detailsserives2(String catagoris, String name,String iDD) {
    this.name = name;
    this.catagories = catagoris;
    this.idd=iDD;
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
  List<String> sender =[];
  List<int>counter=[];
  List <int>ncounter =[];
  int love=0;
  Timestamp Y;
  String t ;
  List<Timestamp>time2 =[];
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

  Widget _buildLoginBtn() {
    return Container(
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          //Navigator.push(context, new MaterialPageRoute(builder: (context)=>new Home() ));
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new Comment(widget.idd)));
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Reviews',
          style: TextStyle(
            color: Colors.black38,
            letterSpacing: 1.5,
            fontSize: 6.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
  Widget _buildCommentItem(String comment)
  {
    return ListTile(title: Text(comment));
  }
  int Radio = 0;
  String reslut = "";
  TextEditingController name;
  TextEditingController phone;
  TextEditingController email;
  TextEditingController location;
  TextEditingController offdays;
  TextEditingController price;
  TextEditingController img2;

  var geolocator;

//  var geolocator;
  // get geolocator => null;
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
  double readrating ;
  double newrating ;
  Map<String, dynamic> priceList = new Map();
  Map<String, dynamic> time3 = new Map();
  var documentReferencee;
  String splization;
  String docid ;
  Future<String> submitAll() async {
    await Firestore.instance
        .collection('service')
        .where("name", isEqualTo: widget.name)
        .snapshots()
        .listen((data) => data.documents.forEach((doc) {
      name.text = doc["name"];
      img2.text=doc["image"];
      xx = doc['location'];
      //   x = doc.documentID;
      phonelist = List.from(doc["phone"]);
      phonelist = List.from(doc["phone"]);
      off_dayslist = List.from(doc["off_days"]);
      priceList = Map.from(doc["price"]);
      time3 = Map.from(doc["time"]);
docid = doc.documentID;
      print("Name while submitAll: ${name.text}");
      documentReferencee=doc["specialization"];
    }));
    await Firestore.instance
        .collection('specialization').reference()
        .snapshots()
        .listen((data) => data.documents.forEach((df) {
      if(documentReferencee==df.reference){
        splization=df["name"];
      }
    }));
  }
  int starCount = 5;
  int counter2;
  double rating=0.0;
  Future<void> rate()
  async {
    if(counter2 == 0)
    {
        newrating = rating;
        counter2 ++;
      Firestore.instance.collection("service").document(widget.idd).updateData({
        'rating' : newrating,
        'counter' : counter,
      });
    }
    else if(counter2 !=0){
        newrating = (newrating *counter2 + rating)/(counter2+1);
        counter2 ++ ;
      Firestore.instance.collection("service").document(widget.idd).updateData({
        'rating' : newrating,
        'counter' : counter2,
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    submitAll();
   // rate();
    Future sleep1() {
      return new Future.delayed(const Duration(seconds: 2), () => "2");
    }
    Future<bool> onLikeButtonTapped(bool isLiked) async{
      /// send your request here
      // final bool success= await sendRequest();
      Firestore.instance.collection(
          "service").document(
          widget.idd).updateData({
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
        time2 = rtime;
        img = rimg;
        comments.add(val);
        counter.add(count);
        time2.add(currentPhoneDate);
        img.add(imge);
        if(phone != null)
        {
          sender.add(phone);
        }
        else{
          sender.add(email);
        }
        Firestore.instance.collection("service").document(widget.idd).updateData({
          "comments": {
            'comment':{
              'content': comments,
              'sender': sender,
              'love': counter,
              'at' : time2,
              'pic' :img,
            }
          }
        });
      }
      );
    };
    TextEditingController _text = new TextEditingController();
//_getAddressFromLatLng(xx);
    print("Name after submitAll: ${name.text}");
    return new Scaffold( appBar: AppBar(
      backgroundColor: Color(0xffAD0514),
      leading: Padding(
        padding: EdgeInsets.only(left: 12),
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Text('Edit profile',style:TextStyle(fontStyle:FontStyle.normal,fontWeight: FontWeight.bold,fontSize:22,color: Colors.white),),
          ]
      ),
    ),

        backgroundColor: Colors.white,
        body: new Container(
        child: SingleChildScrollView(
        child : StreamBuilder(
            stream: Firestore.instance.collection('service').document(widget.idd).snapshots(),
            builder:
                (context, AsyncSnapshot snapshot) {
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
                  return
                            Column(

                            children: <Widget>[

                                 new Row(
                                children: <Widget>[
                                  new CircleAvatar(
                                    radius: 40.0,
                                    backgroundImage: NetworkImage(img2.text),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  new Padding(
                                      padding: EdgeInsets.only(left: 7)),
                                  new Column(
                                    children: <Widget>[
                                  new Text(
                                  name.text,
                                      style: new TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24)),
                                      new Padding(padding: EdgeInsets.all(6)),
                                      new Row(
                                        children: <Widget>[
                                          new Icon(
                                            Icons.location_on,
                                            color: Colors.black38,
                                          ),
                                          new Padding(
                                              padding: EdgeInsets.only(left: 10)),
                                          new Text(
                                            location.text,
                                            style: new TextStyle(color: Colors.black26),
                                          )
                                        ],
                                      ),
                                      new Padding(padding: EdgeInsets.all(6)),
                                      new Row(
                                        children: <Widget>[
                                          new Icon(
                                            Icons.phone,
                                            color: Colors.black38,
                                          ),
                                          new Padding(
                                              padding: EdgeInsets.only(left: 10)),
                                          new Text(
                                            phonelist.toString(),
                                            style: new TextStyle(color:Colors.black26),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              new Padding(padding: EdgeInsets.all(25)),
                              new Row(
                                children: <Widget>[
                                  new Text("Price",style : new TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.bold),
                                  ),
                                  new Padding(
                                      padding: EdgeInsets.only(left: 15)),
                                  new Text(
                                    priceList.toString(),
                                    style: new TextStyle(color: Colors.black26,fontSize: 14),
                                  )
                                ],
                              ),
                              new Padding(padding: EdgeInsets.all(6)),
                              new Divider(),
                              new Padding(padding: EdgeInsets.all(6)),
                              new Row(
                                children: <Widget>[
                                  new Text("Off Days",style:TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.bold),
                                  ),
                                  new Padding(
                                      padding: EdgeInsets.only(left: 15)),
                                  new Text(
                                    off_dayslist.toString(),
                                    style: new TextStyle(color: Colors.black26,fontSize: 14),

                                  )
                                ],
                              ),
                              new Padding(padding: EdgeInsets.all(6)),
                              new Divider(),
                              new Padding(padding: EdgeInsets.all(6)),
                              new Row(
                                children: <Widget>[
                                  new Text("Working time",style:TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.bold),
                                  ),
                                  new Padding(
                                      padding: EdgeInsets.only(left:15)),
                                  new Text(
                                    time3.toString(),
                                    style: new TextStyle(color: Colors.black26,fontSize: 12),
                                  )
                                ],
                              ),
                              new Padding(padding: EdgeInsets.all(6)),
                              new Divider(),
                              new Padding(padding: EdgeInsets.all(6)),
                              new Row(
                                children: <Widget>[
                                  new Text("Specialization",style:TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.bold)
                                  ),
                                  new Padding(
                                      padding: EdgeInsets.only(left: 15)),
                                  new Text(
                                    splization.toString(),
                                    style: new TextStyle(color: Colors.black26,fontSize: 14),
                                  ),
                                ],
                              ),
                              new Padding(padding: EdgeInsets.all(6)),
                              new Divider(),
                              new Padding(padding: EdgeInsets.all(15)),
                              StarRating(
                                size: 35.0,
                                rating: rating,
                                color: Colors.orange,
                                borderColor: Colors.grey,
                                starCount: starCount,
                                onRatingChanged: (rating) => setState(
                                      () {
                                    this.rating = rating;
                                    rate();
                                  },
                                ),
                              ),
                             // new Padding(padding: EdgeInsets.all(15)),

                   StreamBuilder(
                                              stream: Firestore.instance.collection('service').document(widget.idd).snapshots(),
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

                                                      return   Container(//child:SingleChildScrollView(
                                                          height: 200,
                                                          margin: EdgeInsets.only(top: 20),
                                                    //scrollDirection: Axis.vertical,
                                                    // physics: AlwaysScrollableScrollPhysics(),
                                                        child : ListView.builder(
                                                            shrinkWrap: true,
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
                                                        )
                                                      );
                                                    }
                                                }
                                              },
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

                                  );

              }
            }
        )
    )
        )
    );
  }
}