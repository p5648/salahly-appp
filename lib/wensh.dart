import 'dart:math';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salahly/chat.dart';
import 'package:salahly/choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:salahly/myColors.dart' as myColors;
import 'package:url_launcher/url_launcher.dart';

import 'go.dart';
List <String> cc = new List();
class ClientSearch extends StatefulWidget {
  List <DocumentReference> recieve = new List();
  List <String> recieve2 = new List();
  DocumentReference client ;
  String selected ;

  GeoPoint zz2;
  ClientSearch(List <DocumentReference> rec , List<String> rec2,GeoPoint zz,DocumentReference Client)
  {
    this.recieve = rec;
    this.recieve2 = rec2;
    this.zz2 = zz;
    this.client = Client;
  }


  @override
  State<StatefulWidget> createState() => new _WenshState();
}
class _WenshState extends State<ClientSearch> {
  @override
  TextEditingController searchController = new TextEditingController();
  List  <Pair2> searchList =new List();
  List <Pair2>result = null;
  List <Pair2>searchList2 = new List();
  List <String>result3 = new List();
  String selected ;
  Widget appBarTitle = new Text('Search');

  double calculateDistance(lat1, lat2,lon1 ,lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;

    return 12742 * asin(sqrt(a));
  }
  //cc =widget.recieve;
  //List  <String> searchList2 =new List();
  Widget build(BuildContext context) {
    void _addToDatabase(String name) {
      //List<String> splitList = name.split(" ");
      List<String> indexList = [];
      print(indexList);
      result = new List();
      searchController.text = name;
      for( int i = 0 ; i < searchList.length ; i ++ )
      {
        if(searchList[i].getname().contains(name) || searchList[i].getspec().contains(name) || searchList[i].serviceReturn().contains(name))
        {
          result.add(new Pair2(searchList[i].getname(),searchList[i].getspec(),
              searchList[i].serviceReturn(),searchList[i].getRating(),searchList[i].getlat(),
              searchList[i].getalang(),searchList[i].getDistance2(),searchList[i].getPhone(),searchList[i].getimg(),searchList[i].getServiceOwner()));
        }
      }

    }
    //cc=widget.recieve;
    //GeoPoint.(name: "Position", point: LatLng(51.0,0.0));
    //widget.zz2.latitude = 2222.2;
    //widget.zz2.longitude = 225.5;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: appBarTitle,
          backgroundColor: myColors.red,),
        body: Center(
            child: new StreamBuilder(
                stream: Firestore.instance.collection('service').snapshots(),
                builder:
                    (context, AsyncSnapshot snapshot2) {
                  //var doc1 = snapshot.data;
                  if (!snapshot2.hasData)
                    return new Text(
                      'Error: ${snapshot2.error.toString()}',
                      textDirection: TextDirection.ltr,
                    );
                  switch (snapshot2.connectionState) {
                    case ConnectionState.waiting:
                      return new Text(
                        'Loading...',
                        textDirection: TextDirection.ltr,
                      );
                    default:
                      return StreamBuilder(
                          stream: Firestore.instance.collection('specialization')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot snapshot3) {
                            //var doc = snapshot.data;
                            if (!snapshot3.hasData)
                              return new Text(
                                'Error: ${snapshot3.error.toString()}',
                                textDirection: TextDirection.ltr,
                              );
                            switch (snapshot3.connectionState) {
                              case ConnectionState.waiting:
                                return new Text(
                                  'Loading...',
                                  textDirection: TextDirection.ltr,
                                );

                              default:
                                String gh(DocumentReference gh){
                                  String g;
                                  for(int i=0;i<widget.recieve.length;i++){
                                    if(gh==widget.recieve[i]){
                                      g=widget.recieve2[i];
                                    }

                                  }
                                  return g;
                                }
                                searchList = new List();

                                if(widget.zz2==null){
                                  widget.zz2=new GeoPoint(34, 44);
                                }
                                //fg =new GeoPoint(2344, 44);

                                snapshot2.data.documents.forEach((element) {
                                  snapshot3.data.documents.forEach((data) {{
                                    if (element["specialization"] == data.reference ) {
                                      GeoPoint x = element["location"];
                                      List <String>pp = new List();
                                      GeoPoint fg=widget.zz2 as GeoPoint;
                                      pp= List.from(
                                          element['phone']);
                                      searchList.add(new Pair2(
                                          element["name"].toString(),
                                          data["name"].toString(),
                                          gh(data["service_type"]),
                                          element["rating"],
                                          x.latitude ,x.longitude ,
                                          calculateDistance(widget.zz2.latitude,widget.zz2.longitude, x.latitude, x.longitude),
                                          pp,element["image"].toString(),element["service_owner"])
                                      );
                                    }
                                    result3.add(data["service_type"].toString());
                                  }
                                  }
                                  );
                                }
                                );
                            }


                            return Column(
                                children: <Widget>[
                                  Divider(),


                                  Column(
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child:Container(
                                                margin: EdgeInsets.symmetric(horizontal:10.0, vertical:8.0),
                                                padding: EdgeInsets.only(left:16.0,right:16.0),
                                                decoration:BoxDecoration(
                                                    border:Border.all(color: myColors.red),
                                                    borderRadius: BorderRadius.all(Radius.circular(22.0))
                                                ),
                                                child: Row( crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[ Expanded(
                                                        flex:1,
                                                        child: TextFormField(
                                                            decoration: InputDecoration(
                                                                border: InputBorder.none,
                                                                hintText: "Search",
                                                                hintStyle: TextStyle(color: Colors.grey),
                                                                icon: Icon(Icons.search,color: Colors.grey)
                                                            ),
                                                            controller: searchController,
                                                            onChanged:(value) {
                                                              setState(() {
                                                                _addToDatabase(value.toLowerCase());
                                                              });


                                                            }
                                                        )
                                                    )

                                                    ]

                                                )

                                            )

                                        ),

                                        new Container(
                                            child:new Row(children: <Widget>[
                                              SizedBox(width:30,),

                                              DropdownButton<String>(

                                                hint: Text('Filter'),
                                                icon: Icon(Icons.filter_list,color: Colors.grey,),

                                                dropdownColor: Colors.white,
                                                elevation:5,
                                                //icon: Icon(Icons.arrow_drop_down),
                                                style: TextStyle(color: Colors.black , fontSize: 15.0),



                                                items: <String>['Distance', 'Rating'].map((String value) {
                                                  return new DropdownMenuItem<String>(
                                                    value: value,
                                                    child: new Text(value),





                                                  );

                                                }).toList(),

                                                onChanged: (currentValue) {
                                                  setState(() {
                                                    selected = currentValue;
                                                    if(selected == "Rating") {
                                                      result.sort();
                                                    }
                                                    else if (selected == "distance" )
                                                    {
                                                      Comparator<Pair2> priceComparator = (a, b) => a.getDistance2().compareTo(b.getDistance2());
                                                      result.sort(priceComparator);
                                                    }

                                                  });


                                                },

                                              ),
                                              new Row(children: <Widget>[
                                                SizedBox(width:100,),

                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.push(context, new MaterialPageRoute(
                                                        builder: (context) => new Map(widget.recieve,widget.recieve2)
                                                    ));
                                                  },
                                                  child: SvgPicture.asset(
                                                    "assets/icons/location-arrow.svg",
                                                    width: 20,
                                                    height: 20,
                                                  ),

                                                )],)

                                            ],


                                            ))

                                      ]
                                  ),

                                  Expanded(

                                      child: result != null? ListView.builder(
                                          itemCount: result.length,
                                          itemBuilder: (context, index) {
                                            return new Padding(padding: EdgeInsets.all(12),child:
                                            Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                  image: DecorationImage(
                                                    image: NetworkImage(result[index].getimg().toString()),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                child:
                                                new Container(
                                                  alignment: Alignment.topLeft,
                                                  //color: Colors.white,
                                                  child:
                                                  new Column(
                                                    children: <Widget>[
                                                      new Padding(padding: EdgeInsets.all(70)),
                                                      new Container(
                                                        color: Colors.white,
                                                        alignment: Alignment.topLeft,
                                                        child:new Column(
                                                          children: <Widget>[
                                                            new Row(children: <Widget>[
                                                              new FlatButton(
                                                                  onPressed: () {
                                                                  },
                                                                  child: new Text(
                                                                    result[index].getname().toString(),
                                                                    style: new TextStyle(
                                                                        color:  Colors.black,
                                                                        fontFamily: 'SemiBold OpenSans',
                                                                        fontSize: 18),
                                                                  )),
                                                              SizedBox(width: MediaQuery.of(context).size.width/3),
                                                            ],),
                                                            new Row(children: <Widget>[
                                                              new FlatButton(
                                                                  onPressed: () {
                                                                  },
                                                                  child: new Text(
                                                                    result[index].getspec().toString() + "   " +  result[index].serviceReturn().toString(),
                                                                    style: new TextStyle(
                                                                        color:  myColors.primaryText,
                                                                        fontFamily: 'Regular OpenSans',
                                                                        fontSize: 13),
                                                                  )),
                                                              SizedBox(width: MediaQuery.of(context).size.width/3),
                                                            ],),
                                                            new Row(children: <Widget>[
                                                              new Padding(
                                                                  padding: EdgeInsets.only(left: 4)),
                                                              new StarRating(
                                                                size: 20.0,
                                                                rating : result[index].getRating(),
                                                                color: Colors.orange,
                                                                borderColor: Colors.grey,
                                                                starCount: 5,
                                                              ),
                                                              new Padding(
                                                                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/3-40)),
                                                              new Text(
                                                                  result[index].getDistance2().toString() + " " + "km",
                                                                  style: new TextStyle(color:  myColors.secondText,fontFamily: 'OpenSans SemiBold')),

                                                            ],),
                                                            new Divider(color: Colors.grey,),
                                                            new Row(children: <Widget>[
                                                              new FlatButton(
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      new MaterialPageRoute(
                                                                          builder: (context) => new Chat(
                                                                            serivce_owner:result[index].getServiceOwner(),
                                                                            user: widget.client,
                                                                          )));
                                                                },
                                                                child: SvgPicture.asset(
                                                                  "assets/icons/chat.svg",
                                                                  width: 24,
                                                                  height: 24,
                                                                ),
                                                              ),
                                                              SizedBox(width: 10,),
                                                              new Container(color: Colors.grey,width: 1,height: 20,),
                                                              SizedBox(width: 10,),
                                                              new FlatButton(
                                                                onPressed: () => launch("tel:${result[index].getPhone()}"),
                                                                child: SvgPicture.asset(
                                                                  "assets/icons/phone.svg",
                                                                  width: 24,
                                                                  height: 24,
                                                                  color: myColors.green,
                                                                ),
                                                              ),
                                                              new Container(color: Colors.grey,width: 1,height: 20,),
                                                              new FlatButton(
                                                                onPressed: () =>  MapUtils.openMap(result[index].getlat(),result[index].getalang()),
                                                                child:  SvgPicture.asset(
                                                                  "assets/icons/location-arrow.svg",
                                                                  width: 24,
                                                                  height: 24,
                                                                  color: myColors.red,
                                                                ),),
                                                            ],
                                                            ),
                                                          ],),
                                                      ),
                                                    ],
                                                  ),

                                                )));
                                          })

                                          : ListView.builder(
                                          itemCount: searchList.length,
                                          itemBuilder: (context, index) {
                                            return new Padding(padding: EdgeInsets.all(12),child:
                                            Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                  image: DecorationImage(
                                                    image: NetworkImage(searchList[index].getimg().toString()),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                child:
                                                new Container(
                                                  alignment: Alignment.topLeft,
                                                  //color: Colors.white,
                                                  child:
                                                  new Column(
                                                    children: <Widget>[
                                                      new Padding(padding: EdgeInsets.all(70)),
                                                      new Container(
                                                        color: Colors.white,
                                                        alignment: Alignment.topLeft,
                                                        child:new Column(
                                                          children: <Widget>[
                                                            new Row(children: <Widget>[
                                                              new FlatButton(
                                                                  onPressed: () {
                                                                  },
                                                                  child: new Text(
                                                                    searchList[index].getname().toString(),
                                                                    style: new TextStyle(
                                                                        color:  Colors.black,
                                                                        fontFamily: 'SemiBold OpenSans',
                                                                        fontSize: 18),
                                                                  )),
                                                              SizedBox(width: MediaQuery.of(context).size.width/3),
                                                            ],),
                                                            new Row(children: <Widget>[
                                                              new FlatButton(
                                                                  onPressed: () {
                                                                  },
                                                                  child: new Text(
                                                                    searchList[index].getspec().toString() + "   " +  searchList[index].serviceReturn().toString(),
                                                                    style: new TextStyle(
                                                                        color:  myColors.primaryText,
                                                                        fontFamily: 'Regular OpenSans',
                                                                        fontSize: 13),
                                                                  )),
                                                              SizedBox(width: MediaQuery.of(context).size.width/3),
                                                            ],),
                                                            new Row(children: <Widget>[
                                                              new Padding(
                                                                  padding: EdgeInsets.only(left: 7)),
                                                              new StarRating(
                                                                size: 20.0,
                                                                rating : searchList[index].getRating(),
                                                                color: Colors.orange,
                                                                borderColor: Colors.grey,
                                                                starCount: 5,
                                                              ),
                                                              new Padding(
                                                                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/3-40)),
                                                              new Text(
                                                                  searchList[index].getDistance2().toString() + " " + "km",
                                                                  style: new TextStyle(color:  myColors.secondText,fontFamily: 'OpenSans SemiBold')),
                                                            ],),
                                                            new Divider(color: Colors.grey,),
                                                            new Row(children: <Widget>[
                                                              new FlatButton(
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      new MaterialPageRoute(
                                                                          builder: (context) => new Chat(
                                                                            serivce_owner:searchList[index].getServiceOwner(),
                                                                            user: widget.client,
                                                                          )));
                                                                },
                                                                child: SvgPicture.asset(
                                                                  "assets/icons/chat.svg",
                                                                  width: 24,
                                                                  height: 24,
                                                                ),
                                                              ),
                                                              SizedBox(width: 30,),
                                                              new Container(color: Colors.grey,width: 1,height: 20,),
                                                              SizedBox(width: 10,),
                                                              new FlatButton(
                                                                onPressed: (){
                                                                  launch("tel:${searchList[index].getPhone()}");
                                                                },
                                                                child: SvgPicture.asset(
                                                                  "assets/icons/phone.svg",
                                                                  width: 24,
                                                                  height: 24,
                                                                  color: myColors.green,
                                                                ),
                                                              ),

                                                              new Container(color: Colors.grey,width: 1,height: 20,),
                                                              SizedBox(width: 10,),
                                                              SizedBox(width: 10,),
                                                              new FlatButton(
                                                                onPressed: () { MapUtils.openMap(searchList[index].getlat(),searchList[index].getalang());
                                                                },
                                                                child:  SvgPicture.asset(
                                                                  "assets/icons/location-arrow.svg",
                                                                  width: 24,
                                                                  height: 24,
                                                                  color: myColors.red,
                                                                ),),
                                                            ],
                                                            ),
                                                          ],),
                                                      ),
                                                    ],
                                                  ),

                                                )));
                                          })) ]
                            );
                          }
                      );
                  }
                }
            )
        )
    );
  }
}

