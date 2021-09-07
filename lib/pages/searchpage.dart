import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weatherapp/constants/constant.dart';
import 'package:weatherapp/pages/homepage.dart';
import 'package:http/http.dart' as http;

import 'package:weatherapp/pages/iphomepage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formkey = GlobalKey<FormState>();
  String cityname;
  String ipcity;

  Future<String> getIPAddress() async {
    final url = Uri.parse('https://api64.ipify.org/?format=json');
    final response = await http.get(url);
    Map ipdata = jsonDecode(response.body);
    String _ip = ipdata["ip"].toString();

    return _ip;
  }

  Future<String> getIpcity() async {
    var requestUrl =
        Uri.parse('http://ip-api.com/json/${await getIPAddress()}');
    final response = await http.get(requestUrl);
    Map data = jsonDecode(response.body);

    String _ipcity = data["city"].toString();

    return _ipcity;
  }

  TextEditingController _cityController;
  void init() async {
    String _ipcity = await getIpcity();
    setState(() {
      ipcity = _ipcity;
    });
  }

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController();
    if (!mounted) {
      setState(() {
        init();
      });
    }
  }

  @override
  void dispose() {
    _cityController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: kAppName,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                'assets/logos/weatherapp.png',
              ),
              SizedBox(height: 30.0),
              Center(
                child: Text(
                  "Search Weather",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70),
                ),
              ),
              Center(
                child: Text(
                  "Instanly",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w200,
                      color: Colors.white70),
                ),
              ),
              SizedBox(height: 30.0),
              Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _cityController,
                      keyboardType: TextInputType.text,
                      decoration: textInputDecoration.copyWith(
                          hintText: "Enter City Name",
                          contentPadding: EdgeInsets.all(10),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.blueGrey[900],
                          )),
                      validator: (val) => val.isEmpty
                          ? 'Please enter a  valid City Name'
                          : null,
                      onChanged: (val) => setState(() => cityname = val.trim()),
                    ),
                    SizedBox(height: 5.0),
                    TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return IpHomePage(ipcity: getIpcity());
                            },
                          ),
                        )
                      },
                      // padding: EdgeInsets.only(right: 0.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            'Get weather of your location',
                            style: kLabelStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    GestureDetector(
                      onTap: () {
                        if (_formkey.currentState.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage(
                                  city: cityname,
                                );
                              },
                            ),
                          );
                        }
                        _cityController.clear();
                      },
                      child: Container(
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'SEARCH',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Citymodel {
  String city;
  Citymodel({this.city});
  factory Citymodel.fromJson(Map<String, dynamic> json) {
    return Citymodel(city: json['city'].toString());
  }
}
