// ignore: avoid_web_libraries_in_flutter
//import 'dart:html'as perfix;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
File image ;
String filename;
class ImagePage extends StatefulWidget {
  String idd;
  ImagePage(String id)
  {
    this.idd=id;
  }
  @override
  State<StatefulWidget> createState() => new _ImageState();
}
class _ImageState extends State<ImagePage> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xffAD0514),),
      body: Center(
        child: image == null ? Text("select the image") : _uploadArea(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: 'increment',
        child: Icon(Icons.image),
        backgroundColor:Color(0xffAD0514),
      ),
    );
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
    final StorageUploadTask up= ref.putFile(image);
      String downloadUrl = await (await up.onComplete).ref.getDownloadURL();
    ref.getDownloadURL().then((file) async {
        filename=file;
      url = downloadUrl.toString();
        print(url);
        SharedPreferences prefs2 =await  SharedPreferences.getInstance();
        prefs2.setString('profile_pic', url.toString());
      Firestore.instance.collection("clients").document(widget.idd).updateData({
        'profile_pic':url,
      });
      }
      );
      //print(downloadUrl.toString());
  }
}