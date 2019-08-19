import 'package:flutter/material.dart';
import 'package:weather/components/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather/components/city.dart';
import 'package:weather/components/geticon.dart';
import 'package:weather/apikey.dart'; //to call api key

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

WeatherData weatherData;
WeatherCity weatherCity;
IconData newIcon;

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
    //TODO: TEST WITH LOCATION ACCURACY
    var cityUrl = "http://ip-api.com/json/";
    var cityRes = await http.get(cityUrl);
    var cityDecodedJson = jsonDecode(cityRes.body);
    weatherCity = WeatherCity.fromJson(cityDecodedJson);

    //TODO: TEST
    //weatherCity.city = 'Chennai';
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

    //TODO: TEST
    //weatherData.weather[0].main = 'LOL';

    newIcon = getIcon(weatherData.weather[0].main);
    setState(() {
      isLoading = false; //Data has loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Colors.black,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                fetchData();
              },
              child: Icon(Icons.refresh),
            ),
            drawer: Drawer(),
            appBar: AppBar(
              title: Text(weatherData.name),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Column(
              children: <Widget>[
                Container(
                  height: 100,
                ),
                Center(
                  child: Text(
                    weatherData.weather[0].main,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Center(
                  child: Text(
                    weatherData.weather[0].description,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  height: 50,
                ),
                new Icon(
                  newIcon,
                  color: Colors.white,
                  size: 50,
                ),
              ],
            ),
          );
  }
}
