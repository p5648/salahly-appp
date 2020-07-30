//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:salahly/myColors.dart' as myColors;
//import 'package:p5salahly/location.dart';
class ChatMessage {
  String content;
  String from;
  DateTime time;
  String type;

  ChatMessage(DateTime time, String content, String from, String type) {
    this.content = content;
    this.time = time;
    this.from = from;
    this.type = type;
  }

  Map<String, dynamic> get L {
    return {"time": time, "from": from, "content": content, "type": type};
  }
}

class Chat extends StatefulWidget {
  static const String id = "CHAT";
  final DocumentReference user;
  final DocumentReference serivce_owner;

  const Chat({Key key, this.user, this.serivce_owner}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}
class _ChatState extends State<Chat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  List<Map> massee;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  String x(String sort) {
    var xm = Firestore.instance
        .collection(sort)
        .reference()
        .where('email', isEqualTo: widget.user.documentID)
        .snapshots()
        .toString();
    return xm;
  }
  Future<void> add() async {
    massee = new List();
    massee.add(new ChatMessage(DateTime.now(),
        messageController.text.toString(), "cts", "text")
        .L);
    if (messageController.text.length > 0) {
      await _firestore.collection('chat').add({
        'client': widget.user,
        'messege': massee,
        'service_owner': widget.serivce_owner,
      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }
  Future<void> callback() async {
    print('USer: ${widget.user}');
    await Firestore.instance
        .collection('chat')
        .where("client", isEqualTo: widget.user)
    .where("service_owner", isEqualTo: widget.serivce_owner)
        .snapshots()
        .listen((onData) {
      if (onData.documents.length > 0) {
        onData.documents.forEach((docc) {
            massee = List.from(docc["messege"]);
            print(widget.serivce_owner.toString());
            massee.add(new ChatMessage(DateTime.now(),
                messageController.text.toString(), "cts", "text")
                .L);
            if (messageController.text.length > 0) {
              String x = docc.documentID;
              _firestore
                  .collection('chat')
                  .document(x)
                  .updateData(({'messege': massee}));
              messageController.clear();
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              );
            }
        });
      } else {
       print(massee);
        add();
      }
    });
    /*doc.documents.forEach((docc) {
             // String x=docc.documentID.toString() ;
             time=List.from(docc["messege"]["time"]);
             content=List.from(docc["messege"]["content"]);
             from=List.from(docc["messege"]["from"]);
             time.add(DateTime.now().toIso8601String().toString());
             content.add(messageController.text.toString());
             //print(content.elementAt(1).toUpperCase());
             from.add("cts");
             if (messageController.text.length > 0) {
               String x=docc.documentID;
               _firestore.collection('conversition').document(x).updateData(({
                 'messege':new pair(time, content, from).L
               }));
               messageController.clear();
               scrollController.animateTo(
                 scrollController.position.maxScrollExtent,
                 curve: Curves.easeOut,
                 duration: const Duration(milliseconds: 300),);}
           });
         }
         else{.
           add();
         }
       });
 });*/
  }

  File image;
  String filename;
  Future _getImage() async {
    var selectedImage = await ImagePicker.pickImage(
        source: ImageSource.gallery);
    setState(() {
      image = selectedImage;
      filename = image.path;
    });


    String imj;
    StorageReference ref = FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask up= ref.putFile(image);

    String downloadUrl = await (await up.onComplete).ref.getDownloadURL();
    ref.getDownloadURL().then((file){
      setState(() {
        filename=file;
        imj=file;
        print(filename);

      });
    });
    String x;
    int r=0;
    bool flag=true;
    print(filename);
    Firestore.instance
        .collection('chat')
        .where("client", isEqualTo: widget.user)
    //.where("service_owner", isEqualTo: widget.serivce_owner)
        .snapshots()
        .listen((onData) async {

      r=onData.documents.length;
      onData.documents.forEach((docc) {
        if(docc["service_owner"]==widget.serivce_owner) {
          massee = List.from(docc["messege"]);
          // print(widget.serivce_owner.toString());

          //print("uu");
          if (flag == true) {
            if (onData.documents.length > 0) {
              print(massee.toString());
              massee.add(new ChatMessage(DateTime.now(),
                  downloadUrl, "cts", "image")
                  .L);
              _firestore
                  .collection('chat')
                  .document(docc.documentID)
                  .updateData(({'messege': massee}));
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              );
              flag = false;
            } else {
              massee = new List();
              massee.add(new ChatMessage(DateTime.now(),
                  downloadUrl, "cts", "image")
                  .L);

              Firestore.instance.collection('chat').add({
                'client': widget.user,
                'messege': massee,
                'service_owner': widget.serivce_owner,
              });

              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              );

              flag = false;
            }
          }
          x = docc.documentID;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('chat')
                    .where("client", isEqualTo: widget.user)
                .where("service_owner", isEqualTo: widget.serivce_owner)
                    .limit(1)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(backgroundColor: myColors.red,),
                    );

                  List<DocumentSnapshot> docs = snapshot.data.documents;
                  //List from=List.from()
                  List<Message> messages = new List();
                  docs.forEach((d) {

                      List from = List.from(d["messege"]);
                      /*    from.forEach((f){
                          messages.add(new Message(
                              from: from[f],
                              text: content[f],
                              me: "cts" == from[f]
                          ));
                        });*/
                      for (int i = 0; i < from.length; i++) {
                        messages.add(new Message(
                            from: from[i]["from"],
                            text: from[i]["content"],
                            me: "cts" == from[i]["from"],
                            type: from[i]["type"]),
                        );
                      }
                  });
                  return ListView(
                    controller: scrollController,
                    children: <Widget>[
                      ...messages,
                    ],
                  );
                },
              ),
            ),
            Container(
                height: 63,
                color: Color.fromRGBO(232, 232, 232, 1),
                child: Column(children: <Widget>[
                  new Padding(padding: EdgeInsets.all(3)),
                  //Expanded(child:Padding(padding: EdgeInsets.all(10),child: ,) ,),
                  Row(
                    children: <Widget>[
                      new Container(
                        width: 40,
                        child: RawMaterialButton(
                          onPressed: _getImage,
                          child: new Icon(
                            Icons.image,
                            color: Colors.grey,
                            size: 30.0,
                          ),
                          //shape: new CircleBorder(),
                          elevation: 2.0,
                          //fillColor: Color.fromRGBO(31, 58, 147, 1),
                          padding: const EdgeInsets.all(1.0),
                        ),
                      ),
                      Expanded(
                          flex: 5,
                          child: Container(
                            width: 10,
                            decoration: new BoxDecoration
                              (color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(25.0)),
                            ),
                            child: TextField(
                              textAlign: TextAlign.right,
                              onSubmitted: (value) => callback(),
                              style: new TextStyle(
                                  height: .2,
                                  backgroundColor: Colors.white),
                              decoration: InputDecoration(
                                hintText: "... اكتب هنا ",
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(25.0),
                                  ),
                                ),
                              ),
                              controller: messageController,
                            ),
                          )),
                      new Container(
                        width: 40,
                        child: SendButton(
                          text: "Send",
                          callback: callback,
                        ),
                      ),
                    ],
                  ),
                  new Padding(padding: EdgeInsets.all(3))
                ]
                )
            ),
          ],
        ),
      ),
    );
  }
}
class SendButton extends StatelessWidget {
  final String text;
  final callback;
  const SendButton({Key key, this.text, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new RawMaterialButton(
      onPressed: callback,
      child: SvgPicture.asset(
        "assets/icons/Group.svg",
        width: 30,
        height: 30,

      ),

      shape: new CircleBorder(),
      elevation: 2.0,
      //fillColor:myColors.green,
      padding: const EdgeInsets.all(5.0),
    );
  }
}

class Message extends StatelessWidget {
  final String from;
  final String text;
  final String type;
  final bool me;

  const Message({Key key, this.from, this.text, this.me,this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment:
        me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          /*  Text(
            from,
          ),*/
          new Padding(padding: EdgeInsets.all(2)),
          type=="text"?  Material(
            color: me ? myColors.red : myColors.green,
            borderRadius: BorderRadius.circular(10.0),
            elevation: 6.0,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Text(text, style:me? new TextStyle(color: Colors.white):new TextStyle(color: Colors.black))
            ),
          ): Container(
            decoration: new BoxDecoration(
              //             color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),//new Color.fromRGBO(255, 0, 0, 0.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),

            child:  Image.network(

              text,
              height: 70,
              width: 70.0,

            ),
          )
        ],
      ),
    );
  }
}

class messe {
  String messege;
}