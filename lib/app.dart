import 'package:flutter/material.dart';
import 'package:weather/apikey.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather/components/weather.dart';
import 'package:weather/services/cityservice.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WeatherData weather;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var weatherData = await loadWeather();
    setState(() {});
  }

  Future<String> _loadWeatherAsset() async {
    var wcity = await loadCity();
    var weatherUrl = "https://api.openweathermap.org/data/2.5/weather?q=" +
        wcity +
        ",in&appid=" +
        weatherKey;
    var res = await http.get(weatherUrl);
    return res.body.toString();
  }

  Future loadWeather() async {
    String jsonWeather = await _loadWeatherAsset();
    final jsonRes = json.decode(jsonWeather);
    WeatherData wdata = new WeatherData.fromJson(jsonRes);
    return wdata;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
