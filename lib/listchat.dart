import 'dart:async';
import 'dart:collection';
//import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salahly/chat.dart';
import 'package:salahly/profile1.dart';
import 'package:salahly/subcategories.dart';
import 'package:salahly/categories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'chat.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:quiver/time.dart';
//import 'C';

class Listchat extends StatefulWidget {
  DocumentReference g;
  Listchat(DocumentReference g){
    this.g=g;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ss();
  }
}

class ss extends State<Listchat> {
  //static get j
  //
  // 0hkmEYn6dWMvOY32wFb => null;
  SharedPreferences mm;
  List<pairr> messege = new List();
  List content = new List();
  List time=new List();
  DateTime now = DateTime.now();
//List <String> serivees=new List();
  Widget build(BuildContext context) {
    //submitAll();

    // StreamController streamController;
    @override
    void initState() {
      //streamController = StreamController.broadcast();
      // submitAll();
      //messege=new List();
      content = new List();
      messege = new List();
      super.initState();
    }

    //submitAll();
    return new Scaffold(
        appBar: new AppBar(
          //  title: new Text('Flutter Demo'),

          backgroundColor: Color.fromRGBO(31, 58, 147, 1),
          centerTitle: true,
          title: Text(
            "salahly",
            textAlign: TextAlign.right,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              //_select(choices[0]);
            },
          ),

          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                //_select(choices[0]);
              },
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('chat').where("client",isEqualTo: widget.g).snapshots(),
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
                  print("outside");
                  content = new List();
                  time=new List();

                  /*   snapshot.data.documents.forEach((DocumentSnapshot doc) {
                    Firestore.instance
                        .collection('service_owner')
                        .reference()
                        .snapshots()
                        .listen((data) => data.documents.forEach((df) {
                              if (df.reference == doc["service_owner"]) {
                                //print(doc.documentID.toString());
                                content = List.from(doc["messege"]);

                                messege.add(new pairr(
                                    df["name"],
                                    content[content.length - 1]["content"].toString(),
                                    doc["client"],
                                    df.reference));
                              }
                            }));
                  });*/

                  print('before sleep');
                  new Future.delayed(const Duration(seconds: 10), () => "5");
                  print('After sleep');
                  print('before sort sleep');
                  new Future.delayed(const Duration(seconds: 10), () => "5");
                  print(messege.length);

                  return  StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance.collection('service_owner').snapshots(),
                      builder:
                          (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
                        if (!snap.hasData)
                          return new Text(
                            'Error: ${snap.error.toString()}',
                            textDirection: TextDirection.ltr,
                          );
                        switch (snap.connectionState) {
                          case ConnectionState.waiting:
                            return new Text(
                              'Loading...',
                              textDirection: TextDirection.ltr,
                            );
                          default:
                            messege=new List();
                            snapshot.data.documents.forEach((DocumentSnapshot doc) {
                              snap.data.documents.forEach((DocumentSnapshot dok) {
                                if(dok.reference==doc["service_owner"]) {
                                  content = List.from(doc["messege"]);
                                  Timestamp ti = content[content.length - 1]["time"];
                                  if (content[content.length - 1]["type"].toString() == "image") {
                                    messege.add(new pairr(
                                        dok["name"],
                                        "لقد ارسلت صوره",
                                        doc["client"],
                                        dok.reference, DateTime.parse(ti.toDate().toString())));
                                  }
                                  else {
                                    messege.add(new pairr(
                                        dok["name"],
                                        content[content.length - 1]["content"].toString(),
                                        doc["client"],
                                        dok.reference, DateTime.parse(ti.toDate().toString())));
                                  }
                                }
                                print(now.hour.toString()+":"+now.minute.toString());


                              });
                              /*    Firestore.instance
              .collection('service_owner')
              .reference()
              .snapshots()
              .listen((data) => data.documents.forEach((df) {
            if (df.reference == doc["service_owner"]) {
              //print(doc.documentID.toString());
              content = List.from(doc["messege"]);

              messege.add(new pairr(
                  df["name"],
                  content[content.length - 1]["content"].toString(),

                  doc["client"],
                  df.reference));
            }
          }));*/
                            });


                            return new ListView.builder(

                              itemBuilder: (context, int index) {
                                return new Container(
                                    alignment: Alignment.center,
                                    child:
                                    new Column(children: <Widget>[
                                      new Row(

                                        children: <Widget>[

                                          new Padding(padding: EdgeInsets.only(left: 20)),
                                          new  ClipOval(

                                            //borderRadius: BorderRadius.circular(100),

                                            child: Image.network(

                                              "https://f...content-available-to-author-only...s.com/v0/b/sal7ly-95e68.appspot.com/o/photo-of-man-changing-tire-of-a-motorcycle-1131221.jpg?alt=media&token=914b0c14-f941-4ba3-bed3-6f312dbc017e",
                                              fit: BoxFit.cover,
                                              height: 40.0,
                                              width: 40.0,
                                              //color: Color.fromRGBO(31, 58, 147, 1),
                                            ),
                                          ),
                                          new Padding(padding: EdgeInsets.only(left: 1)),
                                          new Column(
                                            children: <Widget>[
                                              new FlatButton(
                                                  onPressed: () {
                                                    print('ay 7aga 1');
                                                    Navigator.push(
                                                        context,
                                                        new MaterialPageRoute(
                                                            builder: (context) =>
                                                            new Chat(
                                                                serivce_owner:
                                                                messege[index]
                                                                    .getservice_owner(),
                                                                user: messege[index]
                                                                    .getclient())));
                                                    setState() {
                                                      print('ay 7aga 2');
                                                    }
                                                  },
                                                  child: new Text(
                                                    //allMessages.keys.toList()[index],
                                                    //       serivees[index].toString()
                                                    //               messege[index].getrang().toString()
                                                    //         f[0].name.toString(),
                                                    messege[index].getrang().toString(),
                                                    style: new TextStyle(
                                                        color: Color.fromRGBO(31, 58, 147, 1),
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18),
                                                  )),

                                              new Text(
                                                // f[0].phone.toString(),
                                                messege[index].getDistance().toString(),
                                                style: new TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w100),
                                              )
                                            ],
                                          ),
                                          new Padding(padding: EdgeInsets.only(left: 120)),
                                          new Text(
                                            // f[0].phone.toString(),
                                            //
                                            now.day.toString()== messege[index].time.day.toString()?messege[index].time.hour.toString()+":"+ messege[index].time.minute.toString():messege[index].time.day.toString()
                                                +"/"+messege[index].time.month.toString(),

                                            style: new TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w200),
                                          ),


                                          new Padding(padding: EdgeInsets.only(left: 0)),




                                        ],
                                      ),
                                      new Divider(color: Colors.grey,)
                                    ],)
























                                  //color: Color.fromRGBO(232, 232, 232, 1),
                                  /*shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),

              ),*/

                                  /* child:
              ListTile(

                leading:         new  ClipOval(

                  //borderRadius: BorderRadius.circular(100),

                  child: Image.network(
                    "https://f...content-available-to-author-only...s.com/v0/b/sal7ly-95e68.appspot.com/o/photo-of-man-changing-tire-of-a-motorcycle-1131221.jpg?alt=media&token=914b0c14-f941-4ba3-bed3-6f312dbc017e"
                    ,
                    fit: BoxFit.cover,
                    height: 40.0,
                    width: 40.0,
                    //color: Color.fromRGBO(31, 58, 147, 1),
                  ),
                ), /*CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: new NetworkImage("https://f...content-available-to-author-only...s.com/v0/b/sal7ly-95e68.appspot.com/o/photo-of-man-changing-tire-of-a-motorcycle-1131221.jpg?alt=media&token=914b0c14-f941-4ba3-bed3-6f312dbc017e"),
             // radius: 40.0,
            ),*/
                title: new Text(
                  //allMessages.keys.toList()[index],
                  //       serivees[index].toString()
                  messege[index].getrang().toString(),
                  style: new TextStyle(
                      color: Color.fromRGBO(31, 58, 147, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                subtitle:   new Text(
                  messege[index].getDistance().toString(),
                  style: new TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w100),
                ),
                onTap: (){
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                          new Chat(
                              serivce_owner:
                              messege[index]
                                  .getservice_owner(),
                              user: messege[index]
                                  .getclient())));
                },
              ),*/
                                );
                                /*    return new Container(
                child: new Container(
                  height: 120,
                  alignment: Alignment.center,
                  child: Container(
                    child: new Column(
                        children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Padding(padding: EdgeInsets.only(left: 20)),
                        new  ClipOval(

                          //borderRadius: BorderRadius.circular(100),

                          child: Image.network(
"https://f...content-available-to-author-only...s.com/v0/b/sal7ly-95e68.appspot.com/o/photo-of-man-changing-tire-of-a-motorcycle-1131221.jpg?alt=media&token=914b0c14-f941-4ba3-bed3-6f312dbc017e"
                           ,
                            fit: BoxFit.cover,
                            height: 40.0,
                            width: 40.0,
                            //color: Color.fromRGBO(31, 58, 147, 1),
                          ),
                        ),
                        new Padding(padding: EdgeInsets.only(left: 12)),
                        new Column(
                          children: <Widget>[
                            new FlatButton(
                                onPressed: () {
                                  print('ay 7aga 1');
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                          new Chat(
                                              serivce_owner:
                                              messege[index]
                                                  .getservice_owner(),
                                              user: messege[index]
                                                  .getclient())));
                                  setState() {
                                    print('ay 7aga 2');
                                  }
                                },
                                child: new Text(
                                  //allMessages.keys.toList()[index],
                                  //       serivees[index].toString()
                                  messege[index].getrang().toString(),
                                  style: new TextStyle(
                                      color: Color.fromRGBO(31, 58, 147, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                            new Text(
                              messege[index].getDistance().toString(),
                              style: new TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w100),
                            ),new Row(

              children: <Widget>[
                new Padding(padding:EdgeInsets.only(left: 60) ,),
                            new Text(
                              messege[index].time,
                              style: new TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w100),
                              textAlign: TextAlign.right,
                            ),
            ])
                          ],
                        )
                      ],
                    ),
                          new Divider(),
            ])
                  ),
                ));*/
                              },


                              itemCount: messege.length,

                            );
                        }});

