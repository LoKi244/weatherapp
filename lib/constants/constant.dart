import 'package:flutter/material.dart';

Text kAppName = Text(
  "WeatherApp",
  style: TextStyle(
    fontFamily: 'Pacifico',
    fontSize: 28,
    color: Colors.white,
  ),
);

Text kAppLogoName = Text(
  "WeatherApp",
  style: TextStyle(
    fontFamily: 'Pacifico',
    fontSize: 45,
    color: Colors.white,
  ),
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);
const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2.0),
  ),
);
