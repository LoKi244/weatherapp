import 'package:flutter/material.dart';

class WeatherTile extends StatelessWidget {
  String title;
  String subtitle;
  WeatherTile({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
            color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600),
      ),
    );
  }
}
