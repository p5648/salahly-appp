import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
class Rating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Test(),
    );
  }
}

class Test extends StatefulWidget {
  @override
  _TestState createState() => new _TestState();
}

class _TestState extends State {
  double rating = 3.5;
  int counter =0;
  double newrating =0.0;
  int starCount = 5;
  void rate()
  {
    if(counter == 0)
    {
      newrating = rating;   //new rating = 3
      counter ++;   //counter = 1
//save newrating , counter in database
    }
    else{
      newrating = (newrating *counter + rating)/(counter+1);
      counter ++ ;
//save newrating ,counter in database

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Star Rating"),
      ),
      body:
      new Column(
        children: [
          new Padding(
            padding: new EdgeInsets.only(
              top: 50.0,
              bottom: 50.0,
            ),
            child: new StarRating(
              size: 25.0,
              rating: rating,
              color: Colors.orange,
              borderColor: Colors.grey,
              starCount: starCount,
              onRatingChanged: (rating) => setState(
                    () {
                  this.rating = rating;
                  //rate();
                },
              ),
            ),
          ),
          new Text(
            "Your rating is: $rating",
            style: new TextStyle(fontSize: 30.0),
          ),
        ],
      ),
    );
  }
}