//
              }
            }),   bottomNavigationBar: BottomNavigationBar(
      //fixedColor: Colors.grey,
        backgroundColor: Colors.grey,
        selectedItemColor: Color.fromRGBO(31, 58, 147, 1),
        unselectedItemColor: Colors.grey,

        currentIndex: 2,
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text(
              'Home',
              style: new TextStyle(color: Colors.grey),
            ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.favorite),
            title: new Text('person', style: new TextStyle(color: Colors.grey)),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('chat', style: new TextStyle(color: Colors.grey))),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('person', style: new TextStyle(color: Colors.grey))),
        ],
        onTap: (index){

          setState(() {
            switch(index){
              case 0: {
                Navigator.of(context).pushNamed('/categories');
              }
              break;

              case 1: {

              }
              break;
              case 2: {

                //new kata()));
              }
              break;
              case 3: {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                        new Profile1(
                            "")));
              }
              break;
              default: {
                //statements;
              }
              break;

            }

          }
          );
        }));
  }


  Map<String, String> allMessages = new Map();
  List<String> serivceowner;

  //List<pair> kolha = new List();

  /*Future<String> submitAll() async {
    print('submit All');
    Stream stream = await getDataclient()
      ..asBroadcastStream();
    print('stream1 : $stream');
    stream.listen((data) {
      data.documents.forEach((doc) async {
//        setState(() async {
        Stream stream = await getDatamassage()
          ..asBroadcastStream();
        print('stream2 : $stream');
        stream.listen((data) {

          data.documents.forEach((df) {
            if (df.reference == doc["client"]) {
              allMessages[df["email"]] = doc["content"];

              //             print (df.reference.path);
            }
          });
        });
//        );
      });
    });
    /*stream
        .listen((data) => data.documents.forEach((doc) async {
      //allMessages[doc["client"]] = doc["content"].toString();

     /* Firestore.instance

          .collection('client')
          .document(doc["client"].toString())
          .snapshots()
          .listen((data) {
//          data.documents.forEach((doc) {
        //print(data.documents.length);
        if (doc["client"].toString() == data["client"].toString()) {
         // x.add(data["email"].toString());
        allMessages[data["email"]]=doc["content"].toString();
        }
      });*/
      //Firestore.instance
          //.collection('clients').reference()
          //.snapshots()
      Stream stream = await getDatamassage()..asBroadcastStream();
       stream.listen((data) => data.documents.forEach((df) {
            if(df.reference==doc["client"]){


              allMessages[df["email"]]=doc["content"];
 //             print (df.reference.path);
            }
      }));
    }));*/
    return "sucesss";
  }*/

  Future<Stream> getDataclient() async {
    Stream streamclients;
    streamclients =
        Firestore.instance.collection('clients').reference().snapshots();
    // Stream stream2 = Firestore.instance.collection("users").snapshots();
    return streamclients;

    //return StreamZip(([stream1, stream2])).asBroadcastStream();
  }


  Future<Stream> getDatamassage() async {
    Stream streammassage;
    streammassage =
        Firestore.instance.collection('massage').reference().snapshots();
    return streammassage;
  }

}

class pairr implements Comparable<pairr> {
  //List time;
  String content;
  String serivceowner;
  DocumentReference clientDocument;
  DocumentReference serviceownerDocument;
  DateTime time;
  pairr(String content, String serviceowner, DocumentReference clientt,
      DocumentReference ser,DateTime time) {
    //  this.time = time;
    this.serivceowner = serviceowner;
    this.serviceownerDocument = ser;
    this.clientDocument = clientt;
    this.content = content;
    this.time=time;
  }

  @override
  int compareTo(pairr other) {
    // TODO: implement compareTo
    return null;
  }

  String getDistance() {
    // int distancr = distance.toInt();
    return serivceowner.toString();
  }

  String getrang() {
    return content.toString();
  }

  DocumentReference getclient() {
    return clientDocument;
  }

  DocumentReference getservice_owner() {
    return serviceownerDocument;
  }
  DateTime timee(){
    return time;
  }
}
