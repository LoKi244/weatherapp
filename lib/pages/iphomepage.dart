import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weatherapp/pages/searchpage.dart';
import 'package:weatherapp/models/weathermodel.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/models/weathertile.dart';

class IpHomePage extends StatefulWidget {
  Future<String> ipcity;
  IpHomePage({this.ipcity});

  @override
  _IpHomePageState createState() => _IpHomePageState(ipcity: ipcity);
}

class _IpHomePageState extends State<IpHomePage> {
  Future<String> ipcity;
  _IpHomePageState({this.ipcity});

  Future<WeatherModel> fetchWeather() async {
    var requestUrl = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${await ipcity}&units=metric&APPID=43ea6baaad7663dc17637e22ee6f78f2');
    final response = await http.get(requestUrl);
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(
            milliseconds: 3000,
          ),
          backgroundColor: Colors.blue,
          content: Text(
            'Unable to get the weather data of your location',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
      Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SearchPage();
          },
        ),
      );
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
