import
'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
class add_delete_update_service_type extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_delete();
  }





}
class _add_delete extends State<add_delete_update_service_type> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:

      new AppBar(

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
      bottomNavigationBar: BottomNavigationBar(
        //fixedColor: Colors.grey,
          backgroundColor: Colors.grey,
          selectedItemColor: Color.fromRGBO(31, 58, 147, 1),
          unselectedItemColor: Colors.grey,

          currentIndex: 0,

          // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home,),
              title: new Text(
                'Home',
                style: new TextStyle(color: Colors.grey),
              ),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.favorite),
              title: new Text(
                  'person', style: new TextStyle(color: Colors.grey)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('chat', style: new TextStyle(color: Colors.grey)),),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text(
                    'person', style: new TextStyle(color: Colors.grey))),
          ],
          onTap: (index) {
            _onItemTapped(index);
          }
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('service_type')

              .snapshots(),
          builder:
              (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
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
                List <String> Service_type = new List();
                List <String> image = new List();
                List <String> documentid = new List();
                snapshot.data.documents.forEach((element) {
                  Service_type.add(element["name"]);
                  image.add((element["image"]));
                  documentid.add(element[element.documentID]);
                  print(element["image"]);
                });

                // List <DocumentReference> service_refernce=new List();
                return new ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return new
                      Padding(padding: EdgeInsets.all(
                          5), child:
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0)),
                            image: new DecorationImage(
                              image: new NetworkImage(image[index]),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child:
                          new Container(
                            //color: Colors.white,
                              child:
                              new Column(
                                  children: <Widget>[
                                    new Padding(
                                        padding: EdgeInsets.all(
                                            30)),

                                    new Text(
                                      Service_type[index],
                                      style: new TextStyle(
                                          color: Colors.white,

                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    new Padding(
                                        padding: EdgeInsets.all(
                                            10)),
                                    new Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius
                                                .all(
                                                Radius.circular(
                                                    15.0)),
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 4,
                                            )),
                                        child: new Column(
                                            children: <Widget>[


                                              new Padding(
                                                  padding: EdgeInsets
                                                      .all(3)),
                                              new Row(
                                                children: <Widget>[
                                                  new FlatButton(
                                                      onPressed: null,
                                                      child: new Container(
                                                        child:
                                                        new Row(
                                                          children: <Widget>[
                                                            new CircleAvatar(
                                                              child: new Icon(
                                                                  Icons
                                                                      .update),
                                                              backgroundColor: Color
                                                                  .fromRGBO(
                                                                  31, 58,
                                                                  147, 1),
                                                            ),
                                                            new Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    left: 7)),
                                                            new Text(
                                                              "update",
                                                              style: new TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                      31, 58,
                                                                      147,
                                                                      1)),
                                                            )

                                                          ],
                                                        )
                                                        ,)),
                                                  new Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 50)),
                                                  new FlatButton(
                                                      onPressed: () {
                                                        showAlertDialogdelete(
                                                            context,
                                                            documentid[index]);
                                                      },
                                                      child: new Container(
                                                        child:
                                                        new Row(
                                                          children: <Widget>[
                                                            new CircleAvatar(
                                                              child: new Icon(
                                                                  Icons
                                                                      .delete),
                                                              backgroundColor: Color
                                                                  .fromRGBO(
                                                                  31, 58,
                                                                  147, 1),
                                                            ),
                                                            new Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    left: 7)),
                                                            new Text(
                                                              "Delete",
                                                              style: new TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                      31, 58,
                                                                      147,
                                                                      1)),
                                                            )

                                                          ],
                                                        )
                                                        ,))

                                                ],
                                              ),
                                              new Padding(
                                                  padding: EdgeInsets
                                                      .all(
                                                      5)),
                                            ]))
                                  ]))));
                    });
            }
          }),


      floatingActionButton: FloatingActionButton(onPressed: () =>
      {
        showAlertDialog(context)
      }, child: new CircleAvatar(
        child: new Icon(
            Icons
                .add),
        backgroundColor: Color
            .fromRGBO(
            31, 58,
            147, 1),
      ), backgroundColor: Color
          .fromRGBO(
          31, 58,
          147, 1),),
    );
  }

  showAlertDialogdelete(BuildContext context, String f) {
    // set up the buttons
    TextEditingController x = new TextEditingController();
    Widget cancelButton = new FlatButton(

        child: new Container(
            child:
            new Row(
              children: <Widget>[
                new CircleAvatar(
                  child: new Icon(
                      Icons
                          .cancel),
                  backgroundColor: Color
                      .fromRGBO(
                      31, 58,
                      147, 1),
                ),
                new Padding(
                    padding: EdgeInsets
                        .only(
                        left: 7)),
                new Text(
                  "cancel",
                  style: new TextStyle(
                      color: Color
                          .fromRGBO(
                          31, 58,

                          147,
                          1)),
                )

              ],
            )
        ),
        onPressed: () {
          Navigator.of(context).pop();
        }
    );
    Widget continueButton = new FlatButton(
        onPressed: () {
          Firestore.instance.collection(
              "service_type"
          ).document(
              f
          ).updateData({
            "active": false
          }).then((value) => print("hhhhhhhhhhhhhh"));
        },
        child: new Container(
          child:
          new Row(
            children: <Widget>[
              new CircleAvatar(
                child: new Icon(
                    Icons
                        .delete),
                backgroundColor: Color
                    .fromRGBO(
                    31, 58,
                    147, 1),
              ),
              new Padding(
                  padding: EdgeInsets
                      .only(
                      left: 7)),
              new Text(
                "delete",
                style: new TextStyle(
                    color: Color
                        .fromRGBO(
                        31, 58,
                        147,
                        1)),
              )

            ],
          )
          ,));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "To drop servicetype write nameservicrtype", style: new TextStyle(
          color: Color
              .fromRGBO(
              31, 58,

              147,
              1), fontSize: 13),),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0))
      ),
      content: TextField(
        decoration: InputDecoration(

            hintText: 'Enter a servies_type name'

        ),
        controller: x,
      ),
      actions: [
        continueButton,
        cancelButton
      ],
    );

    // show the dialog
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  File image;

  String filename;
  var url;

  @override
  void initState() {
    super.initState();
    uploadImage();
  }

  Future _getImage() async {
    var selectedImage = await ImagePicker.pickImage(
        source: ImageSource.gallery);
    setState(() {
      image = selectedImage;
      filename = image.path;
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    TextEditingController x = new TextEditingController();
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("add"),
      onPressed: () {
        _getImage();
        Firestore.instance.collection('service_type').add({
          'name': x.text,
          "image": url
          //"https://firebasestorage.googleapis.com/v0/b/sal7ly-95e68.appspot.com/o/woman-wears-yellow-hard-hat-holding-vehicle-part-1108101.jpg?alt=media&token=4830a394-447c-4f47-80a2-e6a03e5a12d4"
        }).then((value) => print("xxxxxxxxxxxxxxxxxxxxxxxx"));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      content: Center(
        child: new Column(children: <Widget>[
          image == null ? Text("select the image") : _uploadArea(),
          FloatingActionButton(
            onPressed: () => _getImage(),
            tooltip: 'increment',
            child: Icon(Icons.image),
            backgroundColor: Color(0xffAD0514),
          ),
          TextField(
            decoration: InputDecoration(

                hintText: 'Enter a service_type name'

            ),
            controller: x,
          )
        ],),),


      /* TextField(
        decoration: InputDecoration(

            hintText: 'Enter a service_type name'

        ),
        controller: x,
      ),*/
      actions: [
        cancelButton,
        continueButton,
      ],
    );


    // show the dialog
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  Widget _uploadArea() {
    return Column(children: <Widget>[
      Image.file(image, width: double.infinity),
      RaisedButton(
        color: Color(0xffAD0514),
        child: Text("save"),
        onPressed: () {
          uploadImage();
        },
      )
    ],
    );
  }

  Future<String> uploadImage() async {
    final StorageReference ref = FirebaseStorage.instance.ref().child(filename);
    final StorageUploadTask up = ref.putFile(image);
    String downloadUrl = await (await up.onComplete).ref.getDownloadURL();
    ref.getDownloadURL().then((file) {
      setState(() {
        filename = file;
        url = downloadUrl.toString();
        print(url);
      }
      );
    }
    );
    //print(downloadUrl.toString());
  }


  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          {

          }
          break;

        case 1:
          {

          }
          break;
        case 2:
          {

          }
          break;
        case 3:
          {

          }

          break;
        default:
          {
            //statements;
          }
          break;
      }
    });
  }
}
