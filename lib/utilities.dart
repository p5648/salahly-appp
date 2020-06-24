import 'package:flutter/material.dart';
import 'package:salahly/myColors.dart' as myColors;
final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.black,
  //fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans Light',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 2.0,
      //offset: Offset(0, 2),
    ),
  ],
);