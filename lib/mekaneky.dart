import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {

  @override
  _SearchPageState createState() => _SearchPageState();

}

class _SearchPageState extends State<SearchPage> {
  String searchString;
  TextEditingController  _addNameController = new TextEditingController();
  @override
  Widget build (BuildContext context) {
    return Scaffold (
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: Column(
            children: <Widget>[
              Row (
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchString = value.toLowerCase();
                          });
                        },
                        controller: _addNameController,
                      ),

                    ),
                  ),
                  RaisedButton(
                    child: Text('Add to database'),
                    onPressed: () {
                      _addToDatabase(_addNameController.text);
                    },
                  )
                ],
              ),
              Divider(),
              Expanded(
                child: Column(
                    children: <Widget> [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              searchString =value.toLowerCase();
                            });
                          },
                        ),
                      )
                    ]
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot> (
                    stream:
                    (searchString == null || searchString.trim() == "")
                        ? Firestore.instance
                        .collection('clients')
                        .snapshots()
                        : Firestore.instance
                        .collection('clients')
                        .where('searchIndex',arrayContains: searchString)
                        .snapshots(),
                    builder: (context,snapshot) {
                      if (
                      snapshot.hasError
                      )
                        return Text( 'Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center (child:  CircularProgressIndicator(),);
                        default:
                          return new ListView(
                            children: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                              return new ListTile(
                                title: new Text (document['name'].toString()),
                              );
                            }).toList(),
                          );
                      }
                    }

                ),
              )
            ] )
    );


  }
}
void _addToDatabase(String name) {
  List<String> splitList = name.split(" ");
  List<String> indexList =[];
  for (
  int i = 0; i < splitList.length; i++ ) {
    for ( int y = 1; y< splitList[i].length + 1; y++) {
      indexList.add(splitList[i].substring(0, y).toLowerCase());
    }
  }
  print(indexList);
  Firestore.instance
      .collection('clients')
      .document()
      .setData({'name':name , 'searchIndex':indexList});
}