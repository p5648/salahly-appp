import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salahly/choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
List <String> cc = new List();
class ClientSearch extends StatefulWidget {
  List <String> recieve = new List();
  List <String> recieve2 = new List();
  String selected ;
  GeoPoint zz2;ClientSearch(List <String> rec , List<String> rec2,GeoPoint zz)
  {
    this.recieve = rec;
    this.recieve2 = rec2;
    this.zz2 = zz;
  }


  @override
  State<StatefulWidget> createState() => new _WenshState();
}
class _WenshState extends State<ClientSearch> {
  @override
  TextEditingController searchController = new TextEditingController();
  List  <Pair2> searchList =new List();
  List <Pair2>result = new List();
  List <Pair2>searchList2 = new List();
  List <String>result3 = new List();
  String selected ;
  double calculateDistance(lat1, lat2,lon1 ,lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;

    return 12742 * asin(sqrt(a));
  }
  //cc =widget.recieve;
  //List  <String> searchList2 =new List();
  Widget build(BuildContext context) {
    void _addToDatabase(String name) {
      //List<String> splitList = name.split(" ");
      List<String> indexList = [];
      print(indexList);
      result = new List();
      searchController.text = name;
      for( int i = 0 ; i < searchList.length ; i ++ )
      {
        if(searchList[i].getname().contains(name) || searchList[i].getspec().contains(name) || searchList[i].serviceReturn().contains(name))
        {
          result.add(new Pair2(searchList[i].getname(),searchList[i].getspec(),
              searchList[i].serviceReturn(),searchList[i].getRating(),searchList[i].getlat(),
              searchList[i].getalang(),searchList[i].getDistance2()));
        }
      }
    }
    cc=widget.recieve;
    //GeoPoint.(name: "Position", point: LatLng(51.0,0.0));
    //widget.zz2.latitude = 2222.2;
    //widget.zz2.longitude = 225.5;
    return Scaffold(
        body: Center(
            child: new StreamBuilder(
                stream: Firestore.instance.collection('service').snapshots(),
                builder:
                    (context, AsyncSnapshot snapshot2) {
                  //var doc1 = snapshot.data;
                  if (!snapshot2.hasData)
                    return new Text(
                      'Error: ${snapshot2.error.toString()}',
                      textDirection: TextDirection.ltr,
                    );
                  switch (snapshot2.connectionState) {
                    case ConnectionState.waiting:
                      return new Text(
                        'Loading...',
                        textDirection: TextDirection.ltr,
                      );
                    default:
                      return StreamBuilder(
                          stream: Firestore.instance.collection('specialization')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot snapshot3) {
                            //var doc = snapshot.data;
                            if (!snapshot3.hasData)
                              return new Text(
                                'Error: ${snapshot3.error.toString()}',
                                textDirection: TextDirection.ltr,
                              );
                            switch (snapshot3.connectionState) {
                              case ConnectionState.waiting:
                                return new Text(
                                  'Loading...',
                                  textDirection: TextDirection.ltr,
                                );

                              default:
                                String gh(String gh){
                                  String g;
                                  for(int i=0;i<widget.recieve.length;i++){
                                    if(gh==widget.recieve[i]){
                                      g=widget.recieve2[i];
                                    }

                                  }
                                  return g;
                                }
                                searchList = new List();

                                if(widget.zz2==null){
                                  widget.zz2=new GeoPoint(34, 44);
                                }
                                //fg =new GeoPoint(2344, 44);

                                snapshot2.data.documents.forEach((element) {
                                  snapshot3.data.documents.forEach((data) {{
                                    if (element["specialization"] == data.reference ) {
                                      GeoPoint x = element["location"];
                                      GeoPoint fg=widget.zz2 as GeoPoint;
                                      searchList.add(new Pair2(
                                          element["name"].toString(),
                                          data["name"].toString(),
                                          gh(data["service_type"].toString()),
                                          element["rating"],
                                      x.latitude ,x.longitude ,calculateDistance(widget.zz2.latitude,widget.zz2.longitude, x.latitude, x.longitude) )
                                      );
                                    }
                                    result3.add(data["service_type"].toString());
                                  }
                                  }
                                  );
                                }
                                );
                                //snapshot2.data.documents.forEach((element) {
                                //if(element["service_type"] == searchList.contains(element["service_type"].toString()));
                                searchList2 = new List();
                            /*   for( int i =0 ;i<searchList.length;i++)
                                {
                                  for(int j =0;j<widget.recieve.length;j++)
                                  {
                                    if(searchList[i].serviceReturn().toString() == widget.recieve[j].toString())
                                    {
                                      searchList2.add(new Pair2(searchList[i].getname(), searchList[i].getspec(), widget.recieve2[j].toString(),searchList[i].getRating()));

                                    }
                                  }
                                }*/
                            }
                            return Column(
                                children: <Widget>[
                                  Divider(),
                                  Expanded(
                                    child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: TextFormField(
                                              controller: searchController,
                                              onChanged:(value) {
                                                setState(() {
                                                  _addToDatabase(value.toLowerCase());
                                                });
                                              },
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.all(6.0)),
                                          DropdownButton<String>(
                                            items: <String>['distance', 'Rating'].map((String value) {
                                              return new DropdownMenuItem<String>(
                                                value: value,
                                                child: new Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (currentValue) {
                                              setState(() {
                                                selected = currentValue;
                                                if(selected == "Rating") {
                                                  result.sort();
                                                }
                                                else if (selected == "distance" )
                                                  {
                                                    Comparator<Pair2> priceComparator = (a, b) => a.getDistance2().compareTo(b.getDistance2());
                                                     result.sort(priceComparator);
                                                  }
                                              });
                                            },
                                          ),
                                          OutlineButton(onPressed:()=> Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                new Map(widget.recieve,widget.recieve2
                                                )),
                                          ))
                                        ]
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: result.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: Text(result[index].getname().toString()),
                                            subtitle: Text(result[index].getspec().toString() + "   " +  result[index].serviceReturn().toString() +"   " +  result[index].getRating().toString()),
                                          );
                                        }
                                      //if (index < length) {
                                      //return new Container(
                                    ),

                                  )
                                ]
                            );
                          }
                      );
                  }
                }
            )
        )
    );
  }
}

class Pair2 implements Comparable<Pair2> {
  double distance;
  double Rating ;
  double lat;
  String Servicee;
  double lang;
  String placemark;
  String name;
  DocumentReference Re;
  String phone;
  String spec ;
  String toString() => "${name}";
  DocumentReference reference() {
    return Re;
  }
  Pair2(String name,String t,String servicetype,double Rate,double lat1,double lang1,double distance1) {
    this.spec = t ;
    this.lat = lat1;
    this.lang = lang1;
    this.distance = distance1;
    this.name = name;
    this.Servicee = servicetype;
    this.Rating = Rate;
  }

  @override
  int compareTo(Pair2 p) {
    // TODO: implement compareTo
    if (this.Rating > p.Rating)
      return -1;
    else
      return 1;
  }
  String getname(){
    return name;
  }
  String getspec(){
    return spec;
  }String serviceReturn()
  {
    return Servicee;
  }
  double getRating()
  {
    return Rating;
  }
  double getDistance2()
  {
    return distance;
  }
  double getalang()
  {
    return lang;
  }
  double getlat()
  {
    return lat;
  }
/*String rex2()
  {
    for(int i  =0 ;i< )

  }*/
}