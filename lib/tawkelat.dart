import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
List <DocumentReference>recieve = new List();
List <String>recieve2 = new List();
  Future getclients() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("clients").getDocuments();
    return qn.documents;
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(),
      body:Container(
        child: new StreamBuilder(
            stream: Firestore.instance.collection('clients').document("4i4Ohko0YQlZZ0mtaP2K").snapshots(),
            builder:
    ( context, AsyncSnapshot snapshot) {
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
      var doc = snapshot.data;
    //List<String> ser = new List();
    //List<DocumentReference> serrefernc = new List();
    recieve = List.from(doc["favourite_services"]);
    return StreamBuilder(
    stream: Firestore.instance.collection('service').snapshots(),
    builder:
    ( context, AsyncSnapshot snapshot) {
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
      for(int i =0 ; i < recieve.length;i++) {
        snapshot.data.documents.forEach((DocumentSnapshot doc) {
          if (recieve[i] == doc.reference)
            {
              recieve2.add(doc["name"]);
            }
        });
      }

    return new Container(
      child : Center(
     child  :  ListView.builder(
    itemBuilder: (context, index) {
    return new Text(
    recieve2[index].toString(),textDirection: TextDirection.ltr,
    );
    },
    itemCount: recieve2.length,
    )
    )
    );
    }});
    }})
    )
    );
  }
}