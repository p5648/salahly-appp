import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salahly/loginpage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Subwarsha extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SubwarshaState();
}
class _SubwarshaState extends State<Subwarsha> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('كهربائي'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).pushNamed('/kahraba2y');
              },
            ),
            ListTile(
              title: Text('ميكانيكس'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).pushNamed('/mekaneky');
              },
            ),
            ListTile(
              title: Text('سمكري'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).pushNamed('/samkary');
              }
                ),
            ListTile(
                title: Text('رش و دوكو'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).pushNamed('/doko');
                }
            ),
            ListTile(
                title: Text('زجاج سيارات'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).pushNamed('/ezaz');
                }
            ),
            ListTile(
                title: Text('تكيفات'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).pushNamed('/takefat');
                }
            )
          ],
        ),
      ),
    );
  }
}
