import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      title: 'Weather App',
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    ));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  var icon;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=Lagos&units=metric&appid=ab430509f663a23a2641141107784ad6'));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.icon = results['weather'][0]['icon'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            width: MediaQuery.of(context).size.width,
            color: temp > 15.0 ? Colors.red : Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Currently in Lagos',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  temp != null ? '${temp.toString()}\u00B0' : 'Loading',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 60.0,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null ? currently.toString() : 'Loading',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                ListTileTheme(
                  contentPadding: EdgeInsets.all(15.0),
                  iconColor: Colors.red,
                  child: ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text('Temperature',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.red,
                          fontWeight: FontWeight.w400,
                        )),
                    trailing: Text(
                      temp != null ? '${temp.toString()}\u00B0' : 'Loading',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: temp > 15.0 ? Colors.red : Colors.blue,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                ListTileTheme(
                  contentPadding: EdgeInsets.all(15.0),
                  iconColor: Colors.grey[400],
                  child: ListTile(
                    tileColor: Colors.lightBlue[50],
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text('Weather',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        )),
                    trailing: Text(
                        description != null
                            ? description.toString()
                            : 'Loading',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                        )),
                  ),
                ),
                ListTileTheme(
                  contentPadding: EdgeInsets.all(15.0),
                  iconColor: Colors.lightBlue,
                  child: ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text('Humidity',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.blue,
                          fontWeight: FontWeight.w400,
                        )),
                    trailing:
                        Text(humidity != null ? humidity.toString() : 'Loading',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.w300,
                            )),
                  ),
                ),
                ListTileTheme(
                  contentPadding: EdgeInsets.all(15.0),
                  child: ListTile(
                    tileColor: Colors.lightBlue[50],
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text('Wind Speed',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        )),
                    trailing: Text(
                        windSpeed != null ? windSpeed.toString() : 'Loading',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                        )),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
