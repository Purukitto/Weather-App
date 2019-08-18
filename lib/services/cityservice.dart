import 'dart:async' show Future;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather/components/city.dart';

var cityUrl = "http://ip-api.com/json/";

Future<String> _loadCityAsset() async {
  var res = await http.get(cityUrl);
  return res.body.toString();
}

Future loadCity() async {
  String jsonCity = await _loadCityAsset();
  final jsonRes = json.decode(jsonCity);
  WeatherCity wcity = new WeatherCity.fromJson(jsonRes);
  return wcity.city;
}
