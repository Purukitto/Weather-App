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

WeatherData weatherData;
WeatherCity weatherCity;

class _MyAppState extends State<MyApp> {
  bool isLoading = false;

  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    setState(() {
      isLoading = true; //Data is loading
    });
    var cityUrl = "http://ip-api.com/json/";
    var cityRes = await http.get(cityUrl);
    var cityDecodedJson = jsonDecode(cityRes.body);
    weatherCity = WeatherCity.fromJson(cityDecodedJson);
    print(weatherCity.city);
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
    print(weatherData.weather[0].main);
    setState(() {
      isLoading = false; //Data has loaded
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchData();
  // }

  // fetchData() async {
  //   var cityUrl = "http://ip-api.com/json/";
  //   var cityRes = await http.get(cityUrl);
  //   var cityDecodedJson = jsonDecode(cityRes.body);
  //   weatherCity = WeatherCity.fromJson(cityDecodedJson);
  //   print(weatherCity.city);
  //   var weatherUrl = "https://api.openweathermap.org/data/2.5/weather?q=" +
  //       weatherCity.city +
  //       "," +
  //       weatherCity.countryCode +
  //       "&appid=" +
  //       //Calling open weather map's API key from apikey.dart
  //       weatherKey;
  //   var res = await http.get(weatherUrl);
  //   var decodedJson = jsonDecode(res.body);
  //   weatherData = WeatherData.fromJson(decodedJson);
  //   print(weatherData.weather[0].main);
  //   setState(() {});
  // }

  // fetchData() async {
  //   var cityUrl = "http://ip-api.com/json/";
  //   var cityRes = await http.get(cityUrl);
  //   var cityDecodedJson = jsonDecode(cityRes.body);
  //   weatherCity = WeatherCity.fromJson(cityDecodedJson);
  //   print(weatherCity);
  //   fetchWeather();
  // }

  // fetchWeather() async {
  //   var weatherUrl = "https://api.openweathermap.org/data/2.5/weather?q=" +
  //       weatherCity.city +
  //       "," +
  //       weatherCity.countryCode +
  //       "&appid=" +
  //       //Calling open weather map's API key from apikey.dart
  //       weatherKey;
  //   var res = await http.get(weatherUrl);
  //   var decodedJson = jsonDecode(res.body);
  //   weatherData = WeatherData.fromJson(decodedJson);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Drawer(),
      appBar: AppBar(
        title: isLoading
            ? Center(child: CircularProgressIndicator())
            : Text(weatherData.name),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
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
