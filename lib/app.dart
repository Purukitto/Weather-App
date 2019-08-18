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
        weatherCity.toString() +
        ",in&appid=" +
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
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            Text(weatherData.name),
            Text(weatherData.weather[0].main),
          ],
        ),
      ),
    );
  }
}
