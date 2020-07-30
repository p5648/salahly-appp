import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salahly/myColors.dart' as myColors;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:salahly/profile1.dart';
import 'package:salahly/wensh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:salahly/go.dart';

import 'chat.dart';
import 'listchat.dart';


class ListPage extends StatefulWidget {
  DocumentReference cllient;
  DocumentReference g;
  List<DocumentReference>rt = new List();
  List<String>name = new List();
  GeoPoint pos  ;
  String f;



  ListPage(List rt,List name,GeoPoint pos ,DocumentReference g,String f){
    this.g=g;
    this.rt=rt;
    this.name=name;
    this.pos=pos;
    this.f=f;

  }

  @override
  _ListPageState createState() => _ListPageState();

}


class _ListPageState extends State<ListPage> {
  Widget appBarTitle = new Text('Favorites');
  List<DocumentReference> recieve = new List();
  List<String> recieve2 = new List();
  List<String> serviceName = new List();
  List<double> Rateing = new List();
  List<DocumentReference> serviceowner = new List();
  List<String> phone = new List();
  List<GeoPoint> location = new List();
  List <String> Phone = new List();


  List<String> specialization = new List();


  Future getclients() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("clients").getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          //fixedColor: Colors.grey,
          backgroundColor: myColors.background,
          selectedItemColor: myColors.red,
          unselectedItemColor: Colors.grey,
          currentIndex: 0,
          onTap: (index) {
            setState(() {
              _onItemTapped(index);
            });
          },
          // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/home.svg",
                width: 24,
                height: 24,
                color: Colors.grey,
              ),
              title: new Text(
                '',
                style: new TextStyle(color: Colors.grey),
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/chat.svg",
                width: 24,
                height: 24,
                color: Colors.grey,
              ),
              title: new Text('', style: new TextStyle(color: Colors.grey)),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite, color: myColors.red,
                ),
                title: Text('', style: new TextStyle(color: Colors.grey))),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('', style: new TextStyle(color: Colors.grey))),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/profile (1).svg",
                  width: 24,
                  height: 24,
                ),
                title: Text('', style: new TextStyle(color: Colors.grey))),
          ],
        ),

        appBar: new AppBar(
          //  title: new Text('Flutter Demo'),
          backgroundColor: myColors.red,
          centerTitle: true,
          title: Text(
            "S A L A H L Y",
            textAlign: TextAlign.right,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),

        body: Container(
            alignment: Alignment.centerLeft,

            child: new StreamBuilder(
                stream: Firestore.instance
                    .collection('clients')
                    .document("YiwUjx0QcvGnE2ieGR1j")
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return new Text(
                      'Error: ${snapshot.error.toString()}',
                      textDirection: TextDirection.ltr,
                    );
                  if (snapshot.hasError) {
                    return Center(
                        child: Text("Failed to fetch data"));
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text(
                        'Loading...',
                        textDirection: TextDirection.ltr,
                      );
                    default:
                      var doc = snapshot.data;
                      recieve = List.from(doc["favourite_service_owner"]);
                      if (recieve.length == 0) {
                        return new Center(
                          child: Text("You do not have favourite services",style:TextStyle(color: myColors.secondText,
                          fontSize: 20,fontFamily: 'SemiBold OpenSans'),),
                        );
                      }
                      else {
                        return StreamBuilder(
                            stream: Firestore.instance
                                .collection('service')
                                .snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
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
                                  recieve2 = new List();
                                  serviceName = new List();
                                  Rateing = new List();
                                  serviceowner = new List();
                                  phone = new List();
                                  location = new List();

                                  for (int i = 0; i < recieve.length; i++) {
                                    snapshot.data.documents
                                        .forEach((DocumentSnapshot doc) {
                                      if (recieve[i] == doc.reference) {
                                        serviceowner.add(doc["service_owner"]);
                                        recieve2.add(doc["image"]);
                                        serviceName.add(
                                          doc['name'],

                                        );

                                        location.add(doc["location"]);

                                        //phone.add(doc["phone"]);

                                        Rateing.add(doc['rating']);
                                      }
                                    });
                                  }

                                  /*                          //var docc = snapshot.data;
                                String name = docc["name"].toString();
    String  email = docc["email"].toString();
    String  phone1 = docc["phone"][0].toString();
    String phone2 = docc["phone"][1].toString();
    String age = docc["birthday"].toString();
    String type = docc["car_type"].toString();
    String model = docc["car_model"].toString();
    String photo = docc["profile_pic"].toString();*/

                                  return StreamBuilder(
                                      stream: Firestore.instance
                                          .collection('service_owner')
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot snapshotf) {
                                        if (!snapshotf.hasData)
                                          return new Text(
                                            'Error: ${snapshotf.error
                                                .toString()}',
                                            textDirection: TextDirection.ltr,
                                          );
                                        switch (snapshotf.connectionState) {
                                          case ConnectionState.waiting:
                                            return new Text(
                                              'Loading...',
                                              textDirection: TextDirection.ltr,
                                            );
                                          default:
                                            for (int i = 0; i <
                                                serviceowner.length; i++) {
                                              snapshotf.data.documents
                                                  .forEach((
                                                  DocumentSnapshot doc) {
                                                if (serviceowner[i] ==
                                                    doc.reference) {
                                                  Phone.add(doc["phone"]);
                                                }
                                              });
                                            }
                                            return new ListView.builder(
                                                itemCount: serviceName.length,
                                                itemBuilder: (context, index) {
                                                  return new Padding(
                                                      padding: EdgeInsets.all(
                                                          12),
                                                      child:
                                                      Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    15.0)),
                                                            image: DecorationImage(
                                                              image: NetworkImage(
                                                                  recieve2[index]),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          child:
                                                          new Container(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            //color: Colors.white,
                                                            child:
                                                            new Column(
                                                              children: <
                                                                  Widget>[
                                                                new Padding(
                                                                    padding: EdgeInsets
                                                                        .all(
                                                                        50)),
                                                                new Container(
                                                                  color: Colors
                                                                      .white,
                                                                  alignment: Alignment
                                                                      .topLeft,
                                                                  child: new Column(
                                                                    children: <
                                                                        Widget>[

                                                                      new Row(
                                                                        children: <
                                                                            Widget>[
                                                                          new FlatButton(
                                                                              onPressed: () {
                                                                                /*Navigator.push(
                                                                  context,
                                                                  new MaterialPageRoute(
                                                                      builder: (context) =>

                                                                     new detailsserives2(c[index].toString(), c[index].toString(),listid[index].toString(),c[index].reference(),widget.g)));
                                                            */
                                                                              },

                                                                              child: new Text(
                                                                                serviceName[index]
                                                                                    .toString(),
                                                                                style: new TextStyle(
                                                                                    color: Colors
                                                                                        .black,
                                                                                    fontWeight: FontWeight
                                                                                        .bold,
                                                                                    fontSize: 13),
                                                                              )),
                                                                          SizedBox(
                                                                              width: MediaQuery
                                                                                  .of(
                                                                                  context)
                                                                                  .size
                                                                                  .width /
                                                                                  3),
                                                                          new FlatButton(
                                                                              onPressed: () {
                                                                                /*check=true;


                                                              Firestore.instance.collection('clients')
                                                                  .snapshots().listen((data) => data.documents.forEach((doc) {
                                                                if(widget.g==doc.reference) {
                                                                  print(doc["favourite_service_owner"].toString());
                                                                  for(int i=0;i<fav.length;i++) {
                                                                    if (fav[i] == c[index].reference()){

                                                                    }

                                                                  }

                                                                  fav = List.from(doc["favourite_service_owner"]);
                                                                  if (check == true) {
                                                                    fav.add(c[index].reference());
                                                                    print(fav.length);
                                                                    if (fav .length>0) {

                                                                      Firestore.instance.collection("clients")
                                                                          .document(doc.documentID)
                                                                          .updateData(({
                                                                        "favourite_service_owner": fav
                                                                      }));

                                                                      check = false;
                                                                    }
                                                                    else {
                                                                      fav=new List();
                                                                      Firestore.instance.collection("clients")
                                                                          .document(doc.documentID)
                                                                          .setData(
                                                                          ({
                                                                            "favourite_service_owner": fav
                                                                          }));
                                                                      check = false;
                                                                    }
                                                                  }
                                                                }
                                                              }

                                                              ));

                                                              /*else{
    Firestore.instance.collection('clients').where("email",isEqualTo: widget.g).limit(1).snapshots().listen((onData) {
      onData.documents.forEach((f) {
        fav = List.from(f["favourite_service_owner"]);
        if (fav != null) {
          fav.add(c[index].reference());
          for(int i=0;i<fav.length;i++){
            if(fav[i]==c[index].reference()){
              fav.removeAt(i);
            }
          }
          Firestore.instance.collection("clients")
              .document(f.documentID)
              .updateData(({
            "favourite_service_owner": fav
          }));
        }
      });
    });
    cc=Color.fromRGBO(31, 58, 147, 1);
                                                check=true;
                                              }*/

                                                            */
                                                                              },

                                                                              child: new Icon(
                                                                                  Icons
                                                                                      .favorite,
                                                                                  color: Colors
                                                                                      .red //Color.fromRGBO(31, 58, 147, 1),
                                                                              )),
                                                                        ],),

                                                                      new Row(
                                                                        children: <
                                                                            Widget>[
                                                                          new Padding(
                                                                              padding: EdgeInsets
                                                                                  .only(
                                                                                  left: 20)),
                                                                          new StarRating(
                                                                            size: 25.0,
                                                                            rating: Rateing[index],
                                                                            color: Colors
                                                                                .orange,
                                                                            borderColor: Colors
                                                                                .grey,
                                                                            starCount: 5,
                                                                          ),
                                                                          new Padding(
                                                                              padding: EdgeInsets
                                                                                  .only(
                                                                                  left: MediaQuery
                                                                                      .of(
                                                                                      context)
                                                                                      .size
                                                                                      .width /
                                                                                      3 -
                                                                                      40)),


                                                                        ],),
                                                                      new Divider(
                                                                        color: Colors
                                                                            .grey,),
                                                                      new Row(
                                                                        children: <
                                                                            Widget>[
                                                                          new SizedBox(
                                                                            width: 10,),
                                                                          new FlatButton(
                                                                            onPressed: () {
                                                                              Navigator
                                                                                  .push(
                                                                                  context,
                                                                                  new MaterialPageRoute(
                                                                                      builder: (
                                                                                          context) =>
                                                                                      new Chat(
                                                                                        serivce_owner: serviceowner[index],
                                                                                        user: widget
                                                                                            .cllient,
                                                                                      )));
                                                                            },
                                                                            child: SvgPicture
                                                                                .asset(
                                                                              "assets/icons/chat.svg",
                                                                              width: 24,
                                                                              height: 24,

                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width: 10,),
                                                                          new Container(
                                                                            color: Colors
                                                                                .grey,
                                                                            width: 1,
                                                                            height: 20,),
                                                                          SizedBox(
                                                                            width: 10,),
                                                                          new FlatButton(

                                                                            onPressed: () =>
                                                                                launch(
                                                                                    "tel:${Phone[index]}"),
                                                                            child: SvgPicture
                                                                                .asset(
                                                                              "assets/icons/phone.svg",
                                                                              width: 24,
                                                                              height: 24,
                                                                              // color: myColors.green,
                                                                            ),
                                                                          ),

                                                                          new Container(
                                                                            color: Colors
                                                                                .grey,
                                                                            width: 1,
                                                                            height: 20,),
                                                                          SizedBox(
                                                                            width: 10,),
                                                                          SizedBox(
                                                                            width: 10,),
                                                                          new FlatButton(

                                                                            onPressed: () =>
                                                                            {

                                                                              MapUtils
                                                                                  .openMap(
                                                                                  location[index]
                                                                                      .latitude,
                                                                                  location[index]
                                                                                      .longitude)
                                                                            },


                                                                            child: SvgPicture
                                                                                .asset(
                                                                              "assets/icons/location-arrow.svg",
                                                                              width: 24,
                                                                              height: 24,
                                                                              //  color: myColors.red,
                                                                            ),),
                                                                        ],
                                                                      ),
                                                                    ],),
                                                                ),
                                                              ],
                                                            ),

                                                          )));
                                                });
                                        }
                                      });
                              }
                            });
                      }
                  }
                })));
  }

  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          {
            Navigator.of(context).pushNamed('/categories');
          }
          break;
        case 1:
          {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new Listchat(widget.rt, widget.name, widget.pos, widget.g,
                        widget.f)));
          }
          break;
        case 2:
          {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new ListPage(widget.rt, widget.name, widget.pos, widget.g,
                        widget.f)));
          }
          break;
        case 3:
          {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new ClientSearch(
                        widget.rt, widget.name, widget.pos, widget.g)));
          }
          break;
        default:
          {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new Profile1(widget.f, widget.rt, widget.name, widget.pos,
                        widget.g)));
          }
          break;
      }
    });
  }
}