class Pair2 implements Comparable<Pair2> {
  double distance;
  double Rating ;
  double lat;
  String Servicee;
  double lang;
  String placemark;
  String name;
  List <String>phone2 ;
  String img ;
  DocumentReference Re;
  DocumentReference seciveOwner;
  String phone;
  String spec;
  String toString() => "${name}";
  DocumentReference reference() {
    return Re;
  }
  Pair2(String name,String t,String servicetype,double Rate,double lat1,double lang1,double distance1,List<String>Phone,String Img, DocumentReference seciveOwner2) {
    this.spec = t ;
    this.lat = lat1;
    this.lang = lang1;
    this.distance = distance1;
    this.name = name;
    this.Servicee = servicetype;
    this.Rating = Rate;
    this.phone2 = Phone;
    this.img = Img;
    this.seciveOwner = seciveOwner2;

  }

  @override
  int compareTo(Pair2 p) {
    // TODO: implement compareTo
    if (this.Rating > p.Rating)
      return -1;
    else
      return 1;
  }
  String getname(){
    return name;
  }
  List<String> getPhone(){
    return phone2;
  }
  String getimg(){
    return img;
  }
  String getspec(){
    return spec;
  }
  String serviceReturn()
  {
    return Servicee;
  }
  double getRating()
  {
    return Rating;
  }
  double getDistance2()
  {
    return distance;
  }
  double getalang()
  {
    return lang;
  }
  double getlat()
  {
    return lat;
  }
  DocumentReference getServiceOwner()
  {
    return seciveOwner;
  }
}