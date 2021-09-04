import 'dart:convert';

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/constant.dart';
import 'package:weatherapp/weathermodel.dart';
import 'package:weatherapp/weathertile.dart';

class HomePage extends StatefulWidget {
  HomePage({this.city});
  String city;

  @override
  _HomePageState createState() => _HomePageState(city: city);
}

class _HomePageState extends State<HomePage> {
  String city;
  _HomePageState({this.city});

  Future<WeatherModel> fetchWeather() async {
    var requestUrl = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&APPID=43ea6baaad7663dc17637e22ee6f78f2');
    final response = await http.get(requestUrl);
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error loading request URL info");
    }
  }

  Future<WeatherModel> futureweather;
  @override
  void initState() {
    super.initState();
    futureweather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.blueGrey[900],
        body: FutureBuilder<WeatherModel>(
          future: futureweather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Container(
                    color: Colors.blueGrey[900],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data.city,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w900),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(
                            '${snapshot.data.temp.toString()}°C',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        Text(
                          "Max : ${snapshot.data.maxtemp.toString()}°C , Min : ${snapshot.data.mintemp.toString()}°C",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 10),
                      child: ListView(
                        children: [
                          WeatherTile(
                              title: 'WeatherInfo :',
                              subtitle: snapshot.data.weatherinfo.toString()),
                          WeatherTile(
                              title: 'Weather Desciption :',
                              subtitle: snapshot.data.weatherdesc.toString()),
                          WeatherTile(
                              title: 'Humidity :',
                              subtitle:
                                  '${snapshot.data.humidity.toString()} %'),
                          WeatherTile(
                              title: 'Pressure :',
                              subtitle:
                                  '${snapshot.data.pressure.toString()} hPa'),
                          WeatherTile(
                              title: 'Visibility :',
                              subtitle:
                                  '${(snapshot.data.visibility.toInt() / 1000).toString()} Km'),
                          WeatherTile(
                              title: 'Wind Speed :',
                              subtitle:
                                  '${((snapshot.data.windspeed * 18) / 5).toStringAsFixed(2)} Km/hr'),
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
            return Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          },
        ));
  }
}
