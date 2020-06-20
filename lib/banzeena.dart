import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:like_button/like_button.dart';

class Mapp extends StatefulWidget {
  @override
  //debugShowCheckedModeBanner: false,
  _MyHomePageState createState() => _MyHomePageState();
}
//Future<bool> onLikeButtonTapped(bool isLiked) async{
  /// send your request here
  // final bool success= await sendRequest();

  /// if failed, you can do nothing
  // return success? !isLiked:isLiked;

  //return !isLiked;
//}

class _MyHomePageState extends State<Mapp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body :  Center(
      child : LikeButton(
        size: 48.0,
        circleColor:
        CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
        bubblesColor: BubblesColor(
          dotPrimaryColor: Color(0xff33b5e5),
          dotSecondaryColor: Color(0xff0099cc),
        ),
        likeBuilder: (bool isLiked) {
          return Icon(
            Icons.home,
            color: isLiked ? Colors.deepPurpleAccent : Colors.black,
            size: 12.0,
          );
        },
        likeCount: 0,
        countBuilder: (int count, bool isLiked, String text) {
          var color = isLiked ? Colors.deepPurpleAccent : Colors.black;
          Widget result;
          if (count == 0) {
            result = Text(
              "love",
              style: TextStyle(color: color),
            );
          } else
            result = Text(
              text,
              style: TextStyle(color: color),
            );
          return result;
        },
      ),
      )
    );
  }
}
