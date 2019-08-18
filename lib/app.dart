import 'package:flutter/material.dart';
import 'package:weather/components/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather/components/city.dart';
import 'package:weather/apikey.dart'; //to call api key

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WeatherData weatherData;
  WeatherCity weatherCity;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  var cityUrl = "http://ip-api.com/json/";

  fetchData() async {
    var cityRes = await http.get(cityUrl);
    var cityDecodedJson = jsonDecode(cityRes.body);
    weatherCity = WeatherCity.fromJson(cityDecodedJson);
    var weatherUrl = "https://api.openweathermap.org/data/2.5/weather?q=" +
        weatherCity.city +
        "," +
        weatherCity.countryCode +
        "&appid=" +
        //Calling open weather map's API key from apikey.dart
        weatherKey;
    var res = await http.get(weatherUrl);
    var decodedJson = jsonDecode(res.body);
    weatherData = WeatherData.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Drawer(),
      appBar: AppBar(
        title: Text(weatherData.name),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
            child: Container(
              height: 100,
              child: Text(
                weatherData.weather[0].main,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 50,
              child: Text(
                weatherData.weather[0].description,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